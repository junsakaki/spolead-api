<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div v-if="$vuetify.breakpoint.smAndDown" class="mb-6">
      <Funds :funds="user.funds" />
    </div>
    <v-row v-else class="mb-6">
      <v-col cols="12" sm="3">
        <Menu />
      </v-col>
      <v-col cols="12" sm="9">
        <Funds :funds="user.funds" />
      </v-col>
    </v-row>
  </div>
</template>

<script>
import Menu from '~/components/settings/organisms/Menu.vue'
import Funds from '~/components/settings/organisms/Funds.vue'

export default {
  components: { Menu, Funds },
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
          text: 'クラウドファンディング',
          disabled: true
        }
      ],
      user: {}
    }
  },
  head () {
    return {
      title: 'クラウドファンディング - 各種設定 | '
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
        funds: {
          owned: [{
            id: 101,
            name: '公開中のクラウドファンディング',
            caption: '運営中のファンド1の説明',
            imageTop: '',
            imageSub: '',
            content: '運営中のファンド1の内容',
            background: '運営中のファンド1の開催背景',
            selfIntroduction: '自己紹介',
            precautions: '注意事項',
            targetMoney: 500000,
            supportedMoney: 490000,
            supportersCount: 100,
            limitDate: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
            reductions: [
              { id: 1, name: 'リターン1', caption: 'リターン1の説明', price: 10000, purchased_count: 100 },
              { id: 2, name: 'リターン2', caption: 'リターン2の説明', price: 20000, purchased_count: 10 }
            ],
            owner: {
              name: 'オーナー名',
              address: '住所',
              birthday: '生年月日',
              tel: '電話番号',
              identification1: '',
              identification2: '',
              transferAccount: '振り込み口座情報'
            }
          }],
          purchased: [
            {
              id: 201,
              name: '購入したリターン',
              price: 1000,
              quantity: 1,
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
