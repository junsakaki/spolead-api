<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <Funds :funds="$store.state.organizer.user.owned.funds" />
  </div>
</template>

<script>
import Funds from '~/components/organizer/organisms/Funds.vue'

export default {
  components: { Funds },
  data () {
    return {
      breadcrumbs: [
        ...this.$ORGANIZER_BREADCRUMBS,
        {
          text: 'クラウドファンディング',
          disabled: true
        }
      ]
    }
  },
  head () {
    return {
      title: 'クラウドファンディング | 管理者ページ | '
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
