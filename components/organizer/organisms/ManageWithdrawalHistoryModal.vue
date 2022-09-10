<template>
  <v-row justify="space-around">
    <v-dialog
      v-if="dialog"
      :value="dialog"
      hide-overlay
      scrollable
      transition="dialog-bottom-transition"
    >
      <v-card class="d-flex align-start flex-column">
        <v-card-title class="justify-space-between">
          <span>出金履歴</span>
        </v-card-title>
        <v-card-text class="pb-0">
          <div class="withdrawal main mb-1">
            <div class="text-center grey--text">
              取引日時
            </div>
            <div class="text-center grey--text">
              出金額
            </div>
            <div class="text-center grey--text">
              取引内容
            </div>
          </div>
          <v-divider class="mb-2" />
        </v-card-text>
        <v-card-text style="height: 300px;">
          <div v-for="(withdrawal, i) in filteredWithdrawals" :key="`withdrawal-${i}`" class="withdrawal py-1">
            <div class="withdrawal-name text-center ml-2">
              {{ format(new Date(withdrawal.created_at), 'yyyy年MM月dd日') }}
            </div>
            <div class="text-center">
              {{ withdrawal.amount.toLocaleString() }}円
            </div>
            <div class="text-center">
              {{ withdrawal.content }}
            </div>
            <div class="filter" />
          </div>
        </v-card-text>
        <v-card-actions class="d-flex flex-column" style="width: 100%;">
          <div v-if="total_rows > perPage" class="text-center mt-4">
            <v-pagination
              v-model="page"
              :length="Math.ceil(total_rows / perPage)"
            />
          </div>
          <div class="d-flex justify-end mt-2" style="width: 100%;">
            <v-btn color="blue darken-1" text @click="closeModal(false)">
              閉じる
            </v-btn>
          </div>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
import { format } from 'date-fns'

export default {
  props: {
    dialog: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      page: 1,
      perPage: 20,
      total_rows: 0,
      withdrawals: [],
      filteredWithdrawals: [],
      format
    }
  },
  watch: {
    page (newVal) {
      const startIndex = (newVal - 1) * this.perPage
      const endIndex = startIndex + this.perPage
      this.filteredWithdrawals = this.withdrawals.slice(startIndex, endIndex)
    }
  },
  created () {
    this.load()
  },
  methods: {
    closeModal () {
      this.$emit('closeModal')
    },
    load () {
      this.$store
        .dispatch('api/apiRequest', {
          api: 'getOrganizerManageWithdrawals',
          params: {
            userId: Number(localStorage.getItem('organizer_user_id'))
          }
        }).then((res) => {
          this.withdrawals = res.data.item.sort((a, b) => new Date(b.created_at) - new Date(a.created_at))
          this.filteredWithdrawals = this.withdrawals.slice(0, this.perPage)
          this.total_rows = res.data.item.length
        })
    }
  }
}
</script>
<style lang="scss" scoped>
.withdrawal {
  position: relative;
  display: grid;
  grid-template-columns: 200px 150px 1fr;
  text-decoration: none;
  color: inherit;
}
.withdrawal:visited {
  color: inherit;
}
.withdrawal.main {
  font-size: 12px;
}
.withdrawal-name {
  overflow: hidden;
  width: 100%;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.withdrawal .filter {
  position: absolute;
  width: 100%;
  height: 100%;
  background: #1976d214;
  opacity: 0;
  transition-duration: 0.5s;
  cursor: pointer;
}
.withdrawal:hover .filter {
  opacity: 1;
}
</style>
