<template>
  <span>
    <v-btn
      text
      icon
      x-small
      color="pink lighten-2"
      class="favorite-button"
      @click="makeFavoriteTeam()"
    >
      <v-icon v-if="isFavorite">
        mdi-heart
      </v-icon>
      <v-icon v-else>
        mdi-heart-outline
      </v-icon>
    </v-btn>
    <v-snackbar v-model="snackbar.display" top min-height="40" height="40" color="error">
      {{ snackbar.text }}
    </v-snackbar>
  </span>
</template>

<script>
export default {
  props: {
    isFavorite: {
      type: Boolean,
      default: null
    },
    teamId: {
      type: Number,
      default: null
    },
    userId: {
      type: Number,
      default: null
    }
  },
  data () {
    return {
      snackbar: {
        display: false,
        text: ''
      }
    }
  },
  methods: {
    makeFavoriteTeam () {
      if (!this.$auth) {
        this.snackbar = {
          display: true,
          text: 'チームをお気に入り登録するにはログインが必要です'
        }
        return
      }
      this.$store
        .dispatch('api/apiRequest', {
          api: 'favoriteTeamsCreate',
          data: {
            user_id: this.userId,
            team_id: this.teamId
          }
        })
        .then((response) => {
          if (response.status === 200) {
            this.$emit('next')
          }
        })
    }
  }
}
</script>
<style lang="scss" scoped>
.favorite-button {
  z-index: 2;
}
</style>
