---
layout: blog
title: "IE 11: Hidden Inputs in Labels"
summary: Internet Explorer and Edge do not always focus inputs within label elements when the label is clicked and a hidden input is present.
category: blog
redirect_from:
  - /articles/ie-11-hidden-inputs-in-labels.html
---

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

\* **Update, June 24, 2016:** [@HerrSerker reports](https://twitter.com/HerrSerker/status/746345625676021760) that the same behavior is present in Microsoft Edge.
