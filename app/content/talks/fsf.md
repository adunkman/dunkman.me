---
title: "Beyond The Tab: Executing JavaScript Across Browser Contexts"
date: "2016-09-09"
summary: Keeping JavaScript from interfering across tabs is great, but what about when a web application wants to share state without a server? You’ll leave this talk with enough knowledge to get started with SharedWorkers, ServiceWorkers, and other techniques and enough wisdom to know when to use them.
---

This talk covered sharing state between tabs — and I’ve released a set of [minimalist code samples on GitHub](https://github.com/adunkman/client-side-sync-examples) to demonstrate every particular way I can think of to do this. I don’t believe the slides for this talk are particularly useful, but [the slides are available on Speaker Deck](https://speakerdeck.com/adunkman/beyond-the-tab-executing-javascript-across-browser-contexts-at-full-stack-fest).

**Browser Support:** Check [Jake Archibald](https://twitter.com/jaffathecake)’s excellent site, [Is ServiceWorker Ready?](https://jakearchibald.github.io/isserviceworkerready/) for browser compatibility information.

**Push Notifications:** The [demo for push notifications shown during the talk is available on GitHub](https://github.com/gauntface/simple-push-demo). For more information about sending notifications to users through the Push API, check out [Using the Push API](https://developer.mozilla.org/en-US/docs/Web/API/Push_API/Using_the_Push_API) on MDN.

**Background Sync:** For more information on [syncing web applications in the background, see this blog post on developers.google.com](https://developers.google.com/web/updates/2015/12/background-sync), complete with a link to a chameleon popping bubbles.

**ServiceWorker Demos:** For more [demos of usage possibilities of ServiceWorker, see w3c-webmob/ServiceWorkersDemo](https://github.com/w3c-webmob/ServiceWorkersDemos) on GitHub.

**Microsoft Edge:** Many of the examples given in this talk were not available for use in Microsoft Edge. Their [platform status, including ServiceWorker](https://developer.microsoft.com/en-us/microsoft-edge/platform/status/serviceworker) is publicly available.

**Browser Sandboxes:** For more information about browser sandboxes, check out the [Chromium Sandbox Documentation](https://www.chromium.org/developers/design-documents/sandbox) (Chromium is the open-source project behind Google Chrome and ChromeOS) and [The Security Architecture of the Chromium Browser](https://seclab.stanford.edu/websec/chromium/chromium-security-architecture.pdf).

Thanks for listening!
