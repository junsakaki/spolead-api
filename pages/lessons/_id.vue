<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <v-row no-gutters>
      <v-col cols="12" md="8">
        <div class="text-h5 font-weight-bold">
          {{ salon.name }}
        </div>
        <div class="body-1 mt-8">
          {{ salon.caption }}
        </div>
        <div class="body-2 mt-8">
          {{ salon.owner.name }}
        </div>
        <v-img
          v-if="salon.imageTop"
          :src="salon.imageTop"
          max-height="200"
          max-width="100%"
          class="salon-image mt-8"
        />
        <div v-else class="salon-image mt-8" />
        <!-- <v-img
          v-if="salon.imageSub"
          :src="salon.imageSub"
          max-height="200"
          max-width="100%"
          class="salon-image mt-8"
        />
        <div v-else class="salon-image mt-8" /> -->
        <div class="mt-8 d-flex align-center">
          <div class="body-1 font-weight-bold mr-4">
            受講タイプ
          </div>
          <v-chip v-for="contactType in salon.contactType" :key="`contactType-${contactType}`" color="primary" x-small class="mx-1">
            {{ getContactType(contactType) }}
          </v-chip>
        </div>
        <div class="mt-8 d-flex align-center">
          <div class="body-1 font-weight-bold mr-4">
            支払いタイプ
          </div>
          <v-chip v-for="paymentType in salon.paymentType" :key="`paymentType-${paymentType}`" color="primary" x-small class="mx-1">
            {{ getPaymentType(paymentType) }}
          </v-chip>
        </div>
        <div class="content mt-8">
          <div class="text-h5 font-weight-bold">
            サロン概要
          </div>
          <div class="mt-2">
            <p v-html="transformTextToHtml(salon.content)" />
          </div>
        </div>
        <div class="background mt-8">
          <div class="text-h5 font-weight-bold">
            背景
          </div>
          <div class="mt-2">
            <p class="body-1" v-html="transformTextToHtml(salon.background)" />
          </div>
        </div>
        <div class="selfIntroduction mt-8">
          <div class="text-h5 font-weight-bold">
            自己紹介
          </div>
          <div class="mt-2">
            <p class="body-1" v-html="transformTextToHtml(salon.selfIntroduction)" />
          </div>
        </div>
      </v-col>
      <v-col cols="12" md="4" :class="!$vuetify.breakpoint.smAndDown && 'pl-4'">
        <v-banner elevation="4" rounded>
          <div class="py-4">
            <div class="body-1 font-weight-bold">
              指導依頼
            </div>
            <div class="caption">
              指導を依頼してトークルームを開始します。注意事項をよく読んでから相談ボタンをクリックしてください。
            </div>
            <div class="body-2 font-weight-bold mt-4">
              追加オプション
            </div>
            <v-textarea
              v-model="form.content"
              dense
              required
            />
            <div class="caption font-weight-bold">
              注意事項
            </div>
            <div class="caption">
              {{ salon.precautions }}
            </div>
            <div class="text-center mt-4">
              <common-button button-color="primary" @click="startTalkroom(salon.id)">
                依頼
              </common-button>
            </div>
          </div>
        </v-banner>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import transformTextToHtml from '~/utils/transformTextToHtml'
import CommonButton from '~/components/shared/atoms/CommonButton.vue'

export default {
  components: { CommonButton },
  data () {
    return {
      transformTextToHtml,
      breadcrumbs: [],
      salon: {},
      form: {
        option: ''
      }
    }
  },
  head () {
    return {
      title: `${this.salon.name} - 指導者マッチング | `
    }
  },
  created () {
    this.getSalonDetail()
  },
  methods: {
    getSalonDetail () {
      this.salon = { // 指導内容・購入注意事項・追加オプション・オンライン/直接・スポット/月定額等
        id: 101,
        name: 'サッカー、フットサルの為の身体作りサポートします',
        caption: 'フィジカルに悩む方向け！元プロフットサル選手がサポート。',
        imageTop: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSa3404Eb2IpfFK6JPahYOKqTnG02RnISWSWA&usqp=CAU',
        // imageSub: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSa3404Eb2IpfFK6JPahYOKqTnG02RnISWSWA&usqp=CAU',
        content: '<h1>タイトル</h1><h2>サブタイトル</h2><div>a<br>a<br>a<br>a<br>a<br>a<br>a<br>a<br>a<br>a<br>a</div>',
        background: 'フィジカルに悩む方向け！元プロフットサル選手がサポート。する背景',
        selfIntroduction: 'まるやままさひです！サッカーコーチです！',
        contactType: '1,2'.split(','),
        paymentType: '1,2'.split(','),
        precautions: 'オンラインか直接かは追加オプションに記入をお願いします。',
        owner: {
          name: 'まるやままさひ'
        }
      }
      this.breadcrumbs = [
        ...this.$BREADCRUMBS,
        {
          text: '指導者マッチング',
          link: true,
          exact: true,
          disabled: false,
          to: {
            path: '/lessons'
          }
        },
        {
          text: this.salon.name,
          disabled: true
        }
      ]
    },
    getContactType (contactType) {
      const target = this.$CONTACT_TYPE.find(item => item.id === Number(contactType))
      return target ? target.type : null
    },
    getPaymentType (paymentType) {
      const target = this.$PAYMENT_TYPE.find(item => item.id === Number(paymentType))
      return target ? target.type : null
    },
    startTalkroom (lessonId) {
      // TODO: lessonIdを元にトークルームを作成した上でデフォルトのメッセージを送る（==引用==を見ました！的な）
      // TODO: 受け取ったルームIDヘ遷移する
      this.$router.push(`/talkroom/${1}`)
    }
  }
}
</script>

<style lang="scss" scoped>
.salon-image {
  width: 100%;
  height: 200px;
  background: grey;
}
.plan-name {
  border-bottom: solid 1px blue;
}
</style>
