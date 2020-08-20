---
title: "Zero units in CSS: duration, frequency, resolution require units"
date: "2017-09-07"
summary: In most cases, the value zero does not require units to be specified in CSS, however, this is not the case when using non-length and non-angle units.
aliases:
  - /blog/2017/css-zero-length-units.html
---

CSS doesn’t usually require zeros to have units — because zero is zero, regardless of units. Since these are all equivalent, the unitless version is often used:

```css
{
  padding: 0px;  /* ✅ */
  padding: 0pt;  /* ✅ */
  padding: 0em;  /* ✅ */
  padding: 0rem; /* ✅ */

  padding: 0;    /* ✅ */
}
```

This works for all length-based units and angle-based units, but does not work other types of values. The CSS spec requires units to be specified for duration, frequency, and resolution values — even for zero.

### [Length units](https://www.w3.org/TR/css-values/#lengths)

| Unit   | Zero (with unit) | Zero (without unit) |
|--------|------------------|---------------------|
| `em`   | `0em`            | `0`                 |
| `ex`   | `0ex`            | `0`                 |
| `ch`   | `0ch`            | `0`                 |
| `rem`  | `0rem`           | `0`                 |
| `vw`   | `0vw`            | `0`                 |
| `vh`   | `0vh`            | `0`                 |
| `vmin` | `0vmin`          | `0`                 |
| `vmax` | `0vmax`          | `0`                 |
| `cm`   | `0cm`            | `0`                 |
| `mm`   | `0mm`            | `0`                 |
| `Q`    | `0Q`             | `0`                 |
| `in`   | `0in`            | `0`                 |
| `pc`   | `0pc`            | `0`                 |
| `pt`   | `0pt`            | `0`                 |
| `px`   | `0px`            | `0`                 |

### [Angle units](https://www.w3.org/TR/css-values/#angles)

| Unit   | Zero (with unit) | Zero (without unit) |
|--------|------------------|---------------------|
| `deg`  | `0deg`           | `0`                 |
| `grad` | `0grad`          | `0`                 |
| `rad`  | `0rad`           | `0`                 |
| `turn` | `0turn`          | `0`                 |

### [Duration units](https://www.w3.org/TR/css-values/#time)

| Unit   | Zero (with unit) | Zero (without unit) |
|--------|------------------|---------------------|
| `s`    | `0s`             | ❌                  |
| `ms`   | `0ms`            | ❌                  |

### [Frequency units](https://www.w3.org/TR/css-values/#frequency)

| Unit   | Zero (with unit) | Zero (without unit) |
|--------|------------------|---------------------|
| `Hz`   | `0Hz`            | ❌                  |
| `kHz`  | `0kHz`           | ❌                  |

### [Resolution units](https://www.w3.org/TR/css-values/#resolution)

| Unit   | Zero (with unit) | Zero (without unit) |
|--------|------------------|---------------------|
| `dpi`  | `0dpi`           | ❌                  |
| `dpcm` | `0dpcm`          | ❌                  |
| `dppx` | `0dppx`          | ❌                  |

This means that, although leaving units off a zero for transitions seems to be correct, it is in fact invalid:

```css
{
  transition: opacity 0 ease;  /* ❌ */
  transition: opacity 0s ease; /* ✅ */
}
```

Quirky! For further reading, see [CSS Values and Units Module Level 3, Sections 5 and 6](https://www.w3.org/TR/css-values/#lengths).
