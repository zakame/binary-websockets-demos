#!/usr/bin/env perl
use Mojo::Base -strict, -signatures;
use Mojo::JSON;
use Mojo::Promise;
use Mojo::UserAgent;

my $url = 'wss://ws.binaryws.com/websockets/v3?app_id=1089';

my $promise = Mojo::Promise->new;

$promise->ioloop->timer(10 => sub { $promise->resolve });

Mojo::UserAgent->new->websocket_p($url)->then(sub ($tx) {
  $tx->on(
    message => sub ($tx, $msg) {
      if (my $error = Mojo::JSON::decode_json($msg)->{error}) {
        return $promise->reject("API Error: $error->{message}");
      }
      say "ticks update: $msg";
    }
  );

  $tx->send({json => {ticks => 'R_100'}});

  $promise;
})->catch(sub ($err) { say "WebSocket error: $err" })->wait;
