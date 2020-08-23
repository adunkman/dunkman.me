document.addEventListener('DOMContentLoaded', () => {
  let scheduledAnimationFrame;
  const elements = document.querySelectorAll('.has-viewport-event');

  const runViewportAnimations = () => {
    scheduledAnimationFrame = false;

    elements.forEach(el => {
      const bounding = el.getBoundingClientRect();
      console.log(bounding);
      if (bounding.top >= 0 && bounding.left >= 0 && bounding.right <= window.innerWidth && bounding.bottom <= window.innerHeight) {
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
