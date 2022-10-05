<template>
  <div>
    <div class="d-flex align-center">
      <div class="subtitle-1 font-weight-bold">
        売上報告
      </div>
      <v-btn x-small text color="primary" class="ml-4" @click="showManageEarningsReportModal">
        表示
      </v-btn>
    </div>
    <div class="mt-8 mb-8">
      <div class="d-flex align-center">
        <div class="subtitle-1 font-weight-bold">
          出金履歴
        </div>
        <v-btn x-small text color="primary" class="ml-4" @click="showManageWithdrawalHistoryModal">
          表示
        </v-btn>
      </div>
      <v-btn color="primary" class="ml-4" block outlined @click="showManageWithdrawalRequestModal">
        出金依頼
      </v-btn>
    </div>
    <div class="d-flex align-center mt-8 mb-8">
      <div class="subtitle-1 font-weight-bold">
        メールアドレス変更
      </div>
      <div class="d-flex align-center ml-4">
        <div class="body-1">
          {{ user.email }}
        </div>
        <v-btn x-small text color="primary" class="ml-4" @click="showManageUpdateEmailAddressModal">
          変更
        </v-btn>
      </div>
    </div>
    <div class="mt-8 mb-8">
      <div class="d-flex align-center mt-8">
        <div class="subtitle-1 font-weight-bold">
          パスワードリセット
        </div>
        <div class="d-flex align-center ml-4">
          <v-btn
            v-if="!passwordResetAlert"
            color="error"
            x-small
            text
            @click="passwordResetAlert = true"
          >
            リセット
          </v-btn>
        </div>
      </div>
      <v-alert
        v-model="passwordResetAlert"
        prominent
        type="error"
        dismissible
      >
        <v-row align="center">
          <v-col class="grow body-2">
            パスワードをリセットすると、自動でログアウトします。登録されているメールアドレスに送付される新しいパスワードで、再度ログインしてください。
          </v-col>
          <v-col class="shrink">
            <v-btn
              color="white"
              outlined
              @click="resetPassword"
            >
              実行
            </v-btn>
          </v-col>
        </v-row>
      </v-alert>
    </div>
    <manage-earnings-report-modal
      :dialog="manageEarningsReportModal"
      @closeModal="closeModal"
    />
    <manage-withdrawal-history-modal
      :dialog="manageWithdrawalHistoryModal"
      @closeModal="closeModal"
    />
    <manage-withdrawal-request-modal
      :dialog="manageWithdrawalRequestModal"
      @closeModal="closeModal"
    />
    <manage-update-email-address-modal
      :dialog="manageUpdateEmailAddressModal"
      :user="user"
      @closeModal="closeModal"
    />
  </div>
</template>

<script>
import ManageEarningsReportModal from '~/components/organizer/organisms/ManageEarningsReportModal.vue'
import ManageWithdrawalHistoryModal from '~/components/organizer/organisms/ManageWithdrawalHistoryModal.vue'
import ManageWithdrawalRequestModal from '~/components/organizer/organisms/ManageWithdrawalRequestModal.vue'
import ManageUpdateEmailAddressModal from '~/components/organizer/organisms/ManageUpdateEmailAddressModal.vue'

export default {
  components: {
    ManageEarningsReportModal,
    ManageWithdrawalHistoryModal,
    ManageWithdrawalRequestModal,
    ManageUpdateEmailAddressModal
  },
  data () {
    return {
      manageEarningsReportModal: false,
      manageWithdrawalHistoryModal: false,
      manageWithdrawalRequestModal: false,
      manageUpdateEmailAddressModal: false,
      manageUpdatePasswordModal: false,
      user: { email: '' },
      passwordResetAlert: false
    }
  },
  watch: {
    '$store.state.organizer.user' () {
      this.user = this.$store.state.organizer.user
    }
  },
  created () {
  },
  methods: {
    closeModal () {
      this.manageEarningsReportModal = false
      this.manageWithdrawalHistoryModal = false
      this.manageWithdrawalRequestModal = false
      this.manageUpdateEmailAddressModal = false
      this.manageUpdatePasswordModal = false
    },
    showManageEarningsReportModal () {
      this.manageEarningsReportModal = true
    },
    showManageWithdrawalHistoryModal () {
      this.manageWithdrawalHistoryModal = true
    },
    showManageWithdrawalRequestModal () {
      this.manageWithdrawalRequestModal = true
    },
    showManageUpdateEmailAddressModal () {
      this.manageUpdateEmailAddressModal = true
    },
    showManageUpdatePasswordModal () {
      this.manageUpdatePasswordModal = true
    },
    resetPassword () {
      this.passwordResetAlert = false
      this.$store
        .dispatch('api/apiRequest', {
          api: 'postOrganizerPasswordReset',
          params: {
            email: this.$store.state.organizer.user.email
          }
        }).then((res) => {
          this.$methods.logoutOrganizerUser()
        })
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
