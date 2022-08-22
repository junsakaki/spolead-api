<template>
  <div>
    <TopMessage />
  </div>
</template>

<script>
import TopMessage from '~/components/organizer/organisms/TopMessage.vue'

export default {
  components: { TopMessage },
  head () {
    return {
      title: 'TOP | 管理者ページ | '
    }
  },
  created () {
  }
}
</script>
<style lang="scss" scoped>
</style>
