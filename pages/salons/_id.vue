<template>
  <div>
    <v-breadcrumbs :items="breadcrumbs" class="breadcrumbs">
      <template #divider>
        <v-icon>mdi-chevron-right</v-icon>
      </template>
    </v-breadcrumbs>
    <v-row no-gutters>
      <v-col cols="12" md="8">
        <div class="text-h5 font-weight-bold">
          {{ salon.name }}
        </div>
        <div class="body-1 mt-8">
          {{ salon.caption }}
        </div>
        <div class="body-2 mt-8">
          {{ salon.owner.name }}
        </div>
        <div class="salon-image mt-8">
          {{ salon.image }}
        </div>
        <div class="mt-8">
          <p v-html="transformTextToHtml(salon.content)" />
        </div>
      </v-col>
      <v-col cols="12" md="4" :class="!$vuetify.breakpoint.smAndDown && 'pl-4'">
        <v-banner elevation="4" rounded>
          <div v-for="(plan, i) in salon.plans" :key="plan.id" class="py-4">
            <div class="body-1 font-weight-bold">
              {{ plan.name }}
            </div>
            <div class="text-caption">
              {{ plan.caption }}
            </div>
            <div class="text-center mt-4">
              <font style="font-size: 28px;">
                {{ plan.price.toLocaleString() }}
              </font>
              円 / 1ヶ月
            </div>
            <div class="text-center mt-4">
              <common-button button-color="primary">
                このプランで入会する
              </common-button>
            </div>
            <v-divider v-if="i !== salon.plans.length - 1" class="mt-8" />
          </div>
        </v-banner>
      </v-col>
    </v-row>
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
      breadcrumbs: [],
      salon: {}
    }
  },
  head () {
    return {
      title: `${this.salon.name} - オンラインサロン | `
    }
  },
  created () {
    this.getSalonDetail()
  },
  methods: {
    getSalonDetail () {
      this.salon = {
        name: '落合陽一塾',
        owner: {
          name: '落合陽一'
        },
        caption: '落合陽一が生涯教育や幅広い交流を目的としたオンラインコミュニティ．時事ニュースや最新論文，エンタメやネットニュースなど皆で発見し，議論し，知的好奇心をくすぐります．新しい学びや普段出会わない世界観に触れたい方はぜひ．',
        content: '<h1>タイトル</h1><h2>サブタイトル</h2><div>a<br>a<br>a<br>a<br>a<br>a<br>a<br>a<br>a<br>a<br>a</div>',
        plans: [{
          id: 1,
          name: 'プラン1',
          caption: 'プラン1の説明',
          price: 1000
        },
        {
          id: 2,
          name: 'プラン2',
          caption: 'プラン2の説明',
          price: 10000
        }]
      }
      this.breadcrumbs = [
        ...this.$BREADCRUMBS,
        {
          text: 'オンラインサロン',
          link: true,
          exact: true,
          disabled: false,
          to: {
            path: '/salons'
          }
        },
        {
          text: this.salon.name,
          disabled: true
        }
      ]
    }
  }
}
</script>

<style lang="scss" scoped>
.salon-image {
  width: 100%;
  height: 200px;
  background: grey;
}
.plan-name {
  border-bottom: solid 1px blue;
}
</style>
