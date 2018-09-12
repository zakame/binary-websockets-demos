#!/usr/bin/env perl
use Mojo::Base -strict;
use Mojo::UserAgent;    # with Mojo::IOLoop

my $ua = Mojo::UserAgent->new;
my $id = $ua->websocket(
  'wss://ws.binaryws.com/websockets/v3?app_id=1089' => sub {
    my ($ua, $tx) = @_;
    unless ($tx->is_websocket) {
      say "WebSocket handshake failed!";
      if (my $err = $tx->error) {
        say 'Connection error: ', $err->{message};
      }
      $tx->closed;
      return;
    }

    $tx->on(
      message => sub {
        my ($tx, $msg) = @_;
        say "ticks update: ", $msg;
      }
    );

    Mojo::IOLoop->timer(10 => sub { $tx->finish });

    $tx->send({json => {ticks => 'R_100'}});
  }
);

Mojo::IOLoop->start;
