<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <Salons v-if="!!$store.state.organizer.user.owned.salons" :salons="$store.state.organizer.user.owned.salons" />
    <UnapplyedService v-else />
  </div>
</template>

<script>
import Salons from '~/components/organizer/organisms/Salons.vue'
import UnapplyedService from '~/components/shared/organisms/UnapplyedService.vue'

export default {
  components: { Salons, UnapplyedService },
  data () {
    return {
      breadcrumbs: [
        ...this.$ORGANIZER_BREADCRUMBS,
        {
          text: 'オンラインサロン',
          disabled: true
        }
      ]
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
