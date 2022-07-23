<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <Salons :salons="user.salons" @getUser="getUser" />
  </div>
</template>

<script>
import Salons from '~/components/organizer/organisms/Salons.vue'

export default {
  components: { Salons },
  data () {
    return {
      breadcrumbs: [
        ...this.$ORGANIZER_BREADCRUMBS,
        {
          text: 'オンラインサロン',
          disabled: true
        }
      ],
      user: {
        salons: {
          owned: [],
          participating: []
        }
      }
    }
  },
  head () {
    return {
      title: 'オンラインサロン | 管理者ページ | '
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
