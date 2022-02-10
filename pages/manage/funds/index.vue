<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div v-if="$vuetify.breakpoint.smAndDown" class="mb-6">
      <Funds :funds="funds" @updateApproval="updateApproval" />
    </div>
    <v-row v-else class="mb-6">
      <v-col cols="12" sm="3">
        <Menu />
      </v-col>
      <v-col cols="12" sm="9">
        <Funds :funds="funds" @updateApproval="updateApproval" />
      </v-col>
    </v-row>
  </div>
</template>

<script>
import Menu from '~/components/manage/organisms/Menu.vue'
import Funds from '~/components/manage/organisms/Funds.vue'
import constants from '~/pages/funds/constants.js'

export default {
  components: { Menu, Funds },
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
    this.checkRole()
  },
  methods: {
    updateApproval (funds) {
      console.log('現在は', funds.approval ? '承認済み' : '未承認', 'なので、値を', !funds.approval, 'にします')
    },
    checkRole () {
      if (this.$auth && this.$auth.user) {
        this.$store
          .dispatch('api/apiRequest', {
            api: 'userIndex',
            query: {
              id: this.$auth.user.sub
            }
          }).then((res) => {
            if (res.status === 200) {
              if (res.data.user.role !== 'admin') {
                this.$router.replace('/')
              }
            }
          })
      }
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
