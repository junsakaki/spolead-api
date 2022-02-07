<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div v-if="$vuetify.breakpoint.smAndDown">
      <Menu />
    </div>
    <v-row v-else>
      <v-col cols="12" sm="3">
        <Menu />
      </v-col>
      <v-col cols="12" sm="9">
        <Account />
      </v-col>
    </v-row>
  </div>
</template>

<script>
import Menu from '~/components/settings/organisms/Menu.vue'
import Account from '~/components/settings/organisms/Account.vue'
export default {
  components: { Menu, Account },
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
      this.$router.replace('/login')
    }
    // デスクトップ版のみ/settingと/setting/accountの内容が同じなのでリプレイスする
    if (!this.$vuetify.breakpoint.smAndDown) {
      this.$router.replace('/settings/salons')
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
