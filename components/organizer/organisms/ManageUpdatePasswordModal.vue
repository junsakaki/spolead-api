<template>
  <v-row justify="center">
    <v-dialog v-if="dialog" :value="dialog" persistent max-width="600px">
      <v-card>
        <v-card-title class="justify-space-between">
          <span class="headline">パスワード変更</span>
        </v-card-title>
        <v-card-text>
          <v-form
            ref="form"
            v-model="valid"
            lazy-validation
            class="ml-4"
          >
            <v-row no-gutters>
              <v-text-field
                v-model="newPassword"
                label="新しいパスワードを入力"
                :type="showNewPassword ? 'text' : 'password'"
                :append-icon="showNewPassword ? 'mdi-eye' : 'mdi-eye-off'"
                @click:append="showNewPassword = !showNewPassword"
              />
            </v-row>
            <v-row no-gutters>
              <v-text-field
                v-model="verify"
                label="（確認用）新しいパスワードを入力"
                :rules="[rules.passwordVerify]"
                :type="showVerify ? 'text' : 'password'"
                :append-icon="showVerify ? 'mdi-eye' : 'mdi-eye-off'"
                @click:append="showVerify = !showVerify"
              />
            </v-row>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer />
          <v-btn color="primary" @click="submit">
            変更
          </v-btn>
          <v-btn color="blue darken-1" text @click="closeModal(false)">
            閉じる
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
export default {
  props: {
    dialog: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      valid: true,
      newPassword: '',
      verify: '',
      showNewPassword: false,
      showVerify: false,
      rules: {
        passwordVerify: v => v === this.newPassword || '同じパスワードを入力してください'
      }
    }
  },
  created () {
  },
  methods: {
    closeModal () {
      this.$emit('closeModal')
    },
    submit () {
      if (!this.$refs.form.validate()) {
        return
      }
      this.$store
        .dispatch('api/apiRequest', {
          api: 'patchOrganizerUserPassword',
          query: {
            user_id: Number(localStorage.getItem('organizer_user_id'))
          },
          params: {
            password: this.newPassword
          }
        }).then((res) => {
          this.newPassword = ''
          this.verify = ''
          this.showNewPassword = false
          this.showVerify = false
          this.$methods.getOrganizerUser()
          this.closeModal()
        })
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
