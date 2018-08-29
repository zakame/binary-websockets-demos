# Binary.com Websockets Demos

This repository contains the demos described briefly in
https://developers.binary.com/demos/ but includes the necessary tooling
for building the sample in some languages, particularly JVM-based
languages.

All the demos here implement this basic specification:

- open a stream of ticks for the Volatility 100 Index
- for each tick in the next 10 seconds, emit a "ticks update: " with
  this data to standard output

Please see the specific language directories for more information on
building and running the demos.
