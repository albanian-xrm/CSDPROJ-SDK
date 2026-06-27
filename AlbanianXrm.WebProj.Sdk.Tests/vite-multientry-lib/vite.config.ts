// vite.config.ts
import { createMpaPlugin, createPages, Page } from 'vite-plugin-virtual-mpa'
import react from '@vitejs/plugin-react'
import { defineConfig, HtmlTagDescriptor, UserConfig } from 'vite'
import { resolve, relative, dirname } from 'node:path';
import { glob } from 'glob/raw';

const prefix = `${process.env.PublisherPrefix ?? "albx"}_`;
const fullPathDirName = resolve(__dirname) + "/";

// @see https://vitejs.dev/config/
export default defineConfig(() => glob("src/**/*.ppwr.tsx").then(files => ({
  base: './',
  build: {
    sourcemap: true,
    rolldownOptions: {
      output: {
        entryFileNames: (chunkInfo) => {
          console.log("chunkInfo.facadeModuleId", chunkInfo.facadeModuleId);
          return chunkInfo.facadeModuleId ? chunkInfo.facadeModuleId.replace(fullPathDirName, '').replace(/\.html$/, '.js') : '[name].js'
        },
        "chunkFileNames": (chunkInfo) => {
          console.log("chunkInfo.name", chunkInfo.name);
          return chunkInfo.name ? `${prefix}/${chunkInfo.name}.js` : '[name].js'
        },
      },
    }
  },
  plugins: [
    react(),
    createMpaPlugin({
      pages: createPages(files.map(file => {
        const entry = resolve(__dirname, file);
        const filename = entry.replace(/\.ppwr\.tsx$/, '.html').replace(resolve(__dirname, 'src'), prefix);
        const name = filename.replace(/\.html$/, '').replace(/\//g, '_');
        return {
          entry,
          filename,
          name
        } as Page<string, string, string>
      })),
      transformHtml(html, ctx) {
        const tags: HtmlTagDescriptor[] = [];
        if(!process.env.ExcludedFromClientGlobalContextJs || !process.env.ExcludedFromClientGlobalContextJs.split(';').includes(ctx.page.name)) {
          tags.push({
              tag: 'script',
              injectTo: 'head',
              attrs: {
                src: relative( resolve(dirname(ctx.filename)),resolve(__dirname)) + '/ClientGlobalContext.js.aspx',
                type: 'text/javascript',
              },
          });
        }
        return {
          html,
          tags,
        };
      },
    }),
  ],
} as UserConfig)));