require 'faye/websocket'
require 'eventmachine'
require 'json'

EM.run do
  api_url = 'wss://ws.binaryws.com/websockets/v3?app_id=1089'
  ws = Faye::WebSocket::Client.new(api_url)

  ws.on :open do
    ws.send(JSON.generate(ticks: 'R_100'))
  end

  ws.on :message do |msg|
    printf "ticks update: %s\n", msg.data
  end

  EM.add_timer(10) do
    EM.stop_event_loop
  end
end
