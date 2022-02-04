<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div>
      <talks-menu :talks="talks" />
    </div>
  </div>
</template>

<script>
import constants from './constants'
import transformTextToHtml from '~/utils/transformTextToHtml'
import TalksMenu from '~/components/talks/organisms/Menu.vue'

export default {
  components: { TalksMenu },
  data () {
    return {
      transformTextToHtml,
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: 'トークルーム',
          disabled: true
        }
      ],
      ...constants
    }
  },
  methods: {
  }
}
</script>
<style lang="scss">
</style>
