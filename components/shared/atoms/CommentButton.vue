<template>
  <v-dialog
    v-model="dialog"
    persistent
    max-width="600"
  >
    <template #activator="{ on, attrs }">
      <div class="comment-button">
        <v-btn
          fab
          dark
          color="teal"
          small
          v-bind="attrs"
          v-on="on"
        >
          <v-icon dark small>
            mdi-chat-plus
          </v-icon>
        </v-btn>
      </div>
    </template>
    <v-card>
      <v-card-title class="body-1 font-weight-bold">
        メッセージを送る
      </v-card-title>
      <div class="mx-4">
        <textarea v-model="comment" class="form-textarea pa-2" />
      </div>
      <div class="mx-4 body-1 font-weight-bold">
        <v-checkbox
          v-model="isPaymentComment"
          label="購入フォームを追加する"
        />
      </div>
      <div v-if="isPaymentComment" class="mx-4">
        <div class="form-input">
          <div class="body-1 font-weight-bold">
            支払い金額
          </div>
          <div>
            <span class="validation-icon px-2">必須</span>
          </div>
          <input v-model="price" class="px-2" placeholder="支払い金額(円)を入力してください" type="number">
          <div class="ml-1 body-1 font-weight-bold">
            円
          </div>
        </div>
      </div>
      <v-card-actions>
        <v-spacer />
        <v-btn
          color="primary"
          text
          :disabled="comment === ''"
          @click="onSubmitComment"
        >
          送信
        </v-btn>
        <v-btn
          color="grey darken-1"
          text
          @click="onCloseModal"
        >
          閉じる
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  data () {
    return {
      dialog: false,
      comment: '',
      userId: null,
      isPaymentComment: false,
      price: 0
    }
  },
  created () {
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
              this.userId = Number(res.data.user.id)
            }
          })
      }
    },
    onSubmitComment () {
      console.log({ id: this.userId, comment: this.comment, payment: this.isPaymentComment ? { price: this.price } : null })
      this.comment = ''
      this.isPaymentComment = false
      this.price = 0
      this.onCloseModal()
    },
    onCloseModal () {
      this.dialog = false
    }
  }
}
</script>

<style lang="scss" scoped>
.comment-button {
  position: sticky;
  text-align: right;
  margin: 0 16px 16px;
  bottom: 68px;
}
.form-textarea {
  width: 100%;
  border: solid 1px rgba(156, 156, 156, 0.37);
  border-radius: 4px;
  min-height: 200px;
  font-size: 14px;
}
.form-input {
  display: grid;
  grid-template-columns: 100px 50px 1fr 10px;
  input {
    border: solid 1px rgba(156, 156, 156, 0.37);
    border-radius: 4px;
    font-size: 14px;
  }
}
.validation-icon {
  font-size: 12px;
  background: red;
  color: white;
  border-radius: 4px;
}
</style>
