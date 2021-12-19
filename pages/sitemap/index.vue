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
    <div>スポーツから探す</div>
    <ul class="d-flex flex-wrap">
      <li v-for="sport in sports" :key="sport.id" class="mr-2">
        <router-link :to="`/sitemap/teams?sportsId=${sport.id}`" class="text-link">
          {{ sport.title }}
        </router-link>
      </li>
    </ul>
    <div class="mt-4">
      エリアから探す
    </div>
    <ul>
      <li v-for="area in areas" :key="area.id">
        <div>{{ area.title }}</div>
        <ul class="d-flex flex-wrap">
          <li v-for="prefecture in area.prefectures" :key="prefecture.id" class="mr-4">
            <router-link :to="`/sitemap/area/${prefecture.id}`" class="text-link">
              {{ prefecture.title }}
            </router-link>
          </li>
        </ul>
      </li>
    </ul>
  </v-layout>
</template>

<script>
export default {
  data () {
    return {
      sports: this.$SPORTS,
      areas: this.$AREA,
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: 'サイトマップ',
          disabled: true
        }
      ]
    }
  },
  head () {
    return {
      title: 'サイトマップ | '
    }
  },
  methods: {
  }
}
</script>

<style lang="scss" scoped>
.page-container {
  width: 100%;
}
.text-link {
  text-decoration: none;
}
li {
  list-style: none;
}
</style>
