<template>
  <v-btn @click="click" :color="buttonColor" :width="buttonWidth" large class="common-button">
    <slot />
  </v-btn>
</template>
<script>
export default {
  props: {
    buttonSize: {
      type: String,
      default: ''
    },
    buttonColor: {
      type: String,
      default: ''
    },
    buttonWidth: {
      type: String,
      default: ''
    }
  },
  data () {
    return {
      buttonStyle: {
        height: this.height,
        width: this.width,
        fontSize: this.fontSize
      }
    }
  },
  methods: {
    click () {
      this.$emit('click', event)
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
