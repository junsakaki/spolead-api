<template>
  <v-dialog
    v-model="dialog"
    persistent
    max-width="290"
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
      <v-card-actions>
        <v-spacer />
        <v-btn
          color="primary"
          text
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
      userId: null
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
      console.log(`ユーザー${this.userId}は以下のコメントを${this.$route.params.id}のメッセージ内のコメントとして送信します。`)
      console.log(this.comment)
      this.comment = ''
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
</style>
