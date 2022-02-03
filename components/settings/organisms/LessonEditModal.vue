<template>
  <v-row justify="center">
    <v-dialog v-if="dialog" :value="dialog" persistent max-width="600px">
      <lessons-regist-form :lesson="lesson" @closeModal="closeModal" />
    </v-dialog>
  </v-row>
</template>

<script>
import LessonsRegistForm from '../../lessons/organisms/LessonsRegistForm.vue'
export default {
  components: {
    LessonsRegistForm
  },
  props: {
    dialog: {
      type: Boolean,
      default: false
    },
    lesson: {
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
    console.log(this.lesson)
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
