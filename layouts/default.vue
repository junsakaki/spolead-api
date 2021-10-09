<template>
  <v-app dark>
    <Header :token="token" />
    <v-content>
      <v-container :class="$vuetify.breakpoint.smAndDown && 'SP'">
        <nuxt />
      </v-container>
    </v-content>
    <v-footer
      color="primary lighten-1"
      padless
      app
    >
      <v-row
        justify="center"
        no-gutters
      >
        <v-btn
          v-for="(link,i) in footerLinks"
          :key="i"
          :to="link.to"
          color="white"
          text
          rounded
          class="my-2"
        >
          {{ link.title }}
        </v-btn>
        <v-col
          class="primary lighten-2 py-4 text-center white--text copyright"
          cols="12"
        >
          <span>&copy; SpoLeadeR.All rights reserved 2020 {{ nowYear }}</span>
        </v-col>
      </v-row>
    </v-footer>
  </v-app>
</template>

<script>
import Header from '~/components/organisms/Header.vue'

export default {
  components: {
    Header
  },
  data () {
    return {
      token: '',
      clipped: false,
      drawer: false,
      fixed: false,
      isLogin: localStorage,
      items: [
        {
          icon: 'mdi-apps',
          title: 'スポーツ一覧',
          to: '/'
        },
        {
          icon: 'mdi-apps',
          title: 'エリアから探す',
          to: '/top-prefecture'
        }
      ],
      loginItems: [
        {
          icon: 'mdi-chart-bubble',
          title: 'ログイン',
          to: '/login'
        },
        {
          icon: 'mdi-chart-bubble',
          title: 'アカウント登録',
          to: '/signup'
        }
      ],
      logoutItem: {
        icon: 'mdi-chart-bubble',
        title: 'ログアウト',
        onClick: () => this.logOut()
      },
      footerLinks: [
        {
          title: 'ホーム',
          to: '/'
        },
        {
          title: 'お問い合わせ',
          to: '/contact-form'
        },
        {
          title: '利用規約',
          to: '/term-of-service'
        },
        {
          title: '運営管理',
          to: '/master-information'
        }
      ],
      miniVariant: false,
      right: true,
      rightDrawer: false,
      title: 'SpoLeadeR',
      subTitle: '総合スポーツチーム・スクール口コミ情報ポータル'
    }
  },
  computed: {
    nowYear () {
      const year = new Date()
      const nowYear = year.getFullYear()
      if (nowYear > 2020) {
        return `~ ${nowYear}`
      } else {
        return ''
      }
    }
  },
  created () {
    this.token = localStorage.getItem('token')
    // if (!this.token) {
    //   this.$router.push('/login')
    // }
  },
  methods: {
    logOut () {
      // only remove localStorage

      // this.$store
      //   .dispatch('api/apiRequest', {
      //     api: 'login',
      //     data: {
      //       email: this.email,
      //       password: this.password
      //     }
      //   }).then((res) => {
      //     if (res.status === 200) {
      localStorage.removeItem('token')
      localStorage.removeItem('userId')
      localStorage.removeItem('loginDateTime')
      this.$router.push('/')
      // due to local development
      // location.replace('http://localhost:8000/')
      location.replace('https://spolead.com/')
      // location.replace('http://develop01.spolead-sv.net')
      //   }
      // }).catch((err) => {
      //   console.log('ERROR', err)
      // })
    }
  }
}
</script>
<style lang="scss">
#app{
  font-family: 'spoleader';
}
.v-main {
  padding: 0 !important;
}
.v-toolbar__content {
  .common-button {
    margin-right: 20px;
  }
}
.toolbar {
  cursor: pointer;
}
.toolbar.SP {
  padding: 0 !important;
  overflow: unset;
}
.sub-title.SP {
  font-size: 10px;
  margin-left: 4px;
}
.login-buttons {
  background: transparent;
  width: 100%;
}
.v-footer {
  position: unset;
}
.copyright {
  overflow: unset;
  width: 100vw;
  white-space: nowrap;
  text-overflow: ellipsis;
  font-size: 12px;
}
.header {
  display: flex;
  justify-content: space-between;
  z-index: 1;
  padding-left: 12px;
  margin: 0 72px;
  background-color: white;
  width: -webkit-fill-available;
  .logo {
    display: flex;
    align-items: center;
  }
  .links {
    display: flex;
  }
  .link {
    font-size: 14px;
    padding: 18px 12px;
    color: white;
    text-decoration: none;
  }
  .link.login, .link.logout {
    background-color: #ef4848;
  }
  .link.signup {
    background-color: #43464a;
  }
}
.header.fixed {
  position: fixed;
  box-shadow: 0px 7.5px 18px 1.2px rgb(0 0 0 / 12%);
}
.breadcrumbs {
  width: 100%;
  padding: 0 0 12px !important;
}
</style>
