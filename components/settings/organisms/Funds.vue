<template>
  <div>
    <div class="subtitle-1 font-weight-bold">
      <div>クラウドファンディングを開始する</div>
      <div class="text-center px-4 mt-2">
        <router-link to="/funds/new" class="fund-link">
          <v-btn color="primary" outlined block>
            ファンド情報入力フォームへ
          </v-btn>
        </router-link>
      </div>
    </div>
    <div class="subtitle-1 font-weight-bold mt-8">
      <div>購入したリターン</div>
      <div v-if="funds.purchased.length > 0" class="mt-2">
        <v-card outlined tile style="margin-top: -1px;" class="fund-card">
          <v-row class="my-1 px-2">
            <v-col cols="12" sm="4" class="body-2 font-weight-bold">
              リターン名
            </v-col>
            <v-col cols="12" sm="2" class="body-2 font-weight-bold text-center">
              金額
            </v-col>
            <v-col cols="12" sm="2" class="body-2 font-weight-bold text-center">
              購入個数
            </v-col>
            <v-col cols="12" sm="2" class="body-2 font-weight-bold text-center">
              支払い金額
            </v-col>
            <v-col cols="12" sm="2" class="body-2 font-weight-bold text-center">
              オーナー名
            </v-col>
          </v-row>
        </v-card>
        <router-link v-for="(reduction, i) in funds.purchased" :key="`fund-${reduction.id}-${i}`" :to="`/funds/${reduction.id}`" class="fund-link">
          <v-card outlined tile style="margin-top: -1px;" class="fund-card">
            <v-row class="my-1 px-2">
              <v-col cols="12" sm="4" class="body-2 font-weight-bold">
                {{ reduction.name }}
              </v-col>
              <v-col cols="12" sm="2" class="body-2 font-weight-bold text-center">
                {{ reduction.price }}円
              </v-col>
              <v-col cols="12" sm="2" class="body-2 font-weight-bold text-center">
                {{ reduction.quantity }}個
              </v-col>
              <v-col cols="12" sm="2" class="body-2 font-weight-bold text-center">
                {{ reduction.price*reduction.quantity }}円
              </v-col>
              <v-col cols="12" sm="2" class="d-flex justify-center align-center caption">
                <v-icon small class="mr-1">
                  mdi-account
                </v-icon>
                {{ reduction.owner.name }}
              </v-col>
            </v-row>
          </v-card>
        </router-link>
      </div>
      <div v-else class="mt-2">
        購入したリターンはありません
      </div>
    </div>
    <div class="subtitle-1 font-weight-bold mt-8">
      <div>公開中のファンド</div>
      <div v-if="funds.owned.length > 0" class="mt-2">
        <v-card
          v-for="fund in funds.owned"
          :key="fund.id"
          outlined
          tile
          style="margin-top: -1px;"
          class="fund-card"
        >
          <v-row class="my-1 px-2">
            <v-col cols="12" sm="9" class="body-2 font-weight-bold">
              {{ fund.name }}
            </v-col>
            <v-col cols="12" sm="3" class="d-flex justify-end align-center">
              <router-link :to="`/funds/${fund.id}`" class="fund-link">
                <v-btn icon small>
                  <v-icon small>
                    mdi-eye
                  </v-icon>
                </v-btn>
              </router-link>
              <v-btn icon small class="ml-2" @click="showAnalyticsModal(fund)">
                <v-icon small>
                  mdi-chart-bar
                </v-icon>
              </v-btn>
              <v-btn icon small class="ml-2" @click="showEditModal(fund)">
                <v-icon small>
                  mdi-pencil
                </v-icon>
              </v-btn>
            </v-col>
          </v-row>
        </v-card>
      </div>
      <div v-else class="mt-2">
        掲載中のオンラインサロンはありません
      </div>
    </div>
    <fund-analytics-modal
      :dialog="analyticsModal"
      :fund="selectedFund"
      @closeModal="closeModal"
    />
    <fund-edit-modal
      :dialog="editModal"
      :fund="selectedFund"
      @closeModal="closeModal"
    />
  </div>
</template>

<script>
import FundAnalyticsModal from '~/components/settings/organisms/FundAnalyticsModal.vue'
import FundEditModal from '~/components/settings/organisms/FundEditModal.vue'

export default {
  components: { FundAnalyticsModal, FundEditModal },
  props: {
    funds: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      analyticsModal: false,
      editModal: false,
      selectedFund: null
    }
  },
  methods: {
    closeModal (shouldUpdateUser) {
      this.editModal = false
      this.analyticsModal = false
      this.selectedFund = null
      // TODO: 必要があればサロン情報を含むユーザー情報を再取得する
    },
    showAnalyticsModal (fund) {
      this.selectedFund = fund
      this.analyticsModal = true
    },
    showEditModal (fund) {
      this.selectedFund = fund
      this.editModal = true
    }
  }
}
</script>
<style lang="scss" scoped>
.fund-link {
  text-decoration: none;
  color: inherit;
  .fund-card {
    :hover {
      opacity: 0.8;
    }
  }
}
</style>
