<template>
  <v-layout
    column
    justify-center
    align-center
  >
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template v-slot:divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div v-if="!isLoading && !isError" class="page-header">
      <common-button @click="showRegistTeamModal" button-color="primary">
        チーム・スクールを登録する
      </common-button>
    </div>
    <div v-if="teams.length > 0">
      <div class="page-header-title">
        <SearchForm :class="isMobile && 'SP'" @execSearch="execSearch" />
      </div>
      <v-flex
        v-for="team in teams"
        :key="team.id"
        xs12
        sm8
        md6
        flex-wrap
        class="page-content"
      >
        <div :class="`page-content-item ${isMobile && 'SP'}`">
          <div class="page-content-item-header" style="display">
            {{ team.name }} ({{ team.prefecture }}{{ team.city }}{{ team.street_number }})
            <v-chip color="primary" x-small>
              {{ teamTypeList[team.team_type] }}
            </v-chip>
            <v-chip color="primary" x-small>
              {{ targetAgeList[team.target_age_type] }}
            </v-chip>
            <!-- <v-rating v-model="team.average_point" v-if="team.average_point" readonly /> -->
          </div>
          <div :class="`${isMobile && 'flex'} page-content-item-main`">
            <div class="page-content-item-list">
              <v-card class="d-inline-block mx-auto">
                <v-container>
                  <v-row justify="space-between">
                    <v-col cols="auto">
                      <v-img
                        :src="team.team_image ? team.team_image : ''"
                        height="200"
                        width="200"
                      />
                    </v-col>
                  </v-row>
                </v-container>
              </v-card>
            </div>
            <div class="page-content-item-list">
              <div v-if="team.average_point" class="page-content-item-lists">
                <span class="text--lighten-2 mr-1">
                  ({{ team.average_point }})
                </span>
                <v-rating v-model="team.average_point" readonly />
              </div>
              <div class="page-content-item-lists">
                <p v-html="transformTextToHtml(team.team_information)" />
              </div>
              <v-divider :inset="false" class="inner-divider" />
              <div class="page-content-item-lists grey--text">
                最新の口コミ評価({{ getLatestReview(team.reviews) ? new Date(getLatestReview(team.reviews).updated_at).toLocaleString() : 'まだ口コミがありません' }})
              </div>
              <div v-if="getLatestReview(team.reviews)" class="page-content-item-lists mx-6">
                <p v-html="transformTextToHtml(getLatestReview(team.reviews).general_post)" />
              </div>
            </div>
          </div>
          <div class="page-content-item-footer">
            <common-button @click="goTeamDetail(team.id)" button-color="primary">
              チーム・スクールの詳細を確認する
            </common-button>
          </div>
        </div>
        <v-divider :inset="false" />
      </v-flex>
      <!-- <common-button button-size="large" button-color="primary" button-width="25vw">
        ユーザー登録
      </common-button> -->
      <Pagination @execPagination="execPagination" :totalPages="totalPages" :page="page" />
    </div>
    <div else class="skelton-area">
      <span v-if="isError" class="red--text">チーム一覧の取得に失敗しました</span>
      <TeamsSkelton v-if="isLoading" />
      <span v-if="!isError && !isLoading" class="grey--text">登録されているチームはありません</span>
    </div>
    <team-regist-modal :dialog="registTeamModal" @registTeam="registTeam" />
  </v-layout>
</template>

<script>
import queryString from 'query-string'
import { colors } from '~/assets/js/Colors.js'
import CommonButton from '~/components/shared/atoms/CommonButton.vue'
import TeamRegistModal from '~/components/teams/organisms/TeamRegistModal.vue'
import SearchForm from '~/components/teams/molecules/SearchForm.vue'
import Pagination from '~/components/teams/molecules/Pagination.vue'
import TeamsSkelton from '~/components/teams/organisms/TeamsSkelton.vue'
import transformTextToHtml from '~/utils/transformTextToHtml'

