<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div class="report-guideline caption py-2 px-4">
      記事を管理人へ通報します。
      <br>
      ★ガイドラインに違反している等の場合に使用ください。
    </div>
    <v-card class="px-4 py-2 mt-4">
      <div class="report-row mb-2">
        <div>フォーラム名</div>
        <div />
        <div class="grey--text">
          {{ bbs_comment.forum.name }}
        </div>
      </div>
      <v-divider />
      <div class="report-row my-2">
        <div>スレッド名</div>
        <div />
        <div class="grey--text">
          {{ bbs_comment.thread.name }}
        </div>
      </div>
      <v-divider />
      <div class="report-row my-2">
        <div>コメント内容</div>
        <div />
        <div class="grey--text" v-html="transformTextToHtml(bbs_comment.content)" />
      </div>
      <v-divider />
      <div class="report-row my-2">
        <span>ユーザー名</span>
        <div>
          <span class="validation-icon px-2">任意</span>
        </div>
        <input v-model="post.user_name" class="px-2" placeholder="(例) 名無しさん">
      </div>
      <v-divider />
      <div class="report-row my-2">
        <span>通報内容</span>
        <div>
          <span class="validation-icon px-2 required">必須</span>
        </div>
        <textarea v-model="post.reason" placeholder="通報内容を詳細に記述してください" class="form-textarea px-2" />
      </div>
    </v-card>
    <div class="d-flex flex-column align-center mt-8">
      <router-link :to="`/report/confirm?commentId=${$route.query.commentId}&userName=${post.user_name}&reason=${post.reason}`" c>
        <common-button button-color="primary" :disabled="post.reason === ''">
          確認
        </common-button>
      </router-link>
    </div>
  </div>
</template>

<script>
import transformTextToHtml from '~/utils/transformTextToHtml'
import CommonButton from '~/components/shared/atoms/CommonButton.vue'

export default {
  components: { CommonButton },
  data () {
    return {
      transformTextToHtml,
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: '通報',
          disabled: true
        }
      ],
      bbs_comment: {
        forum: {},
        thread: {},
        comment: {}
      },
      post: {
        user_name: this.$route.query.userName ?? '',
        reason: this.$route.query.reason ?? ''
      }
    }
  },
  created () {
    this.getComment()
  },
  methods: {
    getComment () {
      this.$store
        .dispatch('api/apiRequest', {
          api: 'commentIndex',
          query: {
            id: Number(this.$route.query.commentId)
          }
        }).then((res) => {
          if (res.status === 200) {
            this.bbs_comment = res.data.bbs_comment
          }
        })
    }
  }
}
</script>
<style lang="scss">
.report-row {
  display: grid;
  grid-template-columns: 100px 50px 1fr;
}
.form-input {
  display: grid;
  grid-template-columns: 100px 50px 1fr;
  input {
    border: solid 1px rgba(156, 156, 156, 0.37);
    border-radius: 4px;
    font-size: 14px;
  }
}
.form-textarea {
  width: 100%;
  border: solid 1px rgba(156, 156, 156, 0.37);
  border-radius: 4px;
  min-height: 200px;
  font-size: 14px;
}
.validation-icon {
  font-size: 12px;
  background: grey;
  color: white;
  border-radius: 4px;
}
.required {
  background: red;
}
.confirm-link {
  text-decoration: none;
}
.report-guideline {
  border: solid 1px #80808061;
  border-radius: 10px;
}
</style>
