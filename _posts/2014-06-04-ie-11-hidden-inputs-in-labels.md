---
layout: article
title: "IE 11: Hidden Inputs in Labels"
category: articles
---

<style>{% asset posts/2014-06-04-ie-11-hidden-inputs-in-labels.css %}</style>

I discovered today an interesting “bug” in Internet Explorer 11 (and Edge!*) today that hopefully you’ll never come across:

```html
<label>
  Some label text
  <input type="checkbox">
</label>
```

The above works fine — clicking anywhere on the label, including the text, checks and unchecks the checkbox. However:

```html
<label>
  Some label text
  <input type="hidden">
  <input type="checkbox">
</label>
```

The above no longer works in IE 11. It appears that the click event is being sent to **the first** input within the label, even if that input is `type="hidden"`.

All you Rails folks watch out — you may or may not know, but the Rails form checkbox helpers generate hidden inputs automatically.

Hopefully you won’t waste an hour and a half like I did! :)

\* **Update, June 24, 2016:** [@HerrSerker](https://twitter.com/HerrSerker) reports that the same behavior is present in Microsoft Edge.

<div class="tweet">
  <blockquote class="twitter-tweet" data-cards="hidden" data-lang="en"><p lang="en" dir="ltr"><a href="https://twitter.com/adunkman">@adunkman</a> (<a href="https://t.co/EvRHCzuCfk">https://t.co/EvRHCzuCfk</a>)<br>Thanks for that. The new Microsoft Edge browser poses the same behaviour</p>&mdash; yunzen (@HerrSerker) <a href="https://twitter.com/HerrSerker/status/746345625676021760">June 24, 2016</a></blockquote>
  <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
</div>
