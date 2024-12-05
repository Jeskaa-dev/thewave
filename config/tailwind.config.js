const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    // './node_modules/flowbite/**/*.js'
  ],
  theme: {
    colors: {
      // Configure your color palette here
      'primary-red': '#E60E05',
      'primary-green': '#1B9C91',
      'primary-gray': '#D7D7D7',
      'primary-blue': '#1E90FF',
      'var-black': '#233038',
      'var-white': '#F7F7F7'
    },
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
