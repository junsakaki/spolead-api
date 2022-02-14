<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div class="lesson-detail body-2 py-2 px-4">
      <div class="d-flex">
        <div class="font-weight-bold">
          指導概要
        </div>
        <div class="ml-2 lesson-detail-button" @click="showLessonDetail">
          {{ lessonDetail ? '非表示' : '表示' }}
        </div>
      </div>
      <div v-if="lessonDetail" class="my-2">
        <div>{{ talk.lesson.name }}</div>
        <div>{{ talk.lesson.caption }}</div>
        <v-row no-gutters class="mt-4">
          <v-col cols="12" sm="2" style="margin-top: -1px;">
            <v-card outlined tile class="pa-2">
              指導形式
            </v-card>
          </v-col>
          <v-col cols="12" sm="10" style="margin-top: -1px;">
            <v-card outlined tile class="pa-2">
              <v-chip v-for="contactType in talk.lesson.contactType" :key="`contactType-${contactType}`" color="primary font-weight-bold" x-small class="mx-1">
                {{ getContactType(contactType) }}
              </v-chip>
            </v-card>
          </v-col>
          <v-col cols="12" sm="2" style="margin-top: -1px;">
            <v-card outlined tile class="pa-2">
              支払形式
            </v-card>
          </v-col>
          <v-col cols="12" sm="10" style="margin-top: -1px;">
            <v-card outlined tile class="pa-2">
              <v-chip v-for="paymentType in talk.lesson.paymentType" :key="`paymentType-${paymentType}`" color="primary font-weight-bold" x-small class="mx-1">
                {{ getPaymentType(paymentType) }}
              </v-chip>
            </v-card>
          </v-col>
        </v-row>
        <div class="d-flex justify-center align-center mt-2">
          <router-link :to="`/talks/${talk.id}`" class="detail-link caption">
            詳細を確認
          </router-link>
        </div>
      </div>
    </div>
    <div class="mt-4 body-1">
      <div v-if="talk.comments.length > 0">
        <div v-for="comment in talk.comments" :key="`comment-${comment.id}`" class="mt-4">
          <div class="comment-wrapper">
            <div class="caption">
              {{ !isMyComment(comment.user_id) ? talk.users.find(user => user.id === comment.user_id).name : '' }}
            </div>
            <v-card outlined :class="`pa-2 comment ${isMyComment(comment.user_id) ? 'mine ml-4' : 'mr-4'}`">
              <p class="ma-0" v-html="transformTextToHtml(comment.content)" />
            </v-card>
            <div class="caption text-right">
              {{ isMyComment(comment.user_id) ? 'あなた' : '' }}
            </div>
          </div>
          <div class="comment-wrapper">
            <div />
            <div>
              <v-card v-if="comment.payment" :class="`pa-4 mt-4 ${isMyComment(comment.user_id) ? 'ml-4' : 'mr-4'} text-center`" color="blue-grey" dark>
                <div>支払い金額: {{ comment.payment.price.toLocaleString() }}円</div>
                <router-link :to="`/payment?type=lesson&id=${talk.lesson.id}`" style="text-decoration: none;">
                  <v-btn class="mt-4" color="blue-grey darken-2" dark>
                    決済へ進む
                  </v-btn>
                </router-link>
              </v-card>
            </div>
            <div />
          </div>
        </div>
      </div>
      <div v-else>
        メッセージはまだありません
      </div>
    </div>
  </div>
</template>

<script>
import constants from '../constants'
import transformTextToHtml from '~/utils/transformTextToHtml'

export default {
  data () {
    return {
      transformTextToHtml,
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: 'トークルーム',
          link: true,
          exact: true,
          disabled: false,
          to: {
            path: '/talks'
          }
        },
        {
          text: 'しょうた',
          disabled: true
        }
      ],
      testUserId: 1,
      lessonDetail: false,
      ...constants
    }
  },
  methods: {
    getUser () {
      if (this.$auth && this.$auth.user) {
        this.$store
          .dispatch('api/apiRequest', {
            api: 'userIndex',
            query: {
              id: this.$auth.user.sub
            }
          }).then((res) => {
            this.isLoading = false
            if (res.status === 200) {
              this.userId = Number(res.data.user.id)
            }
          })
      }
    },
    showLessonDetail () {
      this.lessonDetail = !this.lessonDetail
    },
    getContactType (contactType) {
      const target = this.$CONTACT_TYPE.find(item => item.id === Number(contactType))
      return target ? target.type : null
    },
    getPaymentType (paymentType) {
      const target = this.$PAYMENT_TYPE.find(item => item.id === Number(paymentType))
      return target ? target.type : null
    },
    isMyComment (id) {
      return id === this.testUserId
    }
  }
}
</script>
<style lang="scss">
.lesson-detail {
  border: solid 1px #80808061;
  border-radius: 10px;
}
.lesson-detail-button {
  font-size: 10px;
  color: #1976D2;
  cursor: pointer;
}
.detail-link {
  text-decoration: none;
}
.comment-wrapper {
  display: grid;
  grid-template-columns: 50px 1fr 50px;
}
.comment.mine {
  color: white !important;
  background-color: #1976d2 !important;
}
.comment-button {
  position: sticky;
  text-align: right;
  top: 0;
  bottom: 0;
}
</style>
