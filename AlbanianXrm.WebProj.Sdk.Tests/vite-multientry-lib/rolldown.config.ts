import { resolve } from "node:path";
import { defineConfig, RolldownOptions } from "rolldown";
import {glob} from "glob";

const name = process.env.PublisherName ?? "AlbanianXrmConst"
const prefix = `${process.env.PublisherPrefix ?? "albx"}_/`;

export default defineConfig(() => glob("src/**/*.ppwr.ts").then(files => {
    console.log("Found .ppwr.ts files:", files);

    return files.map((file) => {
        const outputFile = file.replace("src/", "dist/"+prefix).replace(".ppwr.ts", ".js");
        const outputFormat = "iife"; // You can change this to "cjs" or "esm" if needed

        return {
            platform: "browser",
            input: resolve(__dirname, file),
            output: {
                 sourcemap: true,
                minify: true,
                file: resolve(__dirname, outputFile),
                format: outputFormat,
                extend: true,
                name,
            }} as  RolldownOptions;
})}));