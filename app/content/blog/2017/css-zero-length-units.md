---
title: "Zero Units in CSS: Duration, Frequency, Resolution Require Units"
date: "2017-09-07"
summary: In most cases, the value zero does not require units to be specified in CSS, however, this is not the case when using non-length and non-angle units.
---

CSS doesn’t usually require zeros to have units — because zero is zero, regardless of units. Since these are all equivalent, the unitless version is often used:

```css
padding: 0px; /*✅*/
padding: 0pt; /*✅*/
padding: 0em; /*✅*/
padding: 0rem;/*✅*/

padding: 0;   /*✅*/
```

This works for all length-based units and angle-based units, but does not work other types of values.

<p class="lede">The CSS spec requires units to be specified for duration, frequency, and resolution values — even for zero.</p>

<table class="grouped-table">
  <tr class="group-label">
    <th colspan="100"><a href="https://www.w3.org/TR/css-values/#lengths">Length Units</a></th>
  </tr>
  <tr><th>Unit</th><th>Zero With Unit</th><th>Zero Without Unit</th></tr>

  <tr><td>em</td></td><td><code>0em</code></td><td><code>0</code></td></tr>
  <tr><td>ex</td></td><td><code>0ex</code></td><td><code>0</code></td></tr>
  <tr><td>ch</td></td><td><code>0ch</code></td><td><code>0</code></td></tr>
  <tr><td>rem</td></td><td><code>0rem</code></td><td><code>0</code></td></tr>
  <tr><td>vw</td></td><td><code>0vw</code></td><td><code>0</code></td></tr>
  <tr><td>vh</td></td><td><code>0vh</code></td><td><code>0</code></td></tr>
  <tr><td>vmin</td></td><td><code>0vmin</code></td><td><code>0</code></td></tr>
  <tr><td>vmax</td></td><td><code>0vmax</code></td><td><code>0</code></td></tr>
  <tr><td>cm</td></td><td><code>0cm</code></td><td><code>0</code></td></tr>
  <tr><td>mm</td></td><td><code>0mm</code></td><td><code>0</code></td></tr>
  <tr><td>Q</td></td><td><code>0Q</code></td><td><code>0</code></td></tr>
  <tr><td>in</td></td><td><code>0in</code></td><td><code>0</code></td></tr>
  <tr><td>pc</td></td><td><code>0pc</code></td><td><code>0</code></td></tr>
  <tr><td>pt</td></td><td><code>0pt</code></td><td><code>0</code></td></tr>
  <tr><td>px</td></td><td><code>0px</code></td><td><code>0</code></td></tr>

  <tr class="group-label">
    <th colspan="100"><a href="https://www.w3.org/TR/css-values/#angles">Angle Units</a></th>
  </tr>
  <tr><th>Unit</th><th>Zero With Unit</th><th>Zero Without Unit</th></tr>

  <tr><td>deg</td><td><code>0deg</code></td><td><code>0</code></td></tr>
  <tr><td>grad</td><td><code>0grad</code></td><td><code>0</code></td></tr>
  <tr><td>rad</td><td><code>0rad</code></td><td><code>0</code></td></tr>
  <tr><td>turn</td><td><code>0turn</code></td><td><code>0</code></td></tr>

  <tr class="group-label">
    <th colspan="100"><a href="https://www.w3.org/TR/css-values/#time">Duration Units</a></th>
  </tr>
  <tr><th>Unit</th><th>Zero With Unit</th><th>Zero Without Unit</th></tr>

  <tr><td>s</td><td><code>0s</code></td><td>❌</td></tr>
  <tr><td>ms</td><td><code>0ms</code></td><td>❌</td></tr>

  <tr class="group-label">
    <th colspan="100"><a href="https://www.w3.org/TR/css-values/#frequency">Frequency Units</a></th>
  </tr>
  <tr><th>Unit</th><th>Zero With Unit</th><th>Zero Without Unit</th></tr>

  <tr><td>Hz</td><td><code>0Hz</code></td><td>❌</td></tr>
  <tr><td>kHz</td><td><code>0kHz</code></td><td>❌</td></tr>

  <tr class="group-label">
    <th colspan="100"><a href="https://www.w3.org/TR/css-values/#resolution">Resolution Units</a></th>
  </tr>
  <tr><th>Unit</th><th>Zero With Unit</th><th>Zero Without Unit</th></tr>

  <tr><td>dpi</td><td><code>0dpi</code></td><td>❌</td></tr>
  <tr><td>dpcm</td><td><code>0dpcm</code></td><td>❌</td></tr>
  <tr><td>dppx</td><td><code>0dppx</code></td><td>❌</td></tr>
</table>


This means that, although leaving units off a zero for transitions seems to be correct, it is in fact invalid:

```css
transition: opacity 0 ease; /*❌*/
transition: opacity 0s ease;/*✅*/
```

Quirky! For further reading, see [CSS Values and Units Module Level 3, Sections 5 and 6](https://www.w3.org/TR/css-values/#lengths).
