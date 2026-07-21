# Curso de Desarrollo con IA - lanedu.cl

Landing page para el curso presencial de "Desarrollo con IA: OpenCode y Agentes" en Valparaíso, Chile.

## 🚀 Desarrollo local

```bash
# Instalar dependencias
npm install

# Iniciar servidor de desarrollo
npm run dev

# Abrir en el navegador
open http://localhost:4321
```

## 📦 Build y deploy

```bash
# Construir para producción
npm run build

# Previsualizar build
npm run preview
```

## 🌐 Deploy a GitHub Pages

1. **Crear repositorio en GitHub** con el nombre que quieras (ej: `cursoIA`)

2. **Subir el código:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/TU_USUARIO/TU_REPO.git
   git push -u origin main
   ```

3. **Configurar GitHub Pages:**
   - Ve a tu repo en GitHub → Settings → Pages
   - En "Source" selecciona "GitHub Actions"

4. **Actualizar `astro.config.mjs`:**
   - Reemplaza `TU_USUARIO` con tu usuario de GitHub
   - Si el repo se llama diferente a la raíz, descomenta `base`

5. **Activar deploy:**
   - El GitHub Action se ejecutará automáticamente al hacer push a `main`
   - Tu página estará disponible en `https://TU_USUARIO.github.io/TU_REPO/`

## 📁 Estructura del proyecto

```
cursoIA/
├── src/
│   ├── components/
│   │   ├── Hero.astro          # Sección principal
│   │   ├── QueAprenderas.astro # Módulos del curso
│   │   ├── Detalles.astro      # Info del curso
│   │   ├── Temario.astro       # Programa detallado
│   │   ├── Precio.astro        # Pricing e inscripción
│   │   ├── Instructor.astro    # Info del instructor
│   │   ├── Ubicacion.astro     # Mapa y ubicación
│   │   └── Footer.astro        # Pie de página
│   ├── layouts/
│   │   └── Layout.astro        # Layout principal
│   ├── pages/
│   │   └── index.astro         # Página principal
│   └── styles/
│       └── global.css          # Estilos globales
├── .github/workflows/
│   └── deploy.yml              # GitHub Actions para deploy
└── astro.config.mjs            # Configuración de Astro
```

## 🎨 Personalización

### Cambiar colores
Edita `src/styles/global.css` y modifica las variables en `@theme`:
- `--color-primary`: Color principal (azul por defecto)
- `--color-accent`: Color de acento (cyan por defecto)
- `--color-dark`: Color de fondo oscuro

### Cambiar contenido
Cada componente tiene su contenido en la sección `---` al inicio del archivo. Modifica los textos directamente ahí.

### Cambiar número de WhatsApp
Busca `56920506678` en los componentes y reemplázalo con tu número.

## 📱 Meta Pixel (Facebook Ads)

El pixel de Meta está como placeholder en `src/layouts/Layout.astro`. Para activarlo:

1. Crea una cuenta en [Meta Business Suite](https://business.facebook.com/)
2. Crea un pixel de conversiones
3. Reemplaza `TU_PIXEL_ID_AQUI` en el layout con tu ID de pixel

## 🛠️ Tecnologías

- [Astro](https://astro.build/) - Framework web
- [Tailwind CSS](https://tailwindcss.com/) - Estilos
- GitHub Pages - Hosting gratuito
