document.addEventListener('DOMContentLoaded', () => {
  let scheduledAnimationFrame;
  const elements = document.querySelectorAll('.has-viewport-event');

  const runViewportAnimations = () => {
    scheduledAnimationFrame = false;

    elements.forEach(el => {
      const b = el.getBoundingClientRect();

      if (b.top >= 0 && b.left >= 0 && b.right <= window.innerWidth && b.bottom <= window.innerHeight) {
        el.classList.add('is-in-viewport');
      }
    })
  };

  const viewportChange = () => {
    if (scheduledAnimationFrame) {
      return;
    }

    scheduledAnimationFrame = true;
    requestAnimationFrame(runViewportAnimations);
  };

  if (elements.length) {
    viewportChange();
    document.addEventListener("scroll", viewportChange, { passive: true });
  }
});
