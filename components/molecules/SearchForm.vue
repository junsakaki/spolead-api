<template>
  <div class="search-field">
    <!-- <label for="group_name">{{ label }}</label> -->
    <v-text-field
      v-model="searchWord"
      label="検索(チーム名、都道府県、市区町村)"
    />
    <common-button @click="execSearch(searchWord)" button-color="primary">
      検索
    </common-button>
  </div>
</template>

<script>
import CommonButton from '~/components/atoms/CommonButton.vue'

export default {
  components: {
    CommonButton
  },
  props: {
    options: {
      type: Array,
      default: () => {}
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
  height: 32px;
  width: 35vw;
  padding: 4px;
  label {
    font-size: 32px;
  }
  .common-button {
    margin-left: 12px;
  }
}
</style>
