<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div v-if="$vuetify.breakpoint.smAndDown" class="mb-6">
      <Lessons :lessons="user.lessons" />
    </div>
    <v-row v-else class="mb-6">
      <v-col cols="12" sm="3">
        <Menu />
      </v-col>
      <v-col cols="12" sm="9">
        <Lessons :lessons="user.lessons" />
      </v-col>
    </v-row>
  </div>
</template>

<script>
import Menu from '~/components/settings/organisms/Menu.vue'
import Lessons from '~/components/settings/organisms/Lessons.vue'

export default {
  components: { Menu, Lessons },
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
          text: '指導者マッチング',
          disabled: true
        }
      ],
      user: {}
    }
  },
  head () {
    return {
      title: '指導者マッチング - 各種設定 | '
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
        lessons: [
          {
            id: 101,
            recruitment_target: 'student',
            name: 'サッカー、フットサルの為の身体作りサポートしますサッカー、フットサルの為の身体作りサポートします',
            caption: 'フィジカルに悩む方向け！元プロフットサル選手がサポート。',
            contactType: '1'.split(',').map(Number),
            paymentType: '1,2'.split(',').map(Number),
            content: 'サッカー、フットサルをプレーする皆さん。食べてるのに身体が大きくならない、フィジカル不足で試合で活躍出来ない、そういった悩みがある方多いことでしょう。かつては私もそうでした。ですが、様々な知識を蓄え、試行錯誤をし身体を鍛え上げ日本のフットサルトップリーグ、『Fリーグ』でフィジカルを武器に闘えるまでになった経験をお伝えします。トレーニングメニュー、食事指導、プレー分析等、何でも遠慮なくご相談ください。',
            imageTop: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSa3404Eb2IpfFK6JPahYOKqTnG02RnISWSWA&usqp=CAU',
            background: '背景はこんな感じです',
            selfIntroduction: '私はこんな人です',
            precautions: '注意事項はこんな感じです',
            owner: {
              name: 'オーナー名',
              address: '住所',
              mail_address: 'メールアドレス',
              birthday: '生年月日',
              tel: '電話番号',
              identification1: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSa3404Eb2IpfFK6JPahYOKqTnG02RnISWSWA&usqp=CAU',
              identification2: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSa3404Eb2IpfFK6JPahYOKqTnG02RnISWSWA&usqp=CAU',
              transferAccount: '振り込み口座の情報'
            },
            talks: [
              { id: 2011, comments: [{ content: '依頼内容を送ります。依頼内容を送ります。依頼内容を送ります。依頼内容を送ります。依頼内容を送ります。依頼内容を送ります。依頼内容を送ります。', user: { id: 1, name: 'しょうた' } }], users: [{ id: 1, name: 'しょうた' }, { id: 2, name: 'ゆうた' }] },
              { id: 2012, comments: [], users: [{ id: 1, name: 'しょうた' }, { id: 2, name: 'ゆうた' }] },
              { id: 2013, comments: [], users: [{ id: 1, name: 'しょうた' }, { id: 2, name: 'ゆうた' }] }
            ]
          },
          {
            id: 201,
            recruitment_target: 'coach',
            name: 'サッカーを教えてほしいです！小学生です！',
            caption: '将来の夢はJリーガーです！',
            contactType: '1,2'.split(',').map(Number),
            paymentType: '1'.split(',').map(Number),
            owner: {
              name: 'オーナー名',
              address: '住所',
              mail_address: 'メールアドレス',
              birthday: '生年月日',
              tel: '電話番号',
              identification1: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSa3404Eb2IpfFK6JPahYOKqTnG02RnISWSWA&usqp=CAU',
              identification2: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSa3404Eb2IpfFK6JPahYOKqTnG02RnISWSWA&usqp=CAU'
            },
            talks: [
              { id: 2011, comments: [{ content: '依頼内容を送ります。', user: { id: 1, name: 'しょうた' } }], users: [{ id: 1, name: 'しょうた' }, { id: 2, name: 'ゆうた' }] },
              { id: 2012, comments: [], users: [{ id: 1, name: 'しょうた' }, { id: 2, name: 'ゆうた' }] },
              { id: 2013, comments: [], users: [{ id: 1, name: 'しょうた' }, { id: 2, name: 'ゆうた' }] }
            ]
          }
        ]
      }
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
