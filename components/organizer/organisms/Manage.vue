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
    <div class="d-flex align-center mt-8 mb-8">
      <div class="subtitle-1 font-weight-bold">
        出金履歴
      </div>
      <v-btn x-small text color="primary" class="ml-4" @click="showManageWithdrawalHistoryModal">
        表示
      </v-btn>
    </div>
    <div class="d-flex align-centermt-8 mb-8">
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
    <div class="d-flex align-centermt-8 mb-8">
      <div class="subtitle-1 font-weight-bold">
        パスワード変更
      </div>
      <div class="d-flex align-center ml-4">
        <v-btn x-small text color="primary" class="ml-4" @click="showManageUpdatePasswordModal">
          変更
        </v-btn>
      </div>
    </div>
    <manage-earnings-report-modal
      :dialog="manageEarningsReportModal"
      @closeModal="closeModal"
    />
    <manage-withdrawal-history-modal
      :dialog="manageWithdrawalHistoryModal"
      @closeModal="closeModal"
    />
    <manage-update-email-address-modal
      :dialog="manageUpdateEmailAddressModal"
      :user="user"
      @closeModal="closeModal"
    />
    <manage-update-password-modal
      :dialog="manageUpdatePasswordModal"
      @closeModal="closeModal"
    />
  </div>
</template>

<script>
import ManageEarningsReportModal from '~/components/organizer/organisms/ManageEarningsReportModal.vue'
import ManageWithdrawalHistoryModal from '~/components/organizer/organisms/ManageWithdrawalHistoryModal.vue'
import ManageUpdateEmailAddressModal from '~/components/organizer/organisms/ManageUpdateEmailAddressModal.vue'
import ManageUpdatePasswordModal from '~/components/organizer/organisms/ManageUpdatePasswordModal.vue'

export default {
  components: {
    ManageEarningsReportModal,
    ManageWithdrawalHistoryModal,
    ManageUpdateEmailAddressModal,
    ManageUpdatePasswordModal
  },
  data () {
    return {
      manageEarningsReportModal: false,
      manageWithdrawalHistoryModal: false,
      manageUpdateEmailAddressModal: false,
      manageUpdatePasswordModal: false,
      user: { email: '' }
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
      this.manageUpdateEmailAddressModal = false
      this.manageUpdatePasswordModal = false
    },
    showManageEarningsReportModal () {
      this.manageEarningsReportModal = true
    },
    showManageWithdrawalHistoryModal () {
      this.manageWithdrawalHistoryModal = true
    },
    showManageUpdateEmailAddressModal () {
      this.manageUpdateEmailAddressModal = true
    },
    showManageUpdatePasswordModal () {
      this.manageUpdatePasswordModal = true
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
