(() => {
  'use strict'

  const getStoredTheme = () => localStorage.getItem('theme')
  const setStoredTheme = theme => localStorage.setItem('theme', theme)

  const getTheme = () => {
    const storedTheme = getStoredTheme()
    if (storedTheme) {
      return storedTheme
    }

    return 'auto'
  }

  const setAppTheme = theme => {
    if (theme === 'auto' && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      document.documentElement.setAttribute('data-bs-theme', 'dark')
    } else {
      document.documentElement.setAttribute('data-bs-theme', theme)
    }
  }

  setAppTheme(getTheme())

  // Function to update the icon based on the current theme
  const updateThemeIcon = (theme) => {
    const iconUseElement = document.querySelector('#color-mode-icon use');
    switch (theme) {
      case 'light':
        iconUseElement.setAttribute('href', '#sun-fill');
        break;
      case 'dark':
        iconUseElement.setAttribute('href', '#moon-stars-fill');
        break;
      case 'auto':
      default:
        iconUseElement.setAttribute('href', '#circle-half');
        break;
    }
  }

  // Event listener for the color theme icon
  document.getElementById('color-mode-icon').addEventListener('click', () => {
    let theme = getTheme();
    let newTheme;
    switch (theme) {
      case 'auto':
        newTheme = window.matchMedia('(prefers-color-scheme: light)').matches ? 'dark' : 'light';
        break;
      case 'light':
        newTheme = window.matchMedia('(prefers-color-scheme: light)').matches ? 'auto' : 'dark';
        break;
      case 'dark':
        newTheme = window.matchMedia('(prefers-color-scheme: light)').matches ? 'light' : 'auto';
        break;
    }
    setStoredTheme(newTheme);
    setAppTheme(newTheme);
    updateThemeIcon(newTheme);
  });

  // Update the color theme icon on initial load based on the user system color preference
  window.addEventListener('DOMContentLoaded', () => {
    const theme = getTheme()
    if (theme !== 'auto') {
      updateThemeIcon(theme);
    }
  });

  // Update the color theme icon when the user system color preference changes
  window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', () => {
    const theme = getTheme()
    setAppTheme(theme)
    updateThemeIcon(theme)
  })
})()
