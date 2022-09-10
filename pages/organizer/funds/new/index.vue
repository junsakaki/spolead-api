<template>
  <v-layout
    column
    justify-center
    align-center
  >
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div class="container">
      <funds-regist-form @submit="submit" />
    </div>
  </v-layout>
</template>

<script>
import FundsRegistForm from '~/components/funds/organisms/FundsRegistForm.vue'
export default {
  components: {
    FundsRegistForm
  },
  data () {
    return {
      breadcrumbs: [
        {
          text: 'クラウドファンディングの登録申請',
          disabled: true
        }
      ],
      userId: null
    }
  },
  head () {
    return {
      title: 'クラウドファンディングの登録申請 | '
    }
  },
  created () {
  },
  methods: {
    submit (form) {
      const data = { ...form }
      data.owner.user_id = Number(localStorage.getItem('organizer_user_id'))
      this.$store
        .dispatch('api/apiRequest', {
          api: 'fundCreate',
          data
        }).then((res) => {
          if (res.status === 200) {
            this.$methods.getOrganizerUser()
            this.$router.push('/organizer/funds')
          }
        })
    }
  }
}
</script>

<style lang="scss" scoped>
@import '~/assets/scss/page.scss';
.container {
  width: 100%;
}
</style>
