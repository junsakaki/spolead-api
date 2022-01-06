<template>
  <div class="post-guideline caption py-2 px-4">
    ガイドラインをよくご確認の上で{{ targetName }}の作成をお願いいたします。
    <br>
    ガイドラインに反した{{ targetName }}は管理側にて削除させていただく事があります。
    <br>
    <font>
      ※ガイドライン違反・荒らしコメント等に対しては、各コメントの
      <v-icon color="yellow darken-2" small>
        mdi-alert
      </v-icon>
      から削除申請をお願いいたします。
    </font>
    <font v-if="!isComment" color="red">
      <br>※返信、コメント用のフォームではありません。
    </font>
  </div>
</template>

<script>
export default {
  props: {
    targetName: {
      type: String,
      default: ''
    },
    isComment: {
      type: Boolean,
      default: false
    }
  }
}
</script>

<style lang="scss">
.post-guideline {
  border: solid 1px #80808061;
  border-radius: 10px;
}
</style>
