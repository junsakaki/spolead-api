  plugins: [
    {
      resolve: `gatsby-plugin-google-analytics`,
      options: {
        trackingId: "process.env.GOOGLE_ANALYTICS_ID",//デフォルト値
        head: true, //これ追加
      },
    },
  ],

<template>
  <v-layout
    column
    justify-center
    align-center
  >
    <div class="page-title">
      総合スポーツチーム・スクール口コミ情報ポータル
    </div>
    <v-img
      :src="require('~/assets/images/SpoLeader-logo.png')"
      :width="350"
      :aspect-ratio="16/6"
      class="logo"
    />
    <div class="page-content">
      <div class="h2 text-left page-content-title">
        スポーツから探す
      </div>
      <v-flex
        xs12
        sm8
        md6
        d-flex
        flex-wrap
        class="sports-area"
      >
        <v-col
          v-for="card in cards"
          :key="card.title"
          :cols="3"
          @click="goTeamsPage(card.id)"
          class="cards"
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
    </div>

    <div class="page-content">
      <div width="100%" class="h2 text-left page-content-title">
        エリアから探す
        <a v-if="mode == 'city'" @click="backMode">
          <font class="back">都道府県一覧に戻る</font>
        </a>
      </div>
      <!-- select PREFECTURE component -->
      <div v-if="mode === 'prefecture'">
        <v-flex
          d-flex
          flex-wrap
        >
          <v-col
            v-for="prefecture in topPrefecture"
            :key="prefecture.id"
            :cols="4"
            class="cards"
          >
            <v-card @click="goCitySelect(prefecture)">
              <v-img
                :src="prefecture.src"
                class="white--text align-end"
                gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
                height="200px"
              >
                <v-card-title v-text="prefecture.title" />
              </v-img>
            </v-card>
          </v-col>
        </v-flex>
        <v-flex
          d-flex
          flex-wrap
        >
          <v-col
            v-for="area in areas"
            :key="area.id"
            :cols="6"
          >
            <div class="area-title">
              {{ area.title }}
            </div>
            <v-flex
              d-flex
              flex-wrap
            >
              <a
                v-for="prefecture in area.prefectures"
                :key="prefecture.id"
                @click="goCitySelect(prefecture)"
                class="link"
              >
                {{ prefecture.title }}
              </a>
            </v-flex>
          </v-col>
        </v-flex>
      </div>
      <!-- select CITY component -->
      <div v-else-if="mode === 'city'">
        <div class="city-select-area">
          <div class="area-title">
            {{ selectedPrefecture.title }}の市区町村一覧
          </div>
          <v-flex d-flex flex-wrap class="list">
            <a
              v-for="city in cityCards"
              :key="city.cityCode"
              @click="showTeamsRelatedToCity(city.cityCode)"
              class="link"
            >
              {{ city.cityName }}
            </a>
          </v-flex>
        </div>
      </div>
    </div>
  </v-layout>
</template>

<script>
export default {
  head () {
    return {
      title: 'SpoLeadeR',
      titleTemplate: ''
    }
  },
  data () {
    return {
      token: '',
      cards: this.$SPORTS,
      mode: 'prefecture',
      areas: this.$AREA,
      topPrefecture: this.$TOP_PREFECTURE,
      cityCards: [],
      selectedPrefecture: { title: '' }
    }
  },
  created () {
    this.token = localStorage.getItem('token')
    if (localStorage.getItem('selectedCity')) {
      this.mode = 'city'
      this.cityCards = JSON.parse(localStorage.getItem('selectedCity'))
    }
    if (localStorage.getItem('selectedPrefecture')) {
      this.selectedPrefecture = JSON.parse(localStorage.getItem('selectedPrefecture'))
    }
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
      this.$router.push({ name: 'teams', params: { sportsId }, query: { sportsId } })
      localStorage.setItem('sportsId', sportsId)
      localStorage.setItem('cityCode', '')
    },
    showTeamsRelatedToCity (cityCode) {
      this.$router.push({ name: 'teams', params: { cityCode }, query: { cityCode } })
      localStorage.setItem('sportsId', '')
      localStorage.setItem('cityCode', cityCode)
    },
    goCitySelect (pref) {
      console.log('prefId', pref.id)
      this.mode = 'city'
      console.log('mode', this.mode)
      this.$store
        .dispatch('api/apiRequest', {
          api: 'getCityApi',
          params: {
            prefCode: pref.id
          }
        })
        .then((response) => {
          if (response.status === 200) {
            console.log(response.data.result)
            this.cityCards = response.data.result
            this.selectedPrefecture = pref
            localStorage.setItem('selectedCity', JSON.stringify(response.data.result))
            localStorage.setItem('selectedPrefecture', JSON.stringify(pref))
          }
        })
    },
    backMode () {
      this.cityCards = []
      this.mode = 'prefecture'
      localStorage.removeItem('selectedPrefecture')
      localStorage.removeItem('selectedCity')
    }
  }
}
</script>

<style lang="scss" scoped>
@import '~/assets/scss/page.scss';

.page-header {
  @include default-page-header;
  display: flex;
  align-items: center;
  justify-content: flex-end;
}
.page-title {
  width: 100%;
  font-size: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.page-content {
  width: 100%;
  margin: 32px;
  .link {
    cursor: pointer;
    margin-right: 16px;
  }
  .page-content-title {
    font-size: 20px;
  }
  .back {
    font-size: 14px;
    margin-left: 16px;
  }
  .cards {
    cursor: pointer;
  }
}
.SP .page-content .cards {
  flex: 0 0 100%;
  max-width: 100%;
}
.logo {
  margin-top: 20px;
}
.area-title {
  font-size: 14px;
}
.sports-area {
  max-width: 100%;
}
.city-select-area {
  padding: 12px;
}
</style>
