<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div v-if="$vuetify.breakpoint.smAndDown">
      <Salons :salons="user.salons" />
    </div>
    <v-row v-else>
      <v-col cols="12" sm="3">
        <Menu />
      </v-col>
      <v-col cols="12" sm="9">
        <Salons :salons="user.salons" />
      </v-col>
    </v-row>
  </div>
</template>

<script>
import Menu from '~/components/settings/organisms/Menu.vue'
import Salons from '~/components/settings/organisms/Salons.vue'

export default {
  components: { Menu, Salons },
  data () {
    return {
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: '各種設定',
          link: true,
          exact: true,
          disabled: false,
          to: {
            path: '/settings'
          }
        },
        {
          text: 'オンラインサロン',
          disabled: true
        }
      ],
      user: {}
    }
  },
  head () {
    return {
      title: 'オンラインサロン - 各種設定 | '
    }
  },
  created () {
    // 未ログインの場合はトップ画面へリダイレクトする
    if (!localStorage.getItem('token')) {
      this.$router.replace('/')
    }
    this.getUser()
  },
  methods: {
    getUser () {
      this.user = {
        id: 1,
        name: 'ユーザー名',
        mailAddress: 'test@gmail.com',
        favoriteTeams: [],
        salons: {
          owned: [
            { id: 101, name: '掲載中のサロン名', caption: 'サロンの概要', content: 'サロンの説明', plans: [{ id: 1, name: 'プラン名', caption: 'プランの説明' }], participations_count: 0 }
          ],
          participation: [
            { id: 201, name: '参加中のサロン名1', owner_name: 'オーナー', caption: 'サロンの概要', content: 'サロンの説明', plans: [{ id: 1, name: 'プラン名', caption: 'プランの説明' }] },
            { id: 202, name: '参加中のサロン名2', owner_name: 'オーナー', caption: 'サロンの概要', content: 'サロンの説明', plans: [{ id: 1, name: 'プラン名', caption: 'プランの説明' }] },
            { id: 203, name: '参加中のサロン名3', owner_name: 'オーナー', caption: 'サロンの概要', content: 'サロンの説明', plans: [{ id: 1, name: 'プラン名', caption: 'プランの説明' }] },
            { id: 204, name: '参加中のサロン名4', owner_name: 'オーナー', caption: 'サロンの概要', content: 'サロンの説明', plans: [{ id: 1, name: 'プラン名', caption: 'プランの説明' }] }
          ]
        }
      }
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
