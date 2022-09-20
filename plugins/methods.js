export default ({ store }, inject) => {
  const methods = {
    getOrganizerUser: () => {
      store.dispatch('api/apiRequest', {
        api: 'getOrganizerUser',
        query: {
          user_id: localStorage.getItem('organizer_user_id')
        },
        header: {
          authorization: localStorage.getItem('organizer_token')
        }
      }).then((res) => {
        if (res.status === 200) {
          store.dispatch('organizer/setOrganizer', { user: res.data.user })
        }
      })
    },
    logoutOrganizerUser: () => {
      store.dispatch('api/apiRequest', {
        api: 'organizerLogout',
        data: {
          user_id: Number(localStorage.getItem('organizer_user_id'))
        }
      }).then((res) => {
        if (res.status === 200) {
          localStorage.removeItem('organizer_token')
          localStorage.removeItem('organizer_user_id')
          window.location = '/organizer/login'
        }
      })
    }
  }
  inject('methods', methods)
}
