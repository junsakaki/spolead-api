<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div class="text-h5 font-weight-bold">
      {{ fund.name }}
    </div>
    <v-row no-gutters class="mt-8">
      <v-col cols="12" md="8">
        <div class="body-1">
          {{ fund.caption }}
        </div>
        <div class="body-2 mt-8">
          {{ fund.owner.name }}
        </div>
        <v-img
          v-if="fund.imageTop"
          :src="fund.imageTop"
          max-height="200"
          max-width="100%"
          class="fund-image mt-8"
        />
        <div v-else class="fund-image mt-8" />
        <!-- <v-img
          v-if="fund.imageSub"
          :src="fund.imageSub"
          max-height="200"
          max-width="100%"
          class="fund-image mt-8"
        />
        <div v-else class="fund-image mt-8" /> -->
        <div class="content mt-8">
          <div class="text-h5 font-weight-bold">
            ファンド概要
          </div>
          <div class="mt-2">
            <p v-html="transformTextToHtml(fund.content)" />
          </div>
        </div>
        <div class="background mt-8">
          <div class="text-h5 font-weight-bold">
            背景
          </div>
          <div class="mt-2">
            <p class="body-1" v-html="transformTextToHtml(fund.background)" />
          </div>
        </div>
        <div class="selfIntroduction mt-8">
          <div class="text-h5 font-weight-bold">
            自己紹介
          </div>
          <div class="mt-2">
            <p class="body-1" v-html="transformTextToHtml(fund.selfIntroduction)" />
          </div>
        </div>
        <div class="precautions mt-8">
          <div class="text-h5 font-weight-bold">
            注意事項
          </div>
          <div class="mt-2">
            <p class="body-1" v-html="transformTextToHtml(fund.precautions)" />
          </div>
        </div>
      </v-col>
      <v-col cols="12" md="4" :class="!$vuetify.breakpoint.smAndDown && 'pl-4'">
        <v-banner elevation="4" rounded>
          <div class="py-4">
            <div class="body-2 font-weight-bold">
              現在
            </div>
            <div class="text-h4  font-weight-bold ml-4">
              {{ fund.supportedMoney.toLocaleString() }}円
            </div>
            <div class="meter mt-4">
              <div class="meter-in">
                <div class="bar" :style="`width: ${Math.floor(fund.supportedMoney/fund.targetMoney*100)}%;`">
                  <span>{{ Math.floor(fund.supportedMoney/fund.targetMoney*100) }}%</span>
                </div>
              </div>
              <span>{{ Math.floor(fund.supportedMoney/fund.targetMoney*100) }}%</span>
            </div>
            <div class="caption  font-weight-bold ml-4">
              目標金額: {{ fund.targetMoney.toLocaleString() }}円
            </div>
            <div class="body-2 font-weight-bold">
              支援者
            </div>
            <div class="text-h4 font-weight-bold ml-4">
              {{ fund.supportersCount.toLocaleString() }}人
            </div>
            <div class="body-2 font-weight-bold">
              残り
            </div>
            <div class="text-h4 font-weight-bold ml-4">
              10日
              <!-- {{ fund.limitDate }}日 -->
            </div>
          </div>
        </v-banner>
        <v-banner elevation="4" rounded class="mt-4">
          <div v-for="(item, i) in fund.reductions" :key="item.id" class="py-4">
            <div class="body-1 font-weight-bold">
              {{ item.name }}
            </div>
            <div class="text-caption">
              {{ item.caption }}
            </div>
            <div class="text-center mt-4">
              <font style="font-size: 28px;">
                {{ item.price.toLocaleString() }}
              </font>
              円
            </div>
            <div class="d-flex justify-center align-center">
              <router-link :to="`/payment?type=fund&id=${item.id}`" class="text-center mt-4">
                <common-button button-color="primary">
                  このリターンで支援する
                </common-button>
              </router-link>
            </div>
            <v-divider v-if="i !== fund.reductions.length - 1" class="mt-8" />
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
      fund: {}
    }
  },
  head () {
    return {
      title: `${this.fund.name} - クラウドファンディング | `
    }
  },
  created () {
    this.getFundDetail()
  },
  methods: {
    getFundDetail () {
      this.fund = {
        id: 101,
        name: ' 何度でも立ち上がる強い心と体でプロレス地方大会を開催したい',
        caption: '2022年4月3日(13時開始)愛知県スポルティーバアリーナで初の地方大会を開催することになりました。何度でも立ち上がる強い心と体で東京以外の土地でも自分の好きな選手と共にプロレス大会を開催します！ご支援のほど宜しくお願い致します。',
        imageTop: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSa3404Eb2IpfFK6JPahYOKqTnG02RnISWSWA&usqp=CAU',
        // imageSub: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSa3404Eb2IpfFK6JPahYOKqTnG02RnISWSWA&usqp=CAU',
        content: '<h1>タイトル</h1><h2>サブタイトル</h2><div>a<br>a<br>a<br>a<br>a<br>a<br>a<br>a<br>a<br>a<br>a</div>',
        background: 'クラウドファンディングを募集した背景',
        selfIntroduction: '運営者の自己紹介',
        precautions: '注意事項',
        targetMoney: 500000,
        supportedMoney: 490000,
        supportersCount: 100,
        limitDate: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
        reductions: [
          { id: 1, name: 'リターン1', caption: 'リターン1の説明', price: 10000, participations_count: 100 },
          { id: 2, name: 'リターン2', caption: 'リターン2の説明', price: 20000, participations_count: 10 }
        ],
        owner: {
          name: '落合陽一'
        }
      }
      this.breadcrumbs = [
        ...this.$BREADCRUMBS,
        {
          text: 'クラウドファンディング',
          link: true,
          exact: true,
          disabled: false,
          to: {
            path: '/funds'
          }
        },
        {
          text: this.fund.name,
          disabled: true
        }
      ]
    }
  }
}
</script>

<style lang="scss" scoped>
.fund-image {
  width: 100%;
  height: 200px;
  background: grey;
}
.plan-name {
  border-bottom: solid 1px blue;
}
.meter {
  padding: 12px 8px;
  height: 35px;
  width: 100%;
  >span {
    display: none;
  }
  .meter-in {
    overflow: hidden;
    background-color: #e4e4e4;
    width: 100%;
    height: 15px;
    border-top-right-radius: 7px;
    border-top-left-radius: 7px;
    border-bottom-right-radius: 7px;
    border-bottom-left-radius: 7px;
    .bar {
      background: linear-gradient(270deg, #1976d2 0%, #1976d2 17.48%, #1976d2 49.56%, #324ad3 69.79%, #4f32d3 100%);
      max-width: 100%;
      height: 100%;
      color: #ffffff;
      text-align: left;
      line-height: 16px;
      font-size: 11px;
      border-top-right-radius: inherit;
      border-top-left-radius: inherit;
      border-bottom-right-radius: inherit;
      border-bottom-left-radius: inherit;span {
        display: inline-block;
        margin-left: 7px;
      }
    }
  }
}
</style>
