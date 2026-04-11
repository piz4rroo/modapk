import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';
import vercel from '@astrojs/vercel';

export default defineConfig({
  site: 'https://modapk-git-main-piz4rroos-projects.vercel.app',
  output: 'server',
  adapter: vercel(),
  security: {
    checkOrigin: true,
    allowedDomains: [
      {
        hostname: 'modapk-git-main-piz4rroos-projects.vercel.app',
        protocol: 'https',
      },
    ],
  },
  vite: {
    plugins: [tailwindcss()],
  },
});
