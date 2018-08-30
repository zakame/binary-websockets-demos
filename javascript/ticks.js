const WebSocket = require('ws');

const ws = new WebSocket('wss://ws.binaryws.com/websockets/v3?app_id=1089');
setTimeout(function timeout() {
    ws.close();
}, 10000);

ws.onopen = function open() {
    ws.send(JSON.stringify({
        ticks: 'R_100'
    }));
};

ws.onmessage = function incoming(msg) {
    console.log("ticks update:", msg.data);
};
