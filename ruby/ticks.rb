require 'faye/websocket'
require 'eventmachine'
require 'json'

EM.run {
  ws = Faye::WebSocket::Client.new('wss://ws.binaryws.com/websockets/v3?app_id=1089')

  ws.on :open do
    ws.send(JSON.generate({ticks: 'R_100'}))
  end

  ws.on :message do |msg|
    printf "ticks update: %s\n", msg.data
  end

  EM.add_timer(10) do
    EM.stop_event_loop
  end
}
