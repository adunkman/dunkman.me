---
layout: blog
title: Messaging using RabbitMQ and Socket.io
summary: A code snippet to relay messages from a RabbitMQ server to a browser in realtime, using socket.io and Node.js.
category: blog
redirect_from:
  - /code/messaging-using-rabbitmq-socketio.html
---

A code snippet to relay messages from a RabbitMQ server to a browser in realtime, using [socket.io](http://socket.io) and [node.js](http://nodejs.org).

## Client

Throw this in a HTML file and load it up in your favorite web browser:

```html
<!DOCTYPE html>
<html>
  <head>
    <script src="/socket.io/socket.io.js"></script>
    <script>
      (function () {

        var onMessage = function (data) {
          // Do something with the message data
        };

        var connectToServer = function () {
          var socket = io.connect('http://localhost:8080');
          socket.on('message-name', onMessage);
        };

        connectToServer();

      })();
    </script>
  </head>
  <body>
  </body>
</html>
```

## Server

Throw this in a JavaScript file and run it with node.js:

```javascript
var amqp = require('amqp');
var express = require('express');
var app = express.createServer();
var io = require('socket.io').listen(app);
var rabbitMq = amqp.createConnection({ host: 'rabbitmq-host.com' });

app.configure(function () {
  app.use(express.static(__dirname + '/public'));
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

rabbitMq.on('ready', function () {
  io.sockets.on('connection', function (socket) {
    var queue = rabbitMq.queue('my-queue');

    queue.bind('#'); // all messages

    queue.subscribe(function (message) {
      socket.emit('message-name', message);
    });
  });
});

app.listen(8080);
```
