import websocket
import json
import time
from threading import Thread


def on_message(ws, msg):
    print("ticks update: %s" % msg)


def on_open(ws):
    def run():
        ws.send(json.dumps({'ticks': 'R_100'}))
        time.sleep(10)
        ws.close()
    Thread(target=run).start()


if __name__ == "__main__":
    apiUrl = "wss://ws.binaryws.com/websockets/v3?app_id=1089"
    ws = websocket.WebSocketApp(apiUrl,
                                on_message=on_message,
                                on_open=on_open)
    ws.run_forever()
