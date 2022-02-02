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
      ]
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
    logOut () {
      this.$router.push('/logout')
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
