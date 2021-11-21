<template>
  <v-card class="review-card">
    <p class="reviewer-name">
      {{ displayusername }} さんの口コミ
    </p>
    <p class="reviewer-status">
      性別: {{ displayGender }}
    </p>
    <p class="reviewer-status">
      年代: {{ displayAgeGroup }}
    </p>
    <p class="reviewer-status">
      在籍年: {{ review.enrollment_period }}
    </p>
    <p class="reviewer-status">
      あなたの立場: {{ displayIsPlayer }}
    </p>

    <v-divider />

    <div :class="!$vuetify.breakpoint.smAndDown && 'd-flex justify-left align-center'">
      <div class="d-flex">
        <v-rating v-model="review.general_point" readonly />
        <button v-if="!isShowReviewScoreDetail" @click="showReviewScoreDetail" class="show-review-score-detail-button">
          詳細
        </button>
      </div>

      <!-- due to comment out unnecessary?? -->
      <!-- <div>{{ general_point }}</div> -->

      <div v-if="isShowReviewScoreDetail" class="review-score-detail">
        方針: {{ review.policy_point }}  体制: {{ review.organization_point }}  活動: {{ review.activity_point }}  環境: {{ review.environment_point }}  イベント: {{ review.event_point }}  費用: {{ review.cost_point }}
      </div>
    </div>

    <v-divider />

    <v-card-text v-if="!!review.general_post">
      <div class="review-category-title">
        総合
      </div>
      <p v-html="transformTextToHtml(review.general_post)" />
    </v-card-text>
    <v-card-text v-if="!!review.policy_post">
      <div class="review-category-title">
        チーム方針
      </div>
      <p v-html="transformTextToHtml(review.policy_post)" />
    </v-card-text>
    <v-card-text v-if="!!review.organization_post">
      <div class="review-category-title">
        チーム体制
      </div>
      <p v-html="transformTextToHtml(review.organization_post)" />
    </v-card-text>
    <v-card-text v-if="!!review.activity_post">
      <div class="review-category-title">
        活動内容
      </div>
      <p v-html="transformTextToHtml(review.activity_post)" />
    </v-card-text>
    <v-card-text v-if="!!review.environment_post">
      <div class="review-category-title">
        チーム環境
      </div>
      <p v-html="transformTextToHtml(review.environment_post)" />
    </v-card-text>
    <v-card-text v-if="!!review.event_post">
      <div class="review-category-title">
        イベント
      </div>
      <p v-html="transformTextToHtml(review.event_post)" />
    </v-card-text>
    <v-card-text v-if="!!review.cost_post">
      <div class="review-category-title">
        費用
      </div>
      <p v-html="transformTextToHtml(review.cost_post)" />
    </v-card-text>
  </v-card>
</template>

<script>
import transformTextToHtml from '~/utils/transformTextToHtml'

export default {
  components: {
  },
  props: {
    review: {
      type: Object,
      default: () => {}
    }
  },
  data () {
    return {
      transformTextToHtml,
      genderTypeList: [
        '男性',
        '女性'
      ],
      ageGroupMap: [
        'キッズ',
        '小学生',
        '中学生',
        '高校生',
        '大学・専門学生',
        '社会人'
      ],
      playerFlagMap: [
        'プレーヤー',
        '保護者',
        'チーム関係者',
        'その他'
      ],
      isShowReviewScoreDetail: false
    }
  },
  computed: {
    displayusername () {
      return this.review.username !== null ? this.review.username : '匿名'
    },
    displayGender () {
      return this.review.gender !== null ? this.genderTypeList[this.review.gender - 1] : '非公開'
    },
    displayAgeGroup () {
      return this.review.age_group !== null ? this.ageGroupMap[this.review.age_group - 1] : '非公開'
    },
    displayIsPlayer () {
      return this.review.player_flag !== null ? this.playerFlagMap[this.review.player_flag - 1] : '非公開'
    }
  },
  methods: {
    showReviewScoreDetail () {
      this.isShowReviewScoreDetail = true
    }
  }
}
</script>

<style lang="scss" scoped>
p {
  font-size: 16px;
  margin: 4px 0px 4px 12px;
}
.review-card {
  margin-bottom: 24px;
  padding: 12px;
}
.reviewer-status {
  font-size: 14px;
}
.show-review-score-detail-button {
  font-size: 12px;
  color: #1976d2;
  text-decoration: underline;
  margin-left: 8px;
}
.review-score-detail {
  font-size: 12px;
  padding-left: 12px;
}
.review-category-title {
  border-bottom: solid 1px #0000008a;
}
</style>
