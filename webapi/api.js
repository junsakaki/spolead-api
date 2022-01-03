// localVer
// const foundation = 'http://localhost:3000/v1'
// const foundation = 'http://develop01.spolead-sv.net/api/v1'

// productionVer
const foundation = process.env.FOUNDATION

export default {
  // 都道府県取得外部API
  getPrefApi: {
    url: 'https://opendata.resas-portal.go.jp/api/v1/prefectures',
    method: 'get'
  },
  // 市町村取得外部API
  getCityApi: {
    url: 'https://opendata.resas-portal.go.jp/api/v1/cities',
    method: 'get'
  },

  // アカウント登録
  signup: {
    url: foundation + '/users',
    method: 'post'
  },
  // ユーザーログイン
  login: {
    url: foundation + '/login',
    method: 'post'
  },
  // ユーザーログアウト
  logout: {
    url: foundation + '/logout',
    method: 'delete'
  },
  // チーム一覧
  teamIndex: {
    url: foundation + '/teams',
    method: 'get'
  },
  // チーム詳細
  teamShow: {
    url: foundation + '/teams/:id',
    method: 'get'
  },
  // チーム作成
  teamCreate: {
    url: foundation + '/teams',
    method: 'post'
  },
  // チーム作成
  teamEdit: {
    url: foundation + '/teams/:id',
    method: 'patch'
  },
  // 口コミ作成（投稿）
  reviewCreate: {
    url: foundation + '/reviews',
    method: 'post'
  },
  // 口コミ一覧
  reviewIndex: {
    url: foundation + '/reviews',
    method: 'get'
  },
  /**
   * フォーラム一覧
   * @see https://jpkeylink.backlog.jp/alias/wiki/996424
   */
  forumIndex: {
    url: foundation + '/bbs/forums',
    method: 'get'
  },
  /**
   * フォーラム詳細
   * @see https://jpkeylink.backlog.jp/alias/wiki/996425
   */
  forumCreate: {
    url: foundation + '/bbs/forums/:forum_id',
    method: 'get'
  },
  /**
   * スレッド詳細
   * @see https://jpkeylink.backlog.jp/alias/wiki/996426
   */
  threadIndex: {
    url: foundation + '/bbs/threads/:thread_id',
    method: 'get'
  },
  /**
   * スレッド投稿
   * @see https://jpkeylink.backlog.jp/alias/wiki/996588
   */
  threadCreate: {
    url: foundation + '/bbs/threads',
    method: 'post'
  },
  /**
   * コメント詳細
   * @see https://jpkeylink.backlog.jp/alias/wiki/996427
   */
  commentIndex: {
    url: foundation + '/bbs/comments/:comment_id',
    method: 'get'
  },
  /**
   * コメント投稿
   * @see https://jpkeylink.backlog.jp/alias/wiki/996589
   */
  commentCreate: {
    url: foundation + '/bbs/comments',
    method: 'post'
  },
  /**
   * 通報
   * @see https://jpkeylink.backlog.jp/alias/wiki/996590
   */
  reportCreate: {
    url: foundation + '/bbs/reports',
    method: 'post'
  }
}
