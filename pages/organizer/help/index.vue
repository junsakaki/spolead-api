<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <Help />
  </div>
</template>

<script>
import Help from '~/components/organizer/organisms/Help.vue'

export default {
  components: { Help },
  data () {
    return {
      breadcrumbs: [
        ...this.$ORGANIZER_BREADCRUMBS,
        {
          text: 'ヘルプ・Q&A',
          disabled: true
        }
      ],
      user: {
        salons: {
          owned: [],
          participating: []
        }
      }
    }
  },
  head () {
    return {
      title: 'オンラインサロン | 管理者ページ | '
    }
  },
  created () {
  },
  methods: {
  }
}
</script>
<style lang="scss" scoped>
</style>
