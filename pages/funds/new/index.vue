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
      <salons-regist-form />
    </div>
  </v-layout>
</template>

<script>
import SalonsRegistForm from '~/components/salons/organisms/SalonsRegistForm.vue'
export default {
  components: {
    SalonsRegistForm
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
