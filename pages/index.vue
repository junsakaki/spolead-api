<template>
  <v-layout
    column
    justify-center
    align-center
  >
    <div class="page-header">
      <div class="page-header-title">
         育成年代向け総合スポーツチーム・クラブ 口コミポータル
      </div>
      <div class="page-header-title">
        <common-button @click="topPrefecture" button-size="large" button-color="primary">
          エリアから探す
        </common-button>
        <common-button @click="registUserPage" v-if="token === ''" button-size="large">
          ユーザー登録する
        </common-button>
      </div>
    </div>
    <v-img
      :src="require('~/assets/images/spolead-logo3.png')"
      :width="250"
      :aspect-ratio="16/6"
    />
    <v-flex
      xs12
      sm8
      md6
      d-flex
      flex-wrap
      class="page-content"
    >
      <v-col
        v-for="card in cards"
        :key="card.title"
        :cols="card.flex"
        @click="goTeamsPage(card.id)"
        class="sports"
      >
        <v-card>
          <v-img
            :src="card.src"
            class="white--text align-end"
            gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
            height="200px"
          >
            <v-card-title v-text="card.title" />
          </v-img>
        </v-card>
      </v-col>
    </v-flex>
    <!-- <common-button @click="registUserPage" button-size="large" >
      ユーザー登録
    </common-button> -->
  </v-layout>
</template>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-TERNFNLL4D"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-TERNFNLL4D');

import CommonButton from '~/components/atoms/CommonButton.vue'

export default {
  components: {
    CommonButton
  },
  data () {
    return {
      token: '',
      cards: [
        { id: 1, title: 'Soccer', src: require('~/assets/images/soccer.jpg'), flex: 3 },
        { id: 2, title: 'Baseball', src: require('~/assets/images/baseball.jpg'), flex: 3 },
        { id: 3, title: 'Basketball', src: require('~/assets/images/basketball.jpeg'), flex: 3 },
        { id: 4, title: 'Volleyball', src: require('~/assets/images/volleyball.jpeg'), flex: 3 },
        { id: 5, title: 'Dance', src: require('~/assets/images/dance.jpeg'), flex: 3 },
        { id: 6, title: 'Rugby', src: require('~/assets/images/rugby.jpeg'), flex: 3 },
        { id: 7, title: 'Swimming', src: require('~/assets/images/swimming.jpeg'), flex: 3 }
      ]
    }
  },
  created () {
    this.token = localStorage.getItem('token')
    // if (!this.token) {
    //   this.$router.push('/login')
    // }
  },
  methods: {
    registUserPage () {
      this.$router.push('/signup')
    },
    loginPage () {
      this.$router.push('/login')
    },
    goTeamsPage (sportsId) {
      this.$router.push({ name: 'Teams', params: { sportsId } })
      localStorage.setItem('sportsId', sportsId)
      localStorage.setItem('cityCode', '')
    },
    topPrefecture () {
      this.$router.push('/topPrefecture')
    }
  }
}
</script>

<style lang="scss" scoped>
@import '~/assets/scss/page.scss';

.page-header {
  @include top-page-header
}
.page-title {
  width: 100%;
  height: 13vh;
  font-size: 56px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.page-content {
  margin: 32px;
  .sports {
    cursor: pointer;
  }
}
</style>
