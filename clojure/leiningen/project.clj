(defproject binaryws "0.1.0-SNAPSHOT"
  :description "Binary.com WebSockets demo in Clojure (leiningen)"
  :url "https://developers.binary.com/demos/"
  :dependencies [[org.clojure/clojure "1.8.0"]
                 [stylefruits/gniazdo "1.0.1"]
                 [cheshire "5.8.0"]]
  :main ^:skip-aot binaryws.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
