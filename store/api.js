import axios from 'axios'
import apiEndpoint from '../webapi/api'

export const namespaced = true
// const getters = {}
export const actions = {
  apiRequest (context, reqData) {
    return new Promise((resolve, reject) => {
      const req = {}
      req.timeout = 10000
      req.data = reqData.data
      req.params = reqData.params
      req.method = apiEndpoint[reqData.api].method
      if (reqData.query) {
        req.url = apiEndpoint[reqData.api].url.replace(`:${Object.keys(reqData.query)[0]}`, reqData.query[Object.keys(reqData.query)[0]])
      } else {
        req.url = apiEndpoint[reqData.api].url
      }
      if (reqData.api !== 'getAddressXYApi') {
        req.headers = {}
      }
      if (reqData.api === 'getCityApi' || reqData.api === 'getPrefApi') {
        // req.headers['X-API-KEY'] = process.env.GET_CITY_APIKEY
        req.headers['X-API-KEY'] = 'UTcSHZB4MAnbEfmMQznGeiFmyapUsZjwhz9ulUrv'
      }
      if (~reqData.api.indexOf('Organizer')) {
        req.headers.Authorization = localStorage.getItem('organizer_token')
      }
      axios(req)
        .then((response) => {
          resolve(response)
        })
        .catch((err) => {
          reject(err)
        })
    })
  }
}
