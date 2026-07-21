// @ts-check
import { defineConfig } from 'astro/config';

import tailwindcss from '@tailwindcss/vite';

// https://astro.build/config
export default defineConfig({
  // Reemplaza 'TU_USUARIO' con tu usuario de GitHub
  site: 'https://TU_USUARIO.github.io',
  // Si el repo se llama 'cursoIA', descomenta la siguiente línea:
  // base: '/cursoIA',
  vite: {
    plugins: [tailwindcss()]
  }
});