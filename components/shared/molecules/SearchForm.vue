<template>
  <div>
    <div v-if="$vuetify.breakpoint.smAndDown" class="search-field">
      <!-- <label for="group_name">{{ label }}</label> -->
      <v-text-field
        v-model="searchWord"
        :label="placeholder"
        @keydown.enter="execSearch(searchWord)"
      />
    </div>
    <div v-else class="search-field">
      <!-- <label for="group_name">{{ label }}</label> -->
      <v-text-field
        v-model="searchWord"
        :label="placeholder"
      />
      <common-button button-color="primary" @click="execSearch(searchWord)">
        検索
      </common-button>
    </div>
  </div>
</template>

<script>
import CommonButton from '~/components/shared/atoms/CommonButton.vue'

export default {
  components: {
    CommonButton
  },
  props: {
    options: {
      type: Array,
      default: () => {}
    },
    placeholder: {
      type: String,
      default: ''
    }
  },
  data () {
    return {
      searchWord: ''
    }
  },
  methods: {
    execSearch (searchWord) {
      this.$emit('execSearch', searchWord)
    }
  }
}
</script>
<style lang="scss" scoped>
.search-field {
  display: flex;
  justify-content: space-around;
  width: 100%;
  max-width: 400px;
  padding: 4px;
  margin: 12px auto;
  label {
    font-size: 32px;
  }
  .common-button {
    margin-left: 12px;
  }
}
</style>
