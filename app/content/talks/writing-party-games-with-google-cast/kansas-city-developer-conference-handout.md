---
title: "Writing Party Games with Chromecast"
date: "2017-08-03"
summary: The Chromecast, an underpowered computer running the Chrome browser, is often underutilized as a gaming device. This talk taught you to write a party game, leveraging your guests’ phones as game controllers and your TV as a game board, using only the HTML, JavaScript, and CSS. No app required.
aliases:
  - /talks/kcdc-cast
---

This talk presented a Chromecast game based on word origins — the source of this application is in two parts.

1. [A Rails app](https://github.com/adunkman/chromecast-game) which served the front-end and handled storing game data.

2. [A Node.js app](https://github.com/adunkman/chromecast-game-socket) which used Hapi and Nes to handle maintaining open websockets with clients and relaying messages from the Rails app.

The [slides](https://speakerdeck.com/adunkman/writing-party-games-with-google-cast-at-kansas-city-developer-conference) are also available, should you find them useful!

## Getting Started

The best way to get started in my opinion is to follow the official [Getting Started guides](https://developers.google.com/cast/docs/overview), specifically the [Custom Receiver guide](https://developers.google.com/cast/docs/web_receiver/basic).

{{<figure-video format="widescreen" src="https://www.youtube.com/embed/QZ6scX0NPDk?rel=0&amp;showinfo=0">}}

Don’t forget to register your account, devices, and applications in the [Google Cast SDK Developer Console](https://cast.google.com/publish/) early!

Thanks for listening!
