<template>
  <v-row justify="center">
    <v-dialog v-if="dialog" :value="dialog" persistent max-width="600px">
      <funds-regist-form :fund="fund" @closeModal="closeModal" />
    </v-dialog>
  </v-row>
</template>

<script>
import FundsRegistForm from '../../funds/organisms/FundsRegistForm.vue'
export default {
  components: {
    FundsRegistForm
  },
  props: {
    dialog: {
      type: Boolean,
      default: false
    },
    fund: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      content: ''
    }
  },
  created () {
    console.log(this.fund)
  },
  methods: {
    update () {
      this.closeModal(true)
    },
    closeModal (shouldUpdateUser) {
      this.$emit('closeModal', shouldUpdateUser)
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
