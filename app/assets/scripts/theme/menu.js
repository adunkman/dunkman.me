document.addEventListener('DOMContentLoaded', () => {
  const menuButton = document.querySelector('.primary-menu-button');
  const menuContainer = document.querySelector('.primary-menu');
  const overlay = document.querySelector('.primary-menu-overlay');
  const closeButton = document.querySelector('.primary-menu-close-button');

  const open = () => {
    menuContainer.classList.add('is-visible');
    overlay.classList.add('is-visible');
    closeButton.focus();
  };

  const close = () => {
    menuContainer.classList.remove('is-visible');
    overlay.classList.remove('is-visible');
    menuButton.focus();
  };

  try {
    menuButton.addEventListener('click', open);
    closeButton.addEventListener('click', close);
    overlay.addEventListener('click', close);
    menuContainer.addEventListener('keydown', ({ code }) => {
      if (code === 'Escape') { close(); }
    });
  }
  catch (err) {}
});
