<template>
  <div class="page-content">
    <div v-if="$vuetify.breakpoint.smAndDown">
      <div width="100%" class="h2 text-left page-content-title SP">
        エリアから探す
        <a v-if="mode == 'city'" @click="backMode">
          <font class="back">都道府県一覧に戻る</font>
        </a>
      </div>
      <!-- select PREFECTURE component -->
      <div v-if="mode === 'prefecture'" class="prefecture-area SP">
        <v-flex
          d-flex
          flex-wrap
        >
          <v-col
            v-for="prefecture in topPrefecture.slice(0,6)"
            :key="`prefecture-${prefecture.id}`"
            :cols="4"
            @click="goCitySelect(prefecture)"
            class="cards"
          >
            <v-card class="card">
              <v-img
                :src="prefecture.src"
                class="white--text align-center"
                gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
                height="calc((100vw - 72px) / 3)"
              >
                <p class="prefecture-title">
                  {{ prefecture.title }}
                </p>
              </v-img>
            </v-card>
          </v-col>
        </v-flex>
        <div class="show-more">
          <div class="button">
            <button v-if="!isShowMore" @click="showMore(true)">
              すべて見る&nbsp;
              <v-icon x-small>
                mdi-plus
              </v-icon>
            </button>
          </div>
          <div v-if="isShowMore">
            <v-flex
              d-flex
              flex-wrap
            >
              <v-col
                v-for="area in areas"
                :key="area.id"
                :cols="12"
                class="area"
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
                    class="area-link"
                  >
                    {{ prefecture.title }}
                  </a>
                </v-flex>
              </v-col>
            </v-flex>
            <div class="button">
              <button @click="showMore(false)">
                閉じる&nbsp;
                <v-icon x-small>
                  mdi-minus
                </v-icon>
              </button>
            </div>
          </div>
        </div>
      </div>
      <!-- select CITY component -->
      <div v-else-if="mode === 'city'">
        <div class="city-select-area SP">
          <div class="area-title">
            {{ selectedPrefecture.title }}の市区町村一覧
          </div>
          <v-flex d-flex flex-wrap class="list">
            <a
              v-for="city in cityCards"
              :key="city.cityCode"
              @click="showTeamsRelatedToCity(city.cityCode)"
              class="area-link"
            >
              {{ city.cityName }}
            </a>
          </v-flex>
        </div>
      </div>
    </div>
    <div v-else>
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
                class="area-link"
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
              class="area-link"
            >
              {{ city.cityName }}
            </a>
          </v-flex>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      mode: 'prefecture',
      areas: this.$AREA,
      topPrefecture: this.$TOP_PREFECTURE,
      cityCards: [],
      selectedPrefecture: { title: '' },
      isShowMore: false
    }
  },
  methods: {
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
    },
    showMore (act) {
      this.isShowMore = act
    }
  }
}
</script>

<style lang="scss" scoped>
.page-content {
  width: 100%;
  margin: 32px;
  .area-link {
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
.page-content .page-content-title.SP {
  font-size: 14px;
  .back {
    font-size: 12px;
  }
}
.area-title {
  font-size: 14px;
}
.city-select-area {
  padding: 12px;
}
.prefecture-area.SP {
  display: block;
  .cards {
    padding: 8px;
  }
  .card {
    .v-responsive__content {
      height: 100%;
      .prefecture-title {
        width: 100%;
        margin: 0;
        padding: 0;
        font-size: 12px;
        line-height: 12px;
        text-align: center;
      }
    }
  }
  .area-title {
    font-size: 12px;
  }
  .area {
    padding: 4px 12px;
  }
  .area-link {
    padding: 0;
    margin: 0 4px;
    font-size: 12px;
  }
  .show-more {
    width: 100%;
    padding: 8px;
    .button {
      font-size: 10px;
      color: #0000008A;
      text-align: center;
    }
    .list {
      display: flex;
      padding: 8px 8px 0 8px;
      p {
        font-size: 12px;
        margin-right: 4px;
      }
    }
  }
}
.city-select-area.SP .area-link {
  padding: 2px;
  margin: 0 4px;
  font-size: 12px;
}
</style>
