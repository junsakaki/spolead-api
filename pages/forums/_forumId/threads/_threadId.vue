<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <GuideLine :sports-title="getSportsTitle()" />
    <div class="h2 text-left page-content-title mt-8">
      {{ bbs_thread.name }}
    </div>
    <v-card class="px-4 py-2 mt-4">
      <div class="thread">
        <p v-html="transformTextToHtml(bbs_thread.content)" />
        <v-divider class="my-2" />
        <div class="d-flex justify-end">
          <span class="date grey--text d-flex align-center"><v-icon small>mdi-identifier</v-icon>{{ bbs_thread.id }}<v-icon small class="ml-2">mdi-account</v-icon>{{ bbs_thread.user_name }}</span>
          <span class="date grey--text ml-2">{{ dateFormat(bbs_thread.created_at) }}</span>
        </div>
      </div>
    </v-card>
    <SearchForm class="mt-8" placeholder="検索(コメント名)" @execSearch="execSearch" />
    <div class="h2 text-left page-content-title mt-4">
      コメント({{ bbs_thread.comments_count }})
    </div>
    <v-card v-for="comment in displayComments" id="comments" :key="`comment-${comment.id}`" class="px-4 py-2 mt-4">
      <div class="comment">
        <div>
          <div class="comment-grid-row">
            <span>{{ comment.id }}. {{ comment.user_name }}</span>
            <div class="d-flex justify-end">
              <button class="reply-button d-flex justify-center align-center" @click="selectReplyComment(comment)">
                <v-icon small>
                  mdi-reply
                </v-icon>
                <span class="ml-1">返信</span>
              </button>
            </div>
          </div>
          <v-divider class="mb-2" />
          <div>
            <div>
              <!-- TODO: 返信元コメントへのリンクで確認できるようにする -->
              <p v-if="comment.reply_to">
                &gt;&gt; {{ comment.reply_to }}への返信
              </p>
              <p v-html="transformTextToHtml(comment.content)" />
            </div>
          </div>
        </div>
        <div class="comment-grid-row">
          <span class="date grey--text">{{ dateFormat(comment.created_at) }}</span>
          <div class="d-flex justify-end">
            <router-link :to="`/report?commentId=${comment.id}`" class="report-link d-flex justify-center align-center">
              <v-icon color="yellow darken-2" small>
                mdi-alert
              </v-icon>
              <span class="ml-1">通報</span>
            </router-link>
          </div>
        </div>
      </div>
    </v-card>
    <Pagination :total-pages="Math.ceil(bbs_thread.comments_count / paginationLimit)" :page="page" @execPagination="execPagination" />
    <div id="post-comment-area" class="h2 text-left page-content-title mt-4">
      コメントを投稿する
    </div>
    <v-card class="mt-2 py-6 px-4">
      <div class="form-input">
        <span>ユーザー名</span>
        <div>
          <span class="validation-icon px-2">任意</span>
        </div>
        <input v-model="post.user_name" class="px-2" placeholder="(例) 名無しさん">
      </div>
      <div v-if="post.reply_to.content" class="mt-4">
        <div class="d-flex justify-space-between">
          <span>返信先のコメント</span>
          <button @click="selectReplyComment({})">
            <v-icon small>
              mdi-close
            </v-icon>
          </button>
        </div>
        <p class="form-reply px-2 py-2 caption" v-html="transformTextToHtml(post.reply_to.content)" />
      </div>
      <textarea
        v-model="post.content"
        class="form-textarea mt-4 px-2"
        placeholder=""
      />
      <PostGuideLine target-name="コメント" is-comment class="mt-4" />
      <div class="d-flex justify-center mt-4">
        <common-button button-color="primary" :disabled="post.content ===''" @click="createComment()">
          投稿
        </common-button>
      </div>
    </v-card>
  </div>
</template>

