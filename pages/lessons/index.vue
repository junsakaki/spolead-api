<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div class="d-flex justify-center mt-2">
      <v-btn-toggle v-model="recruitment_target" color="primary" mandatory rounded>
        <v-btn value="student" class="px-8" @click="changeRecruitmentTarget('student')">
          コーチを探す
        </v-btn>
        <v-btn value="coach" class="px-8" @click="changeRecruitmentTarget('coach')">
          生徒を探す
        </v-btn>
      </v-btn-toggle>
    </div>
    <div v-if="recruitment_target === 'student'" class="lessons mt-4">
      <div v-for="lesson in lessons.filter(lesson => lesson.recruitment_target === 'student')" :key="lesson.id" class="px-2 py-3">
        <router-link :to="`/lessons/${lesson.id}`" class="lesson">
          <v-card rounded style="overflow: hidden">
            <v-row no-gutters>
              <v-col cols="12" sm="3">
                <v-img
                  v-if="lesson.imageTop"
                  :src="lesson.imageTop"
                  height="100%"
                />
                <div v-else class="lesson-image" />
              </v-col>
              <v-col cols="12" sm="9" class="pa-2">
                <div class="body-1 font-weight-bold lesson-name px-2">
                  {{ lesson.name }}
                </div>
                <div class="caption owner-name px-2 text-right">
                  <v-icon small>
                    mdi-account
                  </v-icon>
                  {{ lesson.owner.name }}
                </div>
                <div class="caption font-weight-bold lesson-caption px-2">
                  {{ lesson.caption }}
                </div>
                <div class="caption lesson-content px-2 mt-2">
                  {{ lesson.content }}
                </div>
              </v-col>
            </v-row>
          </v-card>
        </router-link>
      </div>
    </div>
    <div v-if="recruitment_target === 'coach'" class="lessons mt-4">
      <div v-for="lesson in lessons.filter(lesson => lesson.recruitment_target === 'coach')" :key="lesson.id" class="px-2 py-3">
        <v-card rounded style="overflow: hidden">
          <div class="pa-2">
            <v-row no-gutters>
              <v-col cols="12" sm="11">
                <div class="body-1 font-weight-bold lesson-name px-2">
                  {{ lesson.name }}
                </div>
                <div class="caption font-weight-bold lesson-caption px-2">
                  {{ lesson.caption }}
                </div>
                <div class="caption owner-name px-2">
                  <v-icon small>
                    mdi-account
                  </v-icon>
                  {{ lesson.owner.name }}
                </div>
              </v-col>
              <v-col cols="12" sm="1" class="d-flex align-center justify-center">
                <v-btn icon @click="startTalkroom(lesson.id)">
                  <v-icon>
                    mdi-message-text
                  </v-icon>
                </v-btn>
              </v-col>
            </v-row>
          </div>
        </v-card>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: '指導者マッチング',
          disabled: true
        }
      ],
      lessons: [],
      recruitment_target: this.$route.query.recruitment ?? 'student'
    }
  },
  head () {
    return {
      title: '指導者マッチング | '
    }
  },
  created () {
    this.getLessons()
  },
  methods: {
    getLessons () {
      const list = []
      for (let i = 0; i < 10; i++) {
        list.push({
          id: i,
          recruitment_target: 'student',
          name: 'サッカー、フットサルの為の身体作りサポートしますサッカー、フットサルの為の身体作りサポートします',
          owner: {
            name: 'まるやままさひ'
          },
          caption: 'フィジカルに悩む方向け！元プロフットサル選手がサポート。',
          content: 'サッカー、フットサルをプレーする皆さん。食べてるのに身体が大きくならない、フィジカル不足で試合で活躍出来ない、そういった悩みがある方多いことでしょう。かつては私もそうでした。ですが、様々な知識を蓄え、試行錯誤をし身体を鍛え上げ日本のフットサルトップリーグ、『Fリーグ』でフィジカルを武器に闘えるまでになった経験をお伝えします。トレーニングメニュー、食事指導、プレー分析等、何でも遠慮なくご相談ください。',
          imageTop: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSa3404Eb2IpfFK6JPahYOKqTnG02RnISWSWA&usqp=CAU'
        })
        list.push({
          id: i + 100,
          recruitment_target: 'coach',
          name: 'サッカーを教えてほしいです！小学生です！',
          owner: {
            name: 'まるやまこたろう'
          },
          caption: '将来の夢はJリーガーです！'
        })
      }
      this.lessons = list
    },
    changeRecruitmentTarget (recruitmentTarget) {
      this.$router.replace(`/lessons?recruitment=${recruitmentTarget}`)
    },
    startTalkroom (lessonId) {
      // TODO: lessonIdを元にトークルームを作成した上でデフォルトのメッセージを送る（==引用==を見ました！的な）
      // TODO: 受け取ったルームIDヘ遷移する
      this.$router.push(`/talks/${1}`)
    }
  }
}
</script>
<style lang="scss" scoped>
.lesson {
  text-decoration: none;
}
.lesson-image {
  width: 100%;
  height: 100px;
  background: grey;
}
.lesson-name {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  line-height: 1.5;
}
.owner-name {
  overflow: hidden;
  text-overflow: ellipsis;
}
.lesson-caption {
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  line-height: 1.2;
}
.lesson-content {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  line-height: 1.2;
}
</style>
