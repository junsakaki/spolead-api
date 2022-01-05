<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <v-card class="contact-form-card">
      <v-container>
        <iframe
          src="https://docs.google.com/forms/d/e/1FAIpQLSdHfvzlZ6sh20zblUbUHEbWUZLVsFUEhfrcyscFDoVQ1JRjGw/viewform?embedded=true"
          width="700"
          height="700"
          frameborder="0"
          marginheight="0"
          marginwidth="0"
        >読み込んでいます…</iframe>
      </v-container>
    </v-card>
  </div>
</template>

<script>
export default {
  data () {
    return {
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: 'お問い合わせ',
          disabled: true
        }
      ]
    }
  },
  head () {
    return {
      title: 'お問い合わせ | '
    }
  }
}
</script>
<style lang="scss" scoped>
p {
  font-size: 16px;
  padding: 4px;
}
.container {
  display: flex;
  justify-content: center;
  align-content: center;
  margin-top: 24px
}
.contact-form-card .container {
  margin: 0;
}
</style>
