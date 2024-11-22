import { defineConfig } from 'vite';

export default defineConfig({
    base: '/assets/',
    build: {
        manifest: true,
        rollupOptions: {
            input: {
                app: './assets/app.js'
            }
        },
        outDir: './public/assets/',
        assetsDir: ''
    }
});
