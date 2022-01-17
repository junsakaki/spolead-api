<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div class="d-flex flex-column align-center">
      <span>通報が完了しました</span>
      <router-link to="/" class="complete-link-text">
        <common-button button-color="primary" class="mt-4">
          <v-icon>mdi-home</v-icon>
          <font class="ml-1">
            TOP
          </font>
        </common-button>
      </router-link>
    </div>
  </div>
</template>

<script>
import CommonButton from '../../../components/shared/atoms/CommonButton.vue'

export default {
  components: { CommonButton },
  data () {
    return {
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: '通報完了',
          disabled: true
        }
      ]
    }
  },
  created () {
  },
  methods: {
  }
}
</script>
<style lang="scss">
.complete-link-text {
  text-decoration: none;
}
</style>