<script>
import { format, utcToZonedTime } from 'date-fns-tz'
import GuideLine from '~/components/shared/organisms/GuideLine.vue'
import SearchForm from '~/components/shared/molecules/SearchForm.vue'
import Pagination from '~/components/shared/molecules/Pagination.vue'
import CommonButton from '~/components/shared/atoms/CommonButton.vue'
import PostGuideLine from '~/components/shared/organisms/PostGuideLine.vue'
import transformTextToHtml from '~/utils/transformTextToHtml'

export default {
  components: { GuideLine, SearchForm, Pagination, CommonButton, PostGuideLine },
  data () {
    return {
      format,
      utcToZonedTime,
      transformTextToHtml,
      breadcrumbs: [],
      bbs_thread: {
        name: '',
        forum: {},
        comments: []
      },
      post: {
        user_name: '',
        content: '',
        reply_to: {}
      },
      displayComments: [],
      page: this.$route.query.page ? Number(this.$route.query.page) : 1,
      paginationLimit: 10
    }
  },
  head () {
    return {
      title: 'BBS掲示板 | '
    }
  },
  created () {
    this.getThreadDetail()
  },
  methods: {
    getSportsTitle () {
      const targetSports = this.$SPORTS.find(sports => sports.id === Number(this.$route.query.sportsId))
      return targetSports.title
    },
    getThreadDetail () {
      this.$store
        .dispatch('api/apiRequest', {
          api: 'threadIndex',
          query: {
            id: Number(this.$route.params.threadId)
          }
        }).then((res) => {
          if (res.status === 200) {
            this.bbs_thread = res.data.bbs_threads[0]
            this.execPagination(this.page)
            this.breadcrumbs = [
              ...this.$BREADCRUMBS,
              {
                text: 'BBS掲示板',
                link: true,
                exact: true,
                disabled: false,
                to: {
                  path: `/forums?sportsId=${this.$route.query.sportsId}`
                }
              },
              {
                text: this.bbs_thread.forum.name,
                link: true,
                exact: true,
                disabled: false,
                to: {
                  path: `/forums/${this.$route.params.forumId}?sportsId=${this.$route.query.sportsId}`
                }
              },
              {
                text: this.bbs_thread.name,
                disabled: true
              }
            ]
          }
        })
    },
    execSearch (searchWord) {
      this.searchWord = searchWord
      this.page = 1
      this.getThreadDetail()
    },
    selectReplyComment (comment) {
      if (comment.content) {
        const target = document.getElementById('post-comment-area')
        target.scrollIntoView({ behavior: 'smooth' })
      }
      this.post = {
        ...this.post,
        reply_to: comment
      }
    },
    execPagination (page) {
      window.scrollTo(0, 0)
      this.page = page
      this.displayComments = this.bbs_thread.comments.slice((page - 1) * this.paginationLimit, (page - 1) * this.paginationLimit + this.paginationLimit).reverse();
      this.$router.replace({ path: this.$router.path, query: { ...this.$route.query, page } }, () => {})
    },
    createComment () {
      this.$store
        .dispatch('api/apiRequest', {
          api: 'commentCreate',
          data: {
            ...this.post,
            reply_to: this.post.reply_to.id, // 返信するIDのみ送付する
            forum_id: this.$route.params.forumId,
            thread_id: this.$route.params.threadId
          }
        }).then((res) => {
          if (res.status === 200) {
            this.getThreadDetail()
            this.post = {
              user_name: '',
              content: '',
              reply_to: {}
            }
          }
        })
    },
    dateFormat (timezone) {
      if (!timezone) {
        return ''
      }
      const jstDate = utcToZonedTime(timezone, 'Asia/Tokyo')
      return this.format(jstDate, 'yyyy-MM-dd HH:mm:ss')
    }
  }
}
</script>

<style lang="scss" scoped>
.comment-grid-row {
  display: grid;
  grid-template-columns: 1fr 100px;
}
.date {
  font-size: 12px;
}
.reply-button {
  font-size: 12px;
}
.report-link {
  font-size: 12px;
  text-decoration: none;
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
.form-reply {
  border: solid 1px rgba(156, 156, 156, 0.37);
  border-radius: 4px;
  background: #e3e3e38c;
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
</style>
