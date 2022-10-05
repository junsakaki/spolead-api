<template>
  <v-row justify="space-around">
    <v-dialog
      v-if="dialog"
      :value="dialog"
      hide-overlay
      scrollable
    >
      <v-card class="d-flex align-start flex-column">
        <v-card-title class="justify-space-between">
          <span>出金依頼</span>
        </v-card-title>
        <v-card-text class="pb-0">
          <v-form v-model="isFormValid">
            <v-col cols="12">
              <v-text-field v-model="form.amount" type="number" label="出金金額" required :rules="amountRules" />
            </v-col>
            <v-col cols="12">
              <v-text-field v-model="form.account" label="振込先" placeholder="〇〇銀行 口座番号:123456789 ヤマダタロウ" required />
            </v-col>
          </v-form>
        </v-card-text>
        <v-card-actions class="d-flex flex-column" style="width: 100%;">
          <div class="d-flex justify-end mt-2" style="width: 100%;">
            <v-btn class="submit-button" color="primary" :disabled="!isFormValid" @click="submit">
              申請
            </v-btn>
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
export default {
  props: {
    dialog: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      form: {
        amount: '0',
        account: ''
      },
      amountRules: [
        v => (v && v >= 1) || '1 ~ 1,000,000 の間で設定してください',
        v => (v && v <= 1000000) || '1 ~ 1,000,000 の間で設定してください'
      ],
      isFormValid: false
    }
  },
  methods: {
    closeModal () {
      this.$emit('closeModal')
    },
    submit () {
      this.$store
        .dispatch('api/apiRequest', {
          api: 'postOrganizerManageWithdrawals',
          params: {
            ...this.params
          }
        }).then((res) => {
          console.log(res)
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
