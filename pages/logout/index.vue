<template>
  <div class="container" />
</template>

<script>
export default {
  head () {
    return {
      title: 'ログアウト | '
    }
  },
  created () {
    if (this.$auth.user) {
      this.$auth.logout('auth0')
    }
  }
}
</script>

<style lang="scss" scoped>
.container {
  height: 100vh;
  width: 100%;
}
</style>
