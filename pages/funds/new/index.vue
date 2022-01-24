<template>
  <v-layout
    column
    justify-center
    align-center
  >
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div class="container">
      <funds-regist-form />
    </div>
  </v-layout>
</template>

<script>
import FundsRegistForm from '~/components/funds/organisms/FundsRegistForm.vue'
export default {
  components: {
    FundsRegistForm
  },
  data () {
    return {
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: 'クラウドファンディングの登録申請',
          disabled: true
        }
      ]
    }
  },
  methods: {
    submit () {
      console.log(this.form)
    }
  }
}
</script>

<style lang="scss" scoped>
@import '~/assets/scss/page.scss';
.container {
  width: 100%;
}
</style>
