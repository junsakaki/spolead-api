<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div v-if="$vuetify.breakpoint.smAndDown" class="mb-6">
      <Lessons :lessons="lessons" @updateApproval="updateApproval" />
    </div>
    <v-row v-else class="mb-6">
      <v-col cols="12" sm="3">
        <Menu />
      </v-col>
      <v-col cols="12" sm="9">
        <Lessons :lessons="lessons" @updateApproval="updateApproval" />
      </v-col>
    </v-row>
  </div>
</template>

<script>
import Menu from '~/components/manage/organisms/Menu.vue'
import Lessons from '~/components/manage/organisms/Lessons.vue'
import constants from '~/pages/lessons/constants.js'

export default {
  components: { Menu, Lessons },
  data () {
    return {
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: 'サービス管理',
          link: true,
          exact: true,
          disabled: false,
          to: {
            path: '/manage'
          }
        },
        {
          text: 'オンラインサロン',
          disabled: true
        }
      ],
      ...constants
    }
  },
  head () {
    return {
      title: 'オンラインサロン - サービス管理 | '
    }
  },
  created () {
    // 未ログインの場合はトップ画面へリダイレクトする
    if (!this.$auth.loggedIn) {
      this.$router.replace('/login')
    }
  },
  methods: {
    updateApproval (lesson) {
      console.log('現在は', lesson.approval ? '承認済み' : '未承認', 'なので、値を', !lesson.approval, 'にします')
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
