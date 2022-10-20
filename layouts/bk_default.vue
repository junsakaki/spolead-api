<template>
  <v-app dark>
    <Header />
    <v-content>
      <v-container :class="$vuetify.breakpoint.smAndDown && 'SP'">
        <nuxt />
      </v-container>
    </v-content>
    <ScrollTopButton />
    <v-footer padless>
      <div class="a8">        
        <a href="//ck.jp.ap.valuecommerce.com/servlet/referral?sid=3626167&pid=887715132" rel="nofollow">
	<img src="//ad.jp.ap.valuecommerce.com/servlet/gifbanner?sid=3626167&pid=887715132" border="0"></a>
	<a href="https://rpx.a8.net/svt/ejp?a8mat=3HP98T+EPVT6A+2HOM+68U4X&rakuten=y&a8ejpredirect=http%3A%2F%2Fhb.afl.rakuten.co.jp%2Fhgc%2F0ea62065.34400275.0ea62066.204f04c0%2Fa21113093292_3HP98T_EPVT6A_2HOM_68U4X%3Fpc%3Dhttp%253A%252F%252Fwww.rakuten.co.jp%252F%26m%3Dhttp%253A%252F%252Fm.rakuten.co.jp%252F" rel="nofollow">
	<img src="http://hbb.afl.rakuten.co.jp/hsb/0eb4bbc3.a22f6535.0eb4bbaa.95151395/" border="0"></a>
	<img border="0" width="1" height="1" src="https://www17.a8.net/0.gif?a8mat=3HP98T+EPVT6A+2HOM+68U4X" alt="">
	<a href="https://px.a8.net/svt/ejp?a8mat=3HP98U+2FIQPE+4ABU+5ZU29" rel="nofollow">
	<img border="0" width="234" height="60" alt="" src="https://www26.a8.net/svt/bgt?aid=211130382147&wid=001&eno=01&mid=s00000020001001007000&mc=1"></a>
	<img border="0" width="1" height="1" src="https://www13.a8.net/0.gif?a8mat=3HP98U+2FIQPE+4ABU+5ZU29" alt="">
	<a href="https://px.a8.net/svt/ejp?a8mat=3N6777+2S0UEQ+2DDC+83RH01" rel="nofollow">
	<img border="0" width="234" height="60" alt="" src="https://www26.a8.net/svt/bgt?aid=220318963168&wid=001&eno=01&mid=s00000011064049005000&mc=1"></a>
	<img border="0" width="1" height="1" src="https://www18.a8.net/0.gif?a8mat=3N6777+2S0UEQ+2DDC+83RH01" alt="">
        <a href="https://px.a8.net/svt/ejp?a8mat=3NADJF+9WMO4Y+3XBS+601S1" rel="nofollow">
	<img border="0" width="234" height="60" alt="" src="https://www20.a8.net/svt/bgt?aid=220513803599&wid=001&eno=01&mid=s00000018316001008000&mc=1"></a>
	<img border="0" width="1" height="1" src="https://www16.a8.net/0.gif?a8mat=3NADJF+9WMO4Y+3XBS+601S1" alt="">
      </div>
      <div class="footer-links">
        <div v-for="link in filteredFooterLinks()" :key="link.title" class="link white--text">
          <router-link :to="link.to">
            {{ link.title }}
          </router-link>
        </div>
      </div>
      <div class="footer-copyright">
        <span class="grey--text">&copy; SpoLeadeR.All rights reserved 2020 {{ nowYear }}</span>
      </div>
    </v-footer>
  </v-app>
</template>

<script>
import Header from '~/components/shared/organisms/Header.vue'
import ScrollTopButton from '~/components/shared/atoms/ScrollTopButton.vue'

export default {
  components: {
    Header,
    ScrollTopButton
  },
  data () {
    return {
      clipped: false,
      drawer: false,
      fixed: false,
      isLogin: localStorage,
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
          title: 'BBS掲示板ガイドライン',
          to: '/guideline/forums'
        },
        {
          title: '運営管理',
          to: '/master-information'
        },
        {
          title: 'サイトマップ',
          to: '/sitemap'
        }
      ],
      miniVariant: false,
      right: true,
      rightDrawer: false,
      title: 'SpoLeadeR',
      subTitle: 'ALL SPORTS BEGINING SpoLedeR'
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
  methods: {
    filteredFooterLinks () {
      if (this.$auth.loggedIn) {
        return [
          ...this.footerLinks,
          {
            title: 'チームを登録する',
            to: '/teams/new'
          }
        ]
      } else {
        return [
          ...this.footerLinks,
          {
            title: 'チーム登録するにはログインが必要です',
            to: '/login'
          }
        ]
      }
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
  .link.login {
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
.footer-links {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  width: 100%;
  padding: 20px 12px;
  .link {
    font-size: 12px;
    padding: 4px 8px;
    a {
      text-decoration: none;
    }
    &:hover {
      text-decoration: underline;
      opacity: 0.8;
    }
  }
}
.footer-copyright {
  font-size: 10px;
  text-align: center;
  width: 100%;
  padding: 8px 0;
  background-color: white;
}
.a8 {
  text-align: center;
  width: 100%;
}
</style>
