const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
        cursive: ['"Brush Script MT"', 'cursive'],
      },
      colors:{
        olive: {
          200: '#b5b57a',
          600: '#6b8e23',
           // Adjust this to your preferred shade
        },
        seaBlue: {
          600: '#00aaff', // Adjust this to your preferred sea blue shade
        },
        lightGray: '#f0f0f0', // Custom very light grey

      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
