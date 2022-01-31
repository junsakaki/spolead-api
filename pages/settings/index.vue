<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div>
      <div class="text-center">
        <v-btn color="error" text class="mt-4" @click="logOut">
          ログアウト
        </v-btn>
      </div>
    </div>
    <v-snackbar v-model="snackbar.display" top min-height="40" height="40" :color="snackbar.color">
      {{ snackbar.text }}
    </v-snackbar>
  </div>
</template>

<script>
export default {
  data () {
    return {
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: '各種設定',
          disabled: true
        }
      ],
      valid: true,
      password: {
        current: '',
        new: '',
        confirm: ''
      },
      passwordDisplay: {
        current: false,
        new: false,
        confirm: false
      },
      passwordRules: [
        v => (v && v.length >= 5) || 'パスワードは6文字以上に設定してください。'
      ],
      passwordConfirmRules: [
        v => (v === this.password.new) || 'パスワードが一致しません。'
      ],
      snackbar: {
        display: false,
        text: '',
        color: 'primary'
      }
    }
  },
  head () {
    return {
      title: '各種設定 | '
    }
  },
  created () {
    // 未ログインの場合はトップ画面へリダイレクトする
    if (!this.$auth.loggedIn) {
      this.$router.replace('/')
    }
  },
  methods: {
    validate () {
      return this.$refs.form.validate()
    },
    updatePassword () {
      console.log(this.$auth)
      this.$auth.changePassword({ email: this.$auth.user.email })
      // if (this.validate()) {
      //   this.password = {
      //     current: '',
      //     new: '',
      //     confirm: ''
      //   }
      //   this.$store
      //     .dispatch('api/apiRequest', {
      //       api: 'passwordUpdate',
      //       data: {
      //         current: this.password.current,
      //         new: this.new
      //       }
      //     }).then((res) => {
      //       if (res.status === 200) {
      //         this.snackbar = true
      //         this.snackbarText = 'パスワードを更新しました'
      //         this.snackbar = {
      //           display: true,
      //           text: 'パスワードを更新しました',
      //           color: 'primary'
      //         }
      //       }
      //     }).catch(() => {
      //       this.snackbar = {
      //         display: true,
      //         text: 'パスワードの更新に失敗しました',
      //         color: 'error'
      //       }
      //     })
      // }
    },
    logOut () {
      this.$router.push('/logout')
    }
  }
}
</script>
<style lang="scss" scoped>
.form-input {
  border: solid 1px rgba(156, 156, 156, 0.37);
  border-radius: 4px;
  font-size: 14px;
  width: 100%;
}
.reset-form {
  display: grid;
  grid-template-columns: 200px 1fr;
  grid-gap: 8px 0;
}
</style>
