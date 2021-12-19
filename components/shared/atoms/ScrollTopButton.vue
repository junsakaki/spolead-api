<template>
  <transition name="scroll-top-button">
    <div v-show="buttonActive" class="scroll-top-button">
      <v-btn
        fab
        dark
        small
        color="primary"
        @click="scrollTop"
      >
        <v-icon dark>
          mdi-chevron-up
        </v-icon>
      </v-btn>
    </div>
  </transition>
</template>

<script>
export default {
  data () {
    return {
      buttonActive: false,
      scroll: 0
    }
  },
  mounted () {
    window.addEventListener('scroll', this.scrollWindow)
  },
  methods: {
    scrollTop () {
      window.scrollTo({
        top: 0,
        behavior: 'smooth'
      })
    },
    scrollWindow () {
      const top = 500
      this.scroll = window.scrollY
      if (top <= this.scroll) {
        this.buttonActive = true
      } else {
        this.buttonActive = false
      }
    }
  }
}
</script>

<style lang="scss" scoped>
  .scroll-top-button {
    position: sticky;
    text-align: right;
    margin: 0 16px 16px;
    bottom: 16px;
    transition: 0.5s;
  }
  .scroll-top-button-enter-active, .scroll-top-button-leave-active{
    transition: opacity 0.3s
  }
  .scroll-top-button-enter, .scroll-top-button-leave-to{
    opacity: 0;
  }
</style>
