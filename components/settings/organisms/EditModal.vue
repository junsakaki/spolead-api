<template>
  <v-row justify="center">
    <v-dialog v-if="dialog" :value="dialog" persistent max-width="600px">
      <salons-regist-form :salon="salon" @closeModal="closeModal" />
    </v-dialog>
  </v-row>
</template>

<script>
import SalonsRegistForm from '../../salons/organisms/SalonsRegistForm.vue'
export default {
  components: {
    SalonsRegistForm
  },
  props: {
    dialog: {
      type: Boolean,
      default: false
    },
    salon: {
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
    console.log(this.salon)
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
