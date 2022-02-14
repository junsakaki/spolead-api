<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <v-row class="body-1" no-gutters>
      <template v-if="$route.query.type === 'fund'">
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
      </template>
      <template v-if="$route.query.type === 'salon'">
        <v-col cols="12" sm="3" class="font-weight-bold">
          <v-card outlined tile class="pa-2">
            サロン名称
          </v-card>
        </v-col>
        <v-col cols="12" sm="9">
          <v-card outlined tile class="pa-2">
            サロン名
          </v-card>
        </v-col>
      </template>
      <template v-if="$route.query.type === 'lesson'">
        <v-col cols="12" sm="3" class="font-weight-bold">
          <v-card outlined tile class="pa-2">
            指導者マッチング名称
          </v-card>
        </v-col>
        <v-col cols="12" sm="9">
          <v-card outlined tile class="pa-2">
            指導者マッチング名
          </v-card>
        </v-col>
      </template>
      <v-col cols="12" sm="3" class="font-weight-bold">
        <v-card outlined tile class="pa-2">
          購入個数
          <font color="red" class="ml-2 caption font-weight-bold">
            必須
          </font>
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
      <v-col cols="12" sm="3" class="font-weight-bold">
        <v-card outlined tile style="padding: 15px 8px !important; min-height: 56px;">
          カード情報
          <font color="red" class="ml-2 caption font-weight-bold">
            必須
          </font>
        </v-card>
      </v-col>
      <v-col cols="12" sm="9">
        <v-card outlined tile class="pa-2" style="min-height: 56px;">
          <div>
            <script
              type="text/javascript"
              src="https://checkout.pay.jp/"
              class="payjp-button"
              data-key="pk_test_9b25bd2b15791cf0db83bb03"
              data-text="カード情報をしてください"
              data-submit-text="カード情報を確定する"
              data-partial="true"
            />
          </div>
        </v-card>
      </v-col>
    </v-row>
    <div class="mt-4">
      <v-btn color="green darken-1" dark block :disabled="purhaseCount === null" @click="confirmBeforePurchase">
        購入手続きへ進む
      </v-btn>
    </div>
    <v-snackbar v-model="snackbar.display" top min-height="40" height="40" color="error">
      {{ snackbar.text }}
    </v-snackbar>
    <v-dialog v-if="dialog" :value="dialog" persistent max-width="600px">
      <v-card class="pt-4">
        <v-card-text>
          <div class="body-1 font-weight-bold">
            購入手続きを実行しますか？
          </div>
        </v-card-text>
        <v-card-actions>
          <v-spacer />
          <v-btn color="primary" @click="submitPurchase">
            実行する
          </v-btn>
          <v-btn color="error" dark @click="closeModal(false)">
            キャンセル
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>

export default {
  data () {
    return {
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: '商品購入',
          disabled: true
        }
      ],
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
      snackbar: {
        display: false,
        text: ''
      },
      dialog: false,
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
      title: '商品購入 | '
    }
  },
  methods: {
    confirmBeforePurchase () {
      const token = document.getElementsByName('payjp-token')[0].value
      if (token === '') {
        this.snackbar = {
          display: true,
          text: 'カード情報を入力してください'
        }
        return
      }
      console.log(token)
      this.dialog = true
    },
    submitPurchase () {
      this.closeModal()
      try {
        // TODO: API通信成功後のみ遷移
        this.$router.replace('/payment/complete')
      } catch (e) {
        this.snackbar = {
          display: true,
          text: '購入に失敗しました'
        }
      }
    },
    closeModal () {
      this.dialog = false
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
