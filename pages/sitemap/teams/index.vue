<template>
  <v-layout
    column
    class="page-container"
  >
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div v-if="teams.length > 0">
      <div>{{ getTeamsLabel() }}のチーム一覧</div>
      <ul>
        <li v-for="team in teams" :key="team.id">
          <a @click="goTeamDetail(team.id)">
            {{ team.name }}
          </a>
        </li>
      </ul>
      <Pagination :total-pages="totalPages" :page="page" @execPagination="execPagination" />
    </div>
    <div v-else>
      <div v-if="!isLoading" class="grey--text">
        該当のチームはありません
      </div>
    </div>
  </v-layout>
</template>

<script>
import Pagination from '~/components/shared/molecules/Pagination.vue'

export default {
  components: {
    Pagination
  },
  data () {
    return {
      sports: this.$SPORTS,
      areas: this.$AREA,
      teams: [],
      page: 1,
      totalPages: 15,
      breadcrumbs: [],
      isLoading: true,
      selectedCity: {},
      pref: null
    }
  },
  head () {
    return {
      title: 'サイトマップ | '
    }
  },
  created () {
    this.getTeams()
    this.getCities()
    this.findPrefecture()
  },
  methods: {
    getTeams () {
      this.isLoading = true
      let params = {}
      if (this.$route.query.sportsId) {
        params = {
          sports_id: this.$route.query.sportsId
        }
      }
      if (this.$route.query.cityCode) {
        params = {
          city_code: this.$route.query.cityCode
        }
      }
      params.search_word = ''
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
        })
    },
    goTeamDetail (teamId) {
      localStorage.setItem('teamId', teamId)
      this.$router.push({ path: `/teams/${teamId}`, query: { ...this.$route.query, page: this.page } })
    },
    execPagination (page) {
      window.scroll(0, 0)
      this.teams = []
      this.page = page
      this.$router.push({ path: '/sitemap/teams', params: { sportsId: localStorage.getItem('sportsId') }, query: { sportsId: localStorage.getItem('sportsId'), page } })
      this.getTeams()
    },
    getCities () {
      this.mode = 'city'
      this.$store
        .dispatch('api/apiRequest', {
          api: 'getCityApi',
          params: {
            prefCode: this.$route.params.id
          }
        })
        .then((response) => {
          if (response.status === 200) {
            this.selectedCity = response.data.result.find(data => data.cityCode === this.$route.query.cityCode)
            this.getBreadcrumbs()
          }
        })
    },
    findPrefecture () {
      if (!this.$route.query.prefCode) {
        return
      }
      let prefectures = []
      this.areas.forEach((area) => {
        prefectures = [...prefectures, ...area.prefectures]
      })
      this.pref = prefectures.find(pref => pref.id === Number(this.$route.query.prefCode))
    },
    getTeamsLabel () {
      let label = ''
      if (this.$route.query.sportsId) {
        label = this.sports.find(sport => sport.id === Number(this.$route.query.sportsId)).title
      }
      if (this.$route.query.prefCode) {
        const prefecture = this.pref
        label = prefecture.title + this.selectedCity.cityName ?? ''
      }
      return label
    },
    getBreadcrumbs () {
      const nextBreadcrumbs = [
        ...this.$BREADCRUMBS,
        {
          text: 'サイトマップ',
          link: true,
          exact: true,
          disabled: false,
          to: {
            path: '/sitemap'
          }
        }
      ]
      if (this.$route.query.prefCode) {
        nextBreadcrumbs.push({
          text: `${this.pref.title}の市区町村一覧`,
          link: true,
          exact: true,
          disabled: false,
          to: {
            path: `/sitemap/area/${this.$route.query.prefCode}`
          }
        })
      }
      this.breadcrumbs = [
        ...nextBreadcrumbs,
        {
          text: `${this.getTeamsLabel()}のチーム一覧`,
          disabled: true
        }
      ]
    }
  }
}
</script>

<style lang="scss" scoped>
.page-container {
  width: 100%;
}
li {
  list-style: none;
}
</style>
