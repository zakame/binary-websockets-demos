(ns binaryws.core
  (:require [gniazdo.core :as ws]
            [cheshire.core :refer :all])
  (:gen-class))

(defn -main
  "Open a websocket and request ticks for symbol `R_100`."
  [& args]
  (def socket
    (ws/connect "wss://ws.binaryws.com/websockets/v3?app_id=1089"
      :on-receive #(prn (parse-string %))))
  (ws/send-msg socket (generate-string {:ticks "R_100"}))
  (Thread/sleep 10000)
  (ws/close socket))
