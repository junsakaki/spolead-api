<template>
  <v-app dark>
    <div class="container">
      <span>{{ error.statusCode }}</span>
    </div>
  </v-app>
</template>

<script>
export default {
  layout: 'empty',
  props: {
    error: {
      type: Object,
      default: null
    }
  },
  head () {
    const title =
      this.error.statusCode + 'エラー - '
    return {
      title
    }
  }
}
</script>

<style scoped>
.container {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 20px;
  height: 90%;
  background-color: #488fef;
  border: solid 16px #6aaaff;
  color: white;
}
.container span {
  font-size: 8em;
}
</style>
