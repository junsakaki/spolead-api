<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <Funds :funds="user.funds" @getUser="getUser" />
  </div>
</template>

<script>
import Funds from '~/components/organizer/organisms/Funds.vue'

export default {
  components: { Funds },
  data () {
    return {
      breadcrumbs: [
        ...this.$ORGANIZER_BREADCRUMBS,
        {
          text: 'クラウドファンディング',
          disabled: true
        }
      ],
      user: {
        funds: {
          owned: [],
          purchased: []
        }

      }
    }
  },
  head () {
    return {
      title: 'クラウドファンディング | 管理者ページ | '
    }
  },
  created () {
    // 未ログインの場合はトップ画面へリダイレクトする
    if (!this.$auth.loggedIn) {
      this.$router.replace('/login')
    }
    this.getUser()
  },
  methods: {
    getUser () {
      if (this.$auth && this.$auth.user) {
        this.$store
          .dispatch('api/apiRequest', {
            api: 'userIndex',
            query: {
              id: this.$auth.user.sub
            }
          }).then((res) => {
            if (res.status === 200) {
              this.user = res.data.user
            }
          })
      }
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
