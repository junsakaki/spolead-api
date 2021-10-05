const SPORTS = [
  { id: 1, title: 'Soccer', titleJP: 'サッカー', src: require('~/assets/images/soccer.jpg') },
  { id: 2, title: 'Baseball', titleJP: '野球', src: require('~/assets/images/baseball.jpg') },
  { id: 3, title: 'Basketball', titleJP: 'バスケットボール', src: require('~/assets/images/basketball.jpeg') },
  { id: 4, title: 'Volleyball', titleJP: 'バレーボール', src: require('~/assets/images/volleyball.jpeg') },
  { id: 5, title: 'Dance', titleJP: 'ダンス', src: require('~/assets/images/dance.jpeg') },
  { id: 6, title: 'Rugby', titleJP: 'ラグビー', src: require('~/assets/images/rugby.jpeg') },
  { id: 7, title: 'Swimming', titleJP: '水泳', src: require('~/assets/images/swimming.jpeg') }
]

export default (context, inject) => {
  inject('SPORTS', SPORTS)
}
