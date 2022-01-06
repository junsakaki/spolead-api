<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <v-card class="px-4 py-2 mt-2">
      <div class="report-confirm-row mb-2">
        <div>フォーラム名</div>
        <div>{{ forum.name }}</div>
      </div>
      <v-divider />
      <div class="report-confirm-row my-2">
        <div>スレッド名</div>
        <div>{{ thread.name }}</div>
      </div>
      <v-divider />
      <div class="report-confirm-row my-2">
        <div>コメント内容</div>
        <div v-html="transformTextToHtml(comment.content)" />
      </div>
      <v-divider />
      <div class="report-confirm-row my-2">
        <span>ユーザー名</span>
        <div>{{ $route.query.userName }}</div>
      </div>
      <v-divider />
      <div class="report-confirm-row my-2">
        <span>通報内容</span>
        <div>{{ $route.query.reason }}</div>
      </div>
    </v-card>
    <div class="d-flex flex-column align-center mt-8">
      <div>上記の内容で通報しますか？</div>
      <router-link to="/report/complete" class="report-link mt-4">
        <common-button button-color="primary" @click="report">
          通報する
        </common-button>
      </router-link>
      <router-link :to="`/report?commentId=${$route.query.commentId}${$route.query.userName && `&userName=${$route.query.userName}`}&reason=${$route.query.reason}`" class="edit-link mt-2">
        編集に戻る
      </router-link>
    </div>
  </div>
</template>

<script>
import CommonButton from '~/components/shared/atoms/CommonButton.vue'
import transformTextToHtml from '~/utils/transformTextToHtml'

export default {
  components: { CommonButton },
  data () {
    return {
      transformTextToHtml,
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: '通報',
          link: true,
          exact: true,
          disabled: false,
          to: {
            path: `/report?commentId=${this.$route.query.commentId}`
          }
        },
        {
          text: '確認',
          disabled: true
        }
      ],
      forum: {},
      thread: {},
      comment: {}
    }
  },
  created () {
    this.getComment()
  },
  methods: {
    getComment () {
      this.comment = {
        id: 1,
        user_name: 'テストユーザー',
        content: 'コメントの内容<br>改行のテスト'
      }
      this.forum = {
        id: 1,
        name: 'フォーラム名のサンプル'
      }
      this.thread = {
        id: 1,
        name: 'スレッド名のサンプル'
      }
    },
    report () {
      alert('通報が完了')
    }
  }
}
</script>
<style lang="scss">
.report-confirm-row {
  display: grid;
  grid-template-columns: 150px 1fr;
}
.report-link {
  text-decoration: none;
}
.edit-link {
  text-decoration: none;
  font-size: 14px;
}
</style>
