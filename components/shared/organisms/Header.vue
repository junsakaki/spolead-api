<template>
  <div v-if="!['/login', '/signup'].includes($route.path)">
    <div v-if="$vuetify.breakpoint.smAndDown" class="header SP">
      <router-link to="/" class="logo">
        <img
          :src="require('~/assets/images/SpoLeader-logo.png')"
          :width="120"
          :aspect-ratio="16/6"
          class="logo"
        >
      </router-link>
      <div class="icon-button-wrapper SP">
        <a v-if="token" @click="logOut" class="icon-button">
          <v-icon small>
            mdi-lock-open
          </v-icon>
          <p class="icon-button-link">
            ログアウト
          </p>
        </a>
        <router-link v-else class="icon-button" to="/login">
          <v-icon small>
            mdi-lock
          </v-icon>
          <p class="icon-button-link">
            ログイン
          </p>
        </router-link>
      </div>
    </div>
    <div v-else :class="`header ${$route.path === '/' ? 'fixed' : ''}`">
      <router-link to="/" class="logo">
        <img
          :src="require('~/assets/images/SpoLeader-logo.png')"
          :width="150"
          :aspect-ratio="16/6"
          class="logo"
        >
      </router-link>
      <div>
        <div v-if="token" class="links">
          <a @click="logOut" class="link icon-button">
            <v-icon small>
              mdi-lock-open
            </v-icon>
            <p class="icon-button-link">
              ログアウト
            </p>
          </a>
        </div>
        <div v-else class="links">
          <router-link to="/signup" class="link icon-button">
            <v-icon small>
              mdi-account
            </v-icon>
            <p class="icon-button-link">
              アカウント登録
            </p>
          </router-link>
          <router-link to="/login" class="link icon-button">
            <v-icon small>
              mdi-lock
            </v-icon>
            <p class="icon-button-link">
              ログイン
            </p>
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    token: {
      type: String,
      default: ''
    }
  },
  data () {
    return {
      isMobile: this.$vuetify.breakpoint.smAndDown
    }
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
      location.replace('https://spoleader.com/')
      // location.replace('http://develop01.spolead-sv.net')
      //   }
      // })
    }
  }
}
</script>
<style lang="scss">
.header {
  z-index: 1;
  padding-left: 12px;
  margin: 0 72px;
  background-color: white;
  &.SP {
    margin: 0;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
}
.fixed {
  position: fixed;
  box-shadow: 0px 7.5px 18px 1.2px rgb(0 0 0 / 12%);
}
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
.icon-button-wrapper.SP {
  padding-right: 12px;
}
.icon-button {
  display: flex;
  flex-direction: column;
  text-decoration: none;
  color: #0000008A  !important;
  .icon-button-link {
    display: block;
    margin: 0 !important; //.v-application p の定義に上書きされる可能性があるため!important
    font-size: 10px;
    text-align: center;
  }
}
</style>
