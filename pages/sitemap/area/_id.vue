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
    <div>{{ getSelectedPrefectureName() }}の市区町村一覧</div>
    <ul class="d-flex flex-wrap">
      <li v-for="city in cities" :key="city.id" class="mx-2 py-1">
        <router-link :to="`/sitemap/teams?prefCode=${city.prefCode}&cityCode=${city.cityCode}`">
          {{ city.cityName }}
        </router-link>
      </li>
    </ul>
  </v-layout>
</template>

<script>
export default {
  data () {
    return {
      areas: this.$AREA,
      cities: [],
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: 'サイトマップ',
          link: true,
          exact: true,
          disabled: false,
          to: {
            path: '/sitemap'
          }
        },
        {
          text: `${this.getSelectedPrefectureName()}の市区町村一覧`,
          disabled: true
        }
      ]
    }
  },
  head () {
    return {
      title: this.getPageTitle()
    }
  },
  created () {
    this.getCities()
  },
  methods: {
    getPageTitle () {
      return `サイトマップ - ${this.getSelectedPrefectureName()}の市区町村一覧 | `
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
            this.cities = response.data.result
          }
        })
    },
    getSelectedPrefectureName () {
      let prefectures = []
      this.$AREA.forEach((area) => {
        prefectures = [...prefectures, ...area.prefectures]
      })
      const prefecture = prefectures.find(pref => pref.id === Number(this.$route.params.id))
      return prefecture.title
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
