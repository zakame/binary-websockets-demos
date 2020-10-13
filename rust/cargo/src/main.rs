extern crate ws;

use ws::util::Token;
use ws::{connect, CloseCode, Handler, Handshake, Message, Result, Sender};

const URL: &str = "wss://ws.binaryws.com/websockets/v3?app_id=1089";

struct Client {
    ws: Sender,
}

impl Handler for Client {
    fn on_open(&mut self, _: Handshake) -> Result<()> {
        (self.ws.send("{\"ticks\": \"R_100\"}"))?;
        self.ws.timeout(10_000, Token(1))
    }

    fn on_timeout(&mut self, _: Token) -> Result<()> {
        self.ws.close(CloseCode::Away)
    }

    fn on_message(&mut self, msg: Message) -> Result<()> {
        println!("ticks update: {}", msg);
        Ok(())
    }
}

fn main() {
    connect(URL, |ws| Client { ws }).unwrap()
}
