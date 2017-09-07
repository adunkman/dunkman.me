---
layout: blog
title: "Zero Units in CSS: Duration, Frequency, Resolution Require Units"
summary: In most cases, the value zero does not require units to be specified in CSS, however, this is not the case when using non-length and non-angle units.
category: blog
---

CSS doesn’t usually require zeros to have units — because zero is zero, regardless of units. Since these are all equivalent, the unitless version is often used:

```css
padding: 0px; /*✅*/
padding: 0pt; /*✅*/
padding: 0em; /*✅*/
padding: 0rem;/*✅*/

padding: 0;   /*✅*/
```

This works for all length-based units and angle-based units (0 degrees and 0 radians), but does not work other types of values.

<p class="lede">The CSS spec requires units to be specified for duration, frequency, and resolution values — even for zero.</p>

This means that, although leaving units off a zero for transitions seems to be correct, it is in fact invalid:

```css
transition: opacity 0 ease; /*❌*/
transition: opacity 0s ease;/*✅*/
```

Quirky! For further reading, see [CSS Values and Units Module Level 3, Sections 5 and 6](https://www.w3.org/TR/css-values/#lengths).
