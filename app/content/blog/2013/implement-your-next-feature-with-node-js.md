---
title: "Implement your next feature with Node.js: JavaScript in polyglot systems"
date: "2013-08-15"
summary: A summary of a conference talk focused on encouraging the use of Node.js to implement features which make sense to do so (and leaving the rest of your application alone).
aliases:
  - /conferences/implement-your-next-feature-with-node-js.html
  - /blog/2013/implement-your-next-feature-with-node-js.html
---

> This is a summary of a talk given at [KCDC 2013](http://kcdc.info/).

Have you seen one of those new-fangled node.js real-time web applications and wonder how to get that special sauce into your project, without being forced to convert it all to node.js? Wouldn’t it be great if you could keep your existing system for what it’s good at to avoid expensive rewrites?

Well, you can!

## Intelligent boundaries

When talking about implementing a web application in multiple languages, there will always be a boundary where the two (or more) languages meet. Choosing where this boundary lies is important — and I have found it usually lies along a boundary in the domain of your problem.

For example, if you’re implementing a blog (cliché, I know), then it might be a smart decision to divide your app along the concept of comments. Perhaps the blog itself will be statically compiled using Jekyll, but the commenting system is written in node.js using socket.io to relay comments as-they-happen back to the browser.

## Boundary communication

One of the most important parts of polyglot programming (if not the most important) is how communication happens across the boundaries drawn between parts.

The popular choice is certainly JSON payloads over HTTP REST, but as long as all parts can understand the method and language, it doesn’t really matter. A human-readable transport is usually preferred for debugging purposes.

### Evented communication

If there are plans of realtime features, it’s important to think about how the different parts of your app will communicate events.

There are a number of messaging systems available, but in my experience, two really stand out: [RabbitMQ](http://www.rabbitmq.com/) and [Redis Pub/Sub](http://redis.io/commands#pubsub). RabbitMQ is very robust — it has a lot of features that enable advanced routing and statistics; in contrast, Redis is very simple and easy to wrap your head around (and, it’s frequently installed on developer boxes already!).

## Gluing it together

When it comes time to actually present your application to the public, you’ll likely want to show off your work through a reverse proxy. As opposed to a forward proxy which a client uses knowingly to access the Internet, a reverse proxy is usually transparent to the user and acts as a router of requests through a network of servers. For a recommendation, [nginx](http://nginx.org/en/) is an excellent reverse proxy server.

## But wait… isn’t this just [SOA](http://en.wikipedia.org/wiki/Service-oriented_architecture)?

Yeah, pretty much.

> **Note:** I went through the creation of the [Node Labs](https://web.archive.org/web/20170731162409/http://nodelabs.org/) site as a part of this talk. The content of the pages are statically hosted on GitHub Pages, but the site has interactive features which are controlled via client-side scripting. The interactive features are run with socket.io on node.js, using a MongoDB backend.
