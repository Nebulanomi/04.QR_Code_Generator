/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',  // Include pages directory if used
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',  // Include components directory if used
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',   // Adjust this based on your file structure
  ],
  theme: {
    extend: {
      backgroundImage: {
        'gradient-radial': 'radial-gradient(var(--tw-gradient-stops))',
        'gradient-conic':
          'conic-gradient(from 180deg at 50% 50%, var(--tw-gradient-stops))',
      },
    },
  },
  plugins: [],
}
