import gleam from "vite-gleam";

export default {
    plugins: [gleam()],
    build: {
        rollupOptions: {
            input: 'main.js',
            output: {
                dir: './dist',
                entryFileNames: 'assets/gleam_vite.js',
            }
        }
    }
}