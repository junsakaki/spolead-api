<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div v-if="$vuetify.breakpoint.smAndDown" class="mb-6">
      <Salons :salons="user.salons" />
    </div>
    <v-row v-else class="mb-6">
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
    if (!this.$auth.loggedIn) {
      this.$router.replace('/login')
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
          owned: [{
            id: 101,
            name: '運営中のサロン1',
            caption: '運営中のサロン1の説明',
            imageTop: '',
            imageSub: '',
            content: '運営中のサロン1の内容',
            background: '運営中のサロン1の開催背景',
            selfIntroduction: '自己紹介',
            precautions: '注意事項',
            plans: [
              { id: 1, name: 'プラン1', caption: 'プラン1の説明', price: 10000, participations_count: 100 },
              { id: 2, name: 'プラン2', caption: 'プラン2の説明', price: 20000, participations_count: 10 }
            ],
            owner: {
              name: 'オーナー名',
              address: '住所',
              mail_address: 'mail@gmail.com',
              birthday: '生年月日',
              tel: '電話番号',
              identification1: '',
              identification2: '',
              transferAccount: '振り込み口座情報'
            }
          }, {
            id: 102,
            name: '運営中のサロン2',
            caption: '運営中のサロン2の説明',
            imageTop: '',
            imageSub: '',
            content: '運営中のサロン2の内容',
            background: '運営中のサロン2の開催背景',
            selfIntroduction: '自己紹介',
            precautions: '注意事項',
            plans: [
              { id: 1, name: 'プラン1', caption: 'プラン1の説明', price: 10000, participations_count: 20 }
            ],
            owner: {
              name: 'オーナー名',
              address: '住所',
              mail_address: 'mail@gmail.com',
              birthday: '生年月日',
              tel: '電話番号',
              identification1: '',
              identification2: '',
              transferAccount: '振り込み口座情報'
            }
          }],
          participating: [
            {
              id: 201,
              name: '参加中のサロン1',
              plan: { id: 1, name: 'プラン1', caption: 'プラン1の説明', price: 10000 },
              owner: {
                name: 'オーナー名'
              }
            },
            {
              id: 201,
              name: '参加中のサロン1',
              plan: { id: 2, name: 'プラン2', caption: 'プラン2の説明', price: 20000 },
              owner: {
                name: 'オーナー名'
              }
            }
          ]
        }
      }
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
