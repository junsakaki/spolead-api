<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <div class="funds">
      <v-row no-gutters>
        <v-col
          v-for="fund in funds"
          :key="fund.id"
          cols="12"
          sm="3"
          class="px-2 py-3"
        >
          <router-link :to="`/funds/${fund.id}`" class="fund">
            <v-card class="pb-2">
              <v-img
                v-if="fund.imageTop"
                :src="fund.imageTop"
                max-height="100"
                max-width="100%"
              />
              <div v-else class="fund-image" />
              <div class="body-1 font-weight-bold fund-name px-2">
                {{ fund.name }}
              </div>
              <div class="body-2 font-weight-bold owner-name mt-2 px-2">
                {{ fund.owner.name }}
              </div>
              <div class="caption fund-caption mt-2 px-2">
                {{ fund.caption }}
              </div>
              <div class="meter mt-4">
                <div class="meter-in">
                  <div class="bar" :style="`width: ${fund.achievement}%;`">
                    <span>{{ fund.achievement }}%</span>
                  </div>
                </div>
                <span>{{ fund.achievement }}%</span>
              </div>
              <v-row no-gutters class="mt-4">
                <v-col cols="12" sm="5" class="caption text-center">
                  現在
                </v-col>
                <v-col cols="12" sm="4" class="caption text-center">
                  支援者
                </v-col>
                <v-col cols="12" sm="3" class="caption text-center">
                  残り
                </v-col>
                <v-col cols="12" sm="5" class="caption text-center font-weight-bold">
                  {{ fund.supportedMoney.toLocaleString() }}円
                </v-col>
                <v-col cols="12" sm="4" class="caption text-center font-weight-bold">
                  {{ fund.supportersCount.toLocaleString() }}人
                </v-col>
                <v-col cols="12" sm="3" class="caption text-center font-weight-bold">
                  10日
                  <!-- {{ fund.limitDate }}日 -->
                </v-col>
              </v-row>
            </v-card>
          </router-link>
        </v-col>
      </v-row>
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
          text: 'クラウドファンディング',
          disabled: true
        }
      ],
      funds: []
    }
  },
  head () {
    return {
      title: 'クラウドファンディング | '
    }
  },
  created () {
    this.getFunds()
  },
  methods: {
    getFunds () {
      const list = []
      for (let i = 0; i < 10; i++) {
        list.push({
          id: i,
          name: 'ファンドファンドファンドファンド',
          owner: {
            name: 'オーナー'
          },
          achievement: i * 10,
          supportedMoney: 100000,
          supportersCount: 100,
          limitDate: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
          caption: 'ファンドの説明が入りますファンドの説明が入りますファンドの説明が入ります',
          imageTop: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSa3404Eb2IpfFK6JPahYOKqTnG02RnISWSWA&usqp=CAU'
        })
      }
      this.funds = list
    }
  }
}
</script>
<style lang="scss" scoped>
.fund {
  text-decoration: none;
}
.fund-image {
  width: 100%;
  height: 100px;
  background: grey;
}
.fund-name {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  line-height: 1.5;
  height: calc(16px * 1.5 * 2) // font-weight * line-height * line-clamp
}
.owner-name {
  overflow: hidden;
  text-overflow: ellipsis;
}
.fund-caption {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  line-height: 1.2;
  height: calc(12px * 1.2 * 3) // font-weight * line-height * line-clamp
}
.meter {
  padding: 12px 8px;
  height: 35px;
  width: 100%;
  >span {
    display: none;
  }
  .meter-in {
    overflow: hidden;
    background-color: #e4e4e4;
    width: 100%;
    height: 15px;
    border-top-right-radius: 7px;
    border-top-left-radius: 7px;
    border-bottom-right-radius: 7px;
    border-bottom-left-radius: 7px;
    .bar {
      background: linear-gradient(270deg, #1976d2 0%, #1976d2 17.48%, #1976d2 49.56%, #324ad3 69.79%, #4f32d3 100%);
      max-width: 100%;
      height: 100%;
      color: #ffffff;
      text-align: left;
      line-height: 16px;
      font-size: 11px;
      border-top-right-radius: inherit;
      border-top-left-radius: inherit;
      border-bottom-right-radius: inherit;
      border-bottom-left-radius: inherit;span {
        display: inline-block;
        margin-left: 7px;
      }
    }
  }
}
</style>
