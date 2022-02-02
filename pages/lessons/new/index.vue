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
      <lessons-regist-form />
    </div>
  </v-layout>
</template>

<script>
import LessonsRegistForm from '~/components/lessons/organisms/LessonsRegistForm.vue'
export default {
  components: {
    LessonsRegistForm
  },
  data () {
    return {
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: '指導者マッチングの登録申請',
          disabled: true
        }
      ]
    }
  },
  head () {
    return {
      title: '指導者マッチングの登録申請 | '
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
