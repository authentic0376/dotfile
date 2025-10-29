import tailwindcss from "@tailwindcss/vite"

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: "2025-07-15",
  devtools: { enabled: true },
  modules: [
    "@nuxt/eslint",
    "@nuxt/ui",
    "@nuxt/icon",
    "@nuxtjs/i18n",
  ],
  css: ["~/assets/css/main.css"],
  vite: {
    plugins: [tailwindcss()],
  },
  typescript: {
    tsConfig: { compilerOptions: { allowArbitraryExtensions: true } },
  },
  i18n: {
    // file 이름을 직접지정해야한다. 다만 경로는 기본값이 있다
    locales: [{ code: "ko", language: "ko-KR", file: "ko.ts" }],
    defaultLocale: "ko",
  },
})
