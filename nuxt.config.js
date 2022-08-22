import colors from 'vuetify/es5/util/colors'

export default {
  mode: 'spa',
  /*
  ** Headers of the page
  */
  head: {
    htmlAttrs: {
      lang: 'ja',
      prefix: 'og: http://ogp.me/ns#'
    },
    titleTemplate: '%s' + 'SpoLeadeR',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'SpoLeadeR(スポリーダー)は育成年代を始めとしたお住いの地域から全国のスポーツチーム・スクールのクチコミまで網羅した情報データベースです。国内最大級のスポーツチーム・スクールを掲載し・検索・情報収集ができます！子供の習い事をはじめ、大人まで通えるチーム・スクール情報も掲載できます。また、スポーツBBS掲示板も掲載しており、悩みや相談事も自由にスレッド形式で利用が可能です。' },
      { hid: 'keywords', name: 'keywords', content: 'スポーツ,チーム,スクール,口コミ,情報,データベース,サッカー,野球,バスケット,バレーボール,水泳,ラグビー,ダンス,キッズ,小学生,中学生,高校生,大学生,社会人,シニア,BBS,掲示板' },
      { hid: 'og:site_name', property: 'og:site_name', content: 'Spoleader' },
      { hid: 'og:type', property: 'og:type', content: 'website' },
      { hid: 'og:url', property: 'og:url', content: 'https://spoleader.com/' },
      { hid: 'og:title', property: 'og:title', content: 'Spoleader' },
      { hid: 'og:description', property: 'og:description', content: 'SpoLeadeR(スポリーダー)は育成年代を始めとしたお住いの地域から全国のスポーツチーム・スクールのクチコミまで網羅した情報データベース>です。国内最大級のスポーツチーム・スクールを掲載し・検索・情報収集ができます！子供の習い事をはじめ、大人まで通えるチーム・スクール情報も掲載できます。また、スポーツBBS掲示板も掲載しており、悩みや相談事も自由にスレッド形式で利用が可能です。' },
      { hid: 'og:image', property: 'og:image', content: 'https://spoleader.com/ogp.png' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ],
    script: [
      {
        src: 'https://www.googletagmanager.com/gtag/js?id=G-NXPNETVMNR',
        async: true
      },
      {
        src: 'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-8350542131012326',
        async: true,
        crossorigin: 'anonymous'
      },
      {
        innerHTML: 'window.dataLayer = window.dataLayer || [];function gtag(){dataLayer.push(arguments);}gtag(\'js\', new Date());gtag(\'config\', \'G-NXPNETVMNR\');'
      }
    ]
  },
  /*
  ** Customize the progress-bar color
  */
  loading: { color: '#fff' },
  /*
  ** Global CSS
  */
  css: [
    { src: '~assets/scss/style.scss' }
  ],
  /*
  ** Plugins to load before mounting the App
  */
  plugins: [
    { src: '~/plugins/constants.js' },
    { src: '~/plugins/methods.js' }
  ],
  /*
  ** Nuxt.js dev-modules
  */
  buildModules: [
    // Doc: https://github.com/nuxt-community/eslint-module
    '@nuxtjs/eslint-module',
    '@nuxtjs/vuetify'
  ],
  /*
  ** Nuxt.js modules
  */
  modules: [
    // Doc: https://axios.nuxtjs.org/usage
    '@nuxtjs/axios',
    '@nuxtjs/auth-next'
  ],
  auth: {
    strategies: {
      auth0: {
        domain: 'dev-spolead.jp.auth0.com',
        clientId: 'Y2kdaDX8h2Hmt4ccu2S5qUQEUSxuHcbe'
      }
    }
  },
  /*
  ** Axios module configuration
  ** See https://axios.nuxtjs.org/options
  */
  axios: {
  },
  server: {
    port: 8000 // デフォルト: 3000
  },
  /*
  ** vuetify module configuration
  ** https://github.com/nuxt-community/vuetify-module
  */
  vuetify: {
    customVariables: ['~/assets/variables.scss'],
    theme: {
      // dark: true,
      themes: {
        dark: {
          primary: colors.blue.darken2,
          accent: colors.grey.darken3,
          secondary: colors.amber.darken3,
          info: colors.teal.lighten1,
          warning: colors.amber.base,
          error: colors.deepOrange.accent4,
          success: colors.green.accent3
        }
      }
    }
  },
  /*
  ** Build configuration
  */
  build: {
    /*
    ** You can extend webpack config here
    */
    extend (config, ctx) {
      if (process.server && process.browser) {
        config.module.rules.push({
          enforce: 'pre',
          test: /\.(js|vue)$/,
          loader: 'eslint-loader',
          exclude: /(node_modules)/
        })
      }
    }
  },
  router: {
    middleware: 'redirect'
  },
  // env
  env: {
    GET_CITY_APIKEY: process.env.GET_CITY_APIKEY,
    FOUNDATION: process.env.FOUNDATION
  }
}
