<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <v-row class="body-1" no-gutters>
      <v-col cols="12" sm="3" class="font-weight-bold">
        <v-card outlined tile class="pa-2">
          ファンド名称
        </v-card>
      </v-col>
      <v-col cols="12" sm="9">
        <v-card outlined tile class="pa-2">
          {{ reduction.fund.name }}
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" class="font-weight-bold">
        <v-card outlined tile class="pa-2">
          ファンド概要
        </v-card>
      </v-col>
      <v-col cols="12" sm="9">
        <v-card outlined tile class="pa-2">
          {{ reduction.fund.caption }}
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" class="font-weight-bold">
        <v-card outlined tile class="pa-2">
          主催者
        </v-card>
      </v-col>
      <v-col cols="12" sm="9">
        <v-card outlined tile class="pa-2">
          {{ reduction.fund.owner.name }}
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" class="font-weight-bold">
        <v-card outlined tile class="pa-2">
          リターン名称
        </v-card>
      </v-col>
      <v-col cols="12" sm="9">
        <v-card outlined tile class="pa-2">
          {{ reduction.name }}
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" class="font-weight-bold">
        <v-card outlined tile class="pa-2">
          リターン概要
        </v-card>
      </v-col>
      <v-col cols="12" sm="9">
        <v-card outlined tile class="pa-2">
          {{ reduction.caption }}
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" class="font-weight-bold">
        <v-card outlined tile class="pa-2">
          単価
        </v-card>
      </v-col>
      <v-col cols="12" sm="9">
        <v-card outlined tile class="pa-2">
          {{ reduction.price.toLocaleString() }}円
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" class="font-weight-bold">
        <v-card outlined tile class="pa-2">
          購入個数
        </v-card>
      </v-col>
      <v-col cols="12" sm="9">
        <v-card outlined tile class="pa-2">
          <select v-model="purhaseCount" class="select-box px-2">
            <option v-for="item in purhaseCounts" :key="`selectItem-${item.value}`" :value="item.value">
              {{ item.label }}
            </option>
          </select>
          個
        </v-card>
      </v-col>
      <v-col cols="12" sm="3" class="font-weight-bold">
        <v-card outlined tile class="pa-2">
          支払い金額
        </v-card>
      </v-col>
      <v-col cols="12" sm="9">
        <v-card outlined tile class="pa-2">
          {{ (purhaseCount * reduction.price).toLocaleString() }}円
        </v-card>
      </v-col>
    </v-row>
    <div class="mt-4">
      <v-btn color="primary" block :disabled="purhaseCount === null">
        購入手続きへ進む
      </v-btn>
    </div>
  </div>
</template>

<script>

export default {
  data () {
    return {
      breadcrumbs: [],
      purhaseCount: null,
      purhaseCounts: [
        { label: '選択してください', value: null },
        { label: '1', value: 1 },
        { label: '2', value: 2 },
        { label: '3', value: 3 },
        { label: '4', value: 4 },
        { label: '5', value: 5 },
        { label: '6', value: 6 },
        { label: '7', value: 7 },
        { label: '8', value: 8 },
        { label: '9', value: 9 },
        { label: '10', value: 10 }
      ],
      reduction: {
        name: '選択されたリターンの名称',
        caption: '選択されたリターンの説明',
        price: 1000,
        fund: {
          id: 1,
          name: 'ファンドの名称',
          caption: 'ファンドの説明',
          owner: {
            name: '主催者の名前'
          }
        }
      }
    }
  },
  head () {
    return {
      title: `${this.reduction.name} - ${this.reduction.fund.name} - クラウドファンディング | `
    }
  },
  created () {
    this.getFundDetail()
  },
  methods: {
    getFundDetail () {
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
          text: this.reduction.fund.name,
          link: true,
          exact: true,
          disabled: false,
          to: {
            path: `/funds/${this.$route.params.fundId}`
          }
        },
        {
          text: this.reduction.name,
          disabled: true
        }
      ]
    }
  }
}
</script>

<style lang="scss" scoped>
.select-box {
  border: solid 1px rgba(156, 156, 156, 0.37);
  border-radius: 4px !important; // vuetifyの設定に上書きされてしまうため!important
  margin-bottom: -1px; // border分のレイアウト崩れを調整
  margin-top: -1px; // border分のレイアウト崩れを調整
}
</style>
