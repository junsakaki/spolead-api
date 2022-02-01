<template>
  <div>
    <div class="subtitle-1 font-weight-bold">
      <div>指導者/生徒を募集する</div>
      <div class="text-center px-4 mt-2">
        <router-link to="/lessons/new" class="lesson-link">
          <v-btn color="primary" outlined block>
            募集情報入力フォームへ
          </v-btn>
        </router-link>
      </div>
    </div>
    <div class="subtitle-1 font-weight-bold mt-8">
      <div>公開中のマッチング一覧</div>
      <div v-if="lessons.length > 0" class="mt-2">
        <div v-for="lesson in lessons" :key="lesson.id">
          <v-card outlined tile style="margin-top: -1px;">
            <v-row class="my-1 px-2">
              <v-col cols="12" sm="9" class="body-2 font-weight-bold">
                {{ lesson.name }}
              </v-col>
              <v-col cols="12" sm="3" class="d-flex justify-end align-center">
                <router-link :to="`/lessons/${lesson.id}`" class="lesson-link">
                  <v-btn icon small>
                    <v-icon small>
                      mdi-eye
                    </v-icon>
                  </v-btn>
                </router-link>
                <v-btn icon small class="ml-2" @click="showEditModal(lesson)">
                  <v-icon small>
                    mdi-pencil
                  </v-icon>
                </v-btn>
              </v-col>
            </v-row>
          </v-card>
          <v-card
            v-for="talk in lesson.talks"
            :key="talk.id"
            outlined
            tile
            class="ml-6"
            style="margin-top: -1px;"
          >
            <v-row class="my-1 px-2">
              <v-col cols="12" sm="12" class="caption font-weight-bold">
                {{ talk.users[0].name }}とのトークルーム
              </v-col>
              <v-col cols="12" sm="12" class="body-2 font-weight-bold">
                {{ talk.comments.length > 0 ? talk.comments[0].content : 'メッセージはありません' }}
              </v-col>
            </v-row>
          </v-card>
        </div>
      </div>
      <div v-else class="mt-2">
        参加中のオンラインサロンはありません
      </div>
    </div>
    <lesson-edit-modal
      :dialog="editModal"
      :lesson="selectedSalon"
      @closeModal="closeModal"
    />
  </div>
</template>

<script>
import LessonEditModal from '~/components/settings/organisms/LessonEditModal.vue'

export default {
  components: { LessonEditModal },
  props: {
    lessons: {
      type: Array,
      default: null
    }
  },
  data () {
    return {
      editModal: false,
      selectedSalon: null
    }
  },
  methods: {
    closeModal (shouldUpdateUser) {
      this.editModal = false
      this.analyticsModal = false
      this.selectedSalon = null
      // TODO: 必要があればサロン情報を含むユーザー情報を再取得する
    },
    showEditModal (salon) {
      this.selectedSalon = salon
      this.editModal = true
    }
  }
}
</script>
<style lang="scss" scoped>
.lesson-link {
  text-decoration: none;
  color: inherit;
}
</style>
