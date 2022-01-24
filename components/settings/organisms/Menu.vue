<template>
  <v-card class="text-center pt-4 pb-2">
    <router-link to="/settings/account" class="subtitle-2 font-weight-bold settings-link">
      <div>
        アカウント
      </div>
    </router-link>
    <router-link to="/settings/salons" class="subtitle-2 font-weight-bold mt-4 settings-link">
      <div>
        オンラインサロン
      </div>
    </router-link>
    <router-link to="/settings/funds" class="subtitle-2 font-weight-bold mt-4 settings-link">
      <div>
        クラウドファンディング
      </div>
    </router-link>
    <router-link to="/settings/payments" class="subtitle-2 font-weight-bold mt-4 settings-link">
      <div>
        決済情報
      </div>
    </router-link>
    <v-divider class="mt-4" />
    <v-btn color="error" text class="mt-2" @click="logOut">
      ログアウト
    </v-btn>
  </v-card>
</template>

<script>
export default {
  methods: {
    logOut () {
      this.$router.push('/logout')
    }
  }
}
</script>
<style lang="scss" scoped>
.settings-link {
  color: inherit;
  text-decoration: none;
  :hover {
    opacity: 0.6;
  }
}
</style>
