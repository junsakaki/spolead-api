<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <Lessons v-if="!!$store.state.organizer.user.owned.lessons" :lessons="$store.state.organizer.user.owned.lessons" />
    <UnapplyedService v-else />
  </div>
</template>

<script>
import Lessons from '~/components/organizer/organisms/Lessons.vue'
import UnapplyedService from '~/components/shared/organisms/UnapplyedService.vue'

export default {
  components: { Lessons, UnapplyedService },
  data () {
    return {
      breadcrumbs: [
        ...this.$ORGANIZER_BREADCRUMBS,
        {
          text: '指導者マッチング',
          disabled: true
        }
      ]
    }
  },
  head () {
    return {
      title: '指導者マッチング | 管理者ページ | '
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
