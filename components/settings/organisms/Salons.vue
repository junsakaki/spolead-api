<template>
  <div>
    <div class="subtitle-1 font-weight-bold">
      <div>オンラインサロンを掲載する</div>
      <div class="text-center px-4 mt-2">
        <router-link to="/salons/new" class="salon-link">
          <v-btn color="primary" outlined block>
            掲載情報入力フォームへ
          </v-btn>
        </router-link>
      </div>
    </div>
    <div class="subtitle-1 font-weight-bold mt-8">
      <div>参加中のオンラインサロン</div>
      <div v-if="salons.participation.length > 0" class="mt-2">
        <router-link v-for="salon in salons.participation" :key="salon.id" :to="`/salons/${salon.id}`" class="salon-link">
          <v-card outlined tile style="margin-top: -1px;" class="salon-card">
            <v-row class="my-1 px-2">
              <v-col cols="12" sm="9" class=" body-2 font-weight-bold">
                {{ salon.name }}
              </v-col>
              <v-col cols="12" sm="3" class="d-flex justify-end align-center caption">
                <v-icon small class="mr-1">
                  mdi-account
                </v-icon>
                {{ salon.owner_name }}
              </v-col>
            </v-row>
          </v-card>
        </router-link>
      </div>
      <div v-else class="mt-2">
        参加中のオンラインサロンはありません
      </div>
    </div>
    <div class="subtitle-1 font-weight-bold mt-8">
      <div>掲載中のオンラインサロン</div>
      <div v-if="salons.owned.length > 0" class="mt-2">
        <v-card
          v-for="salon in salons.owned"
          :key="salon.id"
          outlined
          tile
          style="margin-top: -1px;"
          class="salon-card"
        >
          <v-row class="my-1 px-2">
            <v-col cols="12" sm="9" class="body-2 font-weight-bold">
              {{ salon.name }}
            </v-col>
            <v-col cols="12" sm="3" class="d-flex justify-end align-center">
              <router-link :to="`/salons/${salon.id}`" class="salon-link">
                <v-btn icon small>
                  <v-icon small>
                    mdi-eye
                  </v-icon>
                </v-btn>
              </router-link>
              <!-- TODO: 各プランごとの参加者数をダイアログで表示する -->
              <v-btn icon small class="ml-2">
                <v-icon small>
                  mdi-chart-bar
                </v-icon>
              </v-btn>
              <!-- TODO: 編集フォームをダイアログで表示する -->
              <v-btn icon small class="ml-2">
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
  </div>
</template>

<script>
export default {
  props: {
    salons: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
    }
  },
  methods: {
  }
}
</script>
<style lang="scss" scoped>
.salon-link {
  text-decoration: none;
  color: inherit;
  .salon-card {
    :hover {
      opacity: 0.8;
    }
  }
}
</style>
