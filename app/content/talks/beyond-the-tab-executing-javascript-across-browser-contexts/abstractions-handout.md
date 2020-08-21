---
title: "Beyond The Tab: Executing JavaScript Across Browser Contexts"
date: "2016-08-19"
summary: Keeping JavaScript from interfering across tabs is great, but what about when a web application wants to share state without a server? You’ll leave this talk with enough knowledge to get started with SharedWorkers, ServiceWorkers, and other techniques and enough wisdom to know when to use them.
aliases:
  - /talks/crosstab
---

This talk presented a number of [minimalist code samples for cross-tab communication, which are available on GitHub](https://github.com/adunkman/client-side-sync-examples). I don’t believe the slides for this talk are particularly useful, but [the slides are available on Speaker Deck](https://speakerdeck.com/adunkman/beyond-the-tab-executing-javascript-across-browser-contexts-at-abstractions).

**Browser Sandboxes:** For more information about browser sandboxes, check out the [Chromium Sandbox Documentation](https://www.chromium.org/developers/design-documents/sandbox) (Chromium is the open-source project behind Google Chrome and ChromeOS) and [The Security Architecture of the Chromium Browser](https://seclab.stanford.edu/websec/chromium/chromium-security-architecture.pdf).

**Push Notifications:** The [demo for push notifications shown during the talk is available on GitHub](https://github.com/gauntface/simple-push-demo). For more information about sending notifications to users through the Push API, check out [Using the Push API](https://developer.mozilla.org/en-US/docs/Web/API/Push_API/Using_the_Push_API) on MDN.

**ServiceWorker Demos:** For more [demos of usage possibilities of ServiceWorker, see w3c-webmob/ServiceWorkersDemo](https://github.com/w3c-webmob/ServiceWorkersDemos) on GitHub.

**Background Sync:** For more information on [syncing web applications in the background, see this blog post on developers.google.com](https://developers.google.com/web/updates/2015/12/background-sync).

**Microsoft Edge:** Many of the examples given in this talk were not available for use in Microsoft Edge. Their [platform status, including ServiceWorker](https://developer.microsoft.com/en-us/microsoft-edge/platform/status/serviceworker) is publicly available.

Thanks for listening!
