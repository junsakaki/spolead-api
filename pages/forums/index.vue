<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <GuideLine :sports-title="getSportsTitle()" />
    <v-card class="px-4 py-2 mt-4">
      <div class="forum main mb-1">
        <div class="grey--text">
          フォーラム名
        </div>
        <div class="text-center grey--text">
          スレッド数
        </div>
        <div class="text-center grey--text">
          コメント総数
        </div>
      </div>
      <v-divider class="mb-2" />
      <router-link v-for="forum in forums" :key="`forum-${forum.id}`" :to="`/forums/${forum.id}?sportsId=${$route.query.sportsId}`" class="forum py-1">
        <div class="forum-name ml-2">
          {{ forum.name }}
        </div>
        <div class="text-center">
          {{ forum.thread_count }}
        </div>
        <div class="text-center">
          {{ forum.comments_count }}
        </div>
        <div class="filter" />
      </router-link>
    </v-card>
  </div>
</template>

<script>
import GuideLine from '~/components/shared/organisms/GuideLine.vue'

export default {
  components: {
    GuideLine
  },
  data () {
    return {
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: `${this.getSportsTitle()}のBBS掲示板`,
          disabled: true
        }
      ],
      forums: []
    }
  },
  head () {
    return {
      title: `${this.getSportsTitle()}のBBS掲示板 | `
    }
  },
  created () {
    this.getForums()
  },
  methods: {
    getSportsTitle () {
      const targetSports = this.$SPORTS.find(sports => sports.id === Number(this.$route.query.sportsId))
      return targetSports.title
    },
    getForums () {
      this.forums = [
        {
          id: 1,
          name: `${this.getSportsTitle()} 指導者用掲示板`,
          user_name: 'テストユーザー',
          content: 'テスト',
          thread_count: 111,
          comments_count: 1111
        },
        {
          id: 2,
          name: `${this.getSportsTitle()} 総合・議論掲示板`,
          user_name: 'テストユーザー',
          content: 'テスト',
          thread_count: 222,
          comments_count: 2222
        },
        {
          id: 3,
          name: '全国版',
          user_name: 'テストユーザー',
          content: 'テスト',
          thread_count: 333,
          comments_count: 3333
        },
        {
          id: 4,
          name: '北海道',
          user_name: 'テストユーザー',
          content: 'テスト',
          thread_count: 444,
          comments_count: 4444
        },
        {
          id: 'NaN',
          name: '・・・',
          user_name: 'テストユーザー',
          content: 'テスト',
          thread_count: 444,
          comments_count: 4444
        },
        {
          id: 50,
          name: '沖縄',
          user_name: 'テストユーザー',
          content: 'テスト',
          thread_count: 444,
          comments_count: 4444
        },
        {
          id: 51,
          name: '海外',
          user_name: 'テストユーザー',
          content: 'テスト',
          thread_count: 555,
          comments_count: 5555
        },
        {
          id: 52,
          name: '依頼・要望',
          user_name: 'テストユーザー',
          content: 'テスト',
          thread_count: 666,
          comments_count: 6666
        }
      ]
    }
  }
}
</script>

<style lang="scss" scoped>
.forum {
  position: relative;
  display: grid;
  grid-template-columns: 1fr 100px 100px;
  text-decoration: none;
  color: inherit;
}
.forum:visited {
  color: inherit;
}
.forum.main {
  font-size: 12px;
}
.forum-name {
  overflow: hidden;
  width: 100%;
  text-overflow: ellipsis;
  white-space: nowrap;
  ;
}
.forum .filter {
  position: absolute;
  width: 100%;
  height: 100%;
  background: #7e7e7e;
  opacity: 0;
  transition-duration: 0.5s;
  cursor: pointer;
}
.forum:hover .filter {
  opacity: 0.1;
}
</style>
