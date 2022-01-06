<template>
  <div class="guideline caption py-2 px-4">
    <b>掲示板のガイドライン</b>
    <br>
    ★書き込みの前にガイドラインを確認してください。
    <br>
    ★{{ sportsTitle }}について、質問・情報交換・各種相談や雑談など自由にスレッドを作って書き込みをしてください。
    <br>
    ★禁止事項や注意事項は厳守してご利用ください。
  </div>
</template>

<script>
export default {
  props: {
    sportsTitle: {
      type: String,
      default: ''
    }
  }
}
</script>

<style lang="scss">
.guideline {
  border: solid 1px #80808061;
  border-radius: 10px;
}
</style>
