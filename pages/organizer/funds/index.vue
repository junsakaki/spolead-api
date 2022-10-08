<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <Funds v-if="!!$store.state.organizer.user.owned.funds" :funds="$store.state.organizer.user.owned.funds" />
    <UnapplyedService v-else />
  </div>
</template>

<script>
import Funds from '~/components/organizer/organisms/Funds.vue'
import UnapplyedService from '~/components/shared/organisms/UnapplyedService.vue'

export default {
  components: { Funds, UnapplyedService },
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