export default {
  head () {
    return {
      title: this.pageTitle
    }
  },
  components: {
    CommonButton,
    SearchForm,
    TeamRegistModal,
    Pagination,
    TeamsSkelton
  },
  data () {
    return {
      colors,
      transformTextToHtml,
      valid: true,
      nickname: '',
      email: '',
      password: '',
      passwordConfirm: '',
      registTeamModal: false,
      teams: [],
      searchWord: '',
      page: queryString.parse(location.search).page ? Number(queryString.parse(location.search).page) : 1,
      totalPages: 15,
      targetAgeList: [null, 'キッズ', '小学生', '中学生', '高校生', '大学・専門学生', '社会人'],
      teamTypeList: [null, 'チーム', 'スクール'],
      isMobile: this.$vuetify.breakpoint.smAndDown,
      params: {},
      breadcrumbs: [],
      isLoading: false,
      isError: false,
      selectedCity: undefined,
      pageTitle: undefined
    }
  },
  computed: {
    isLogin () {
      return !!localStorage.getItem('userId')
    }
  },
  created () {
    const { prefCode, cityCode } = this.$route.query
    this.getTeams()
    this.getCityData({ prefCode, cityCode })
  },
  methods: {
    getTeams () {
      this.isLoading = true
      this.isError = false
      let params = {}
      // get Teams related to sportsId
      if (localStorage.getItem('sportsId')) {
        params = {
          sports_id: localStorage.getItem('sportsId')
        }
      // get Teams related to cityCodes
      } else {
        params = {
          city_code: localStorage.getItem('cityCode')
        }
      }
      this.params = params

      params.search_word = this.searchWord
      params.page = this.page

      this.$store
        .dispatch('api/apiRequest', {
          api: 'teamIndex',
          params
        }).then((res) => {
          this.isLoading = false
          if (res.status === 200) {
            scrollTo(0, 0)
            this.teams = res.data.teams
            this.totalPages = res.data.meta
          }
        }).catch(() => {
          this.isLoading = false
          this.isError = true
        })
    },
    goLoginPage () {
      this.$router.push('/login')
    },
    goTeamDetail (teamId) {
      localStorage.setItem('teamId', teamId)
      this.$router.push({ path: `teams/${teamId}`, query: { ...this.$route.query, page: this.page } })
    },
    showRegistTeamModal () {
      this.registTeamModal = true
    },
    registTeam () {
      this.getTeams()
      this.closeModal()
    },
    closeModal () {
      this.registTeamModal = false
    },
    execSearch (searchWord) {
      this.searchWord = searchWord
      this.page = 1
      this.getTeams()
    },
    getLatestReview (reviews) {
      let latestReviewDate = ''
      let latestReview = ''
      if (reviews) {
        if (reviews.length > 0) {
          reviews.forEach((review) => {
            const updatedAt = new Date(review.updated_at)
            latestReviewDate = updatedAt
            latestReview = review
            if (review.updated_at > latestReviewDate) {
              latestReviewDate = updatedAt
              latestReview = review
            }
          })
        }
      }
      return latestReview === '' ? false : latestReview
    },
    execPagination (page) {
      this.page = page
      this.$router.push({ name: 'teams', params: { sportsId: localStorage.getItem('sportsId') }, query: { sportsId: localStorage.getItem('sportsId'), page } })
      this.getTeams()
    },
    getCityData ({ prefCode, cityCode }) {
      if (!prefCode || !cityCode) {
        this.selectedCity = undefined
      }
      this.$store
        .dispatch('api/apiRequest', {
          api: 'getCityApi',
          params: {
            prefCode
          }
        })
        .then((response) => {
          if (response.status === 200) {
            this.selectedCity = response.data.result.find(city => city.cityCode === cityCode)
            this.pageTitle = this.getPageTitle({ isBreadcrumbs: false })
            this.breadcrumbs = [
              ...this.$BREADCRUMBS,
              {
                text: this.getPageTitle({ isBreadcrumbs: true }),
                disabled: true
              }
            ]
          }
        })
    },
    getPageTitle ({ isBreadcrumbs }) {
      const { sportsId } = this.$route.query
      const sportsTitle = sportsId ? this.$SPORTS.find(item => item.id === Number(sportsId)).title : undefined
      const cityName = this.selectedCity?.cityName ?? undefined
      const page = this.page ? `（${this.page}ページ目）` : undefined
      return `${sportsTitle ?? ''}${cityName ?? ''}のチーム・スクール${page ?? ''}${isBreadcrumbs ? '' : ' | '}`
    }
  }
}
</script>

<style lang="scss" scoped>
@import '~/assets/scss/page.scss';
.page-header {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  width: 100%;
}
.page-content {
  @include default-page-content;
  &-item {
    &-footer {
      justify-content: flex-end;
    }
    .page-content-item-lists {
      display: flex;
      align-items: center;
    }
    .inner-divider {
      margin: 0px 12px;
    }
  }
}
.v-input {
  width: 25vw;
}
.search-field.SP {
  width: 100%;
}
.flex {
  display: flex;
  flex-direction: column;
  align-items: center;
}
.page-content-item {
  width: 100%;
}
.page-content-item.SP {
  width: fit-content;
}
.skelton-area {
  width: 100%;
  text-align: center;
}
</style>
