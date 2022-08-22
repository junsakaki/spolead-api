export const state = () => ({
  user: {
    email: '',
    owned: {
      salons: [],
      funds: [],
      lessons: []
    }
  }
})

export const mutations = {
  setOrganizer (state, user) {
    state.user = user
  }
}

export const actions = {
  setOrganizer ({ commit }, { user }) {
    commit('setOrganizer', user)
  }
}
