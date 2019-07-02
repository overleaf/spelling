// TODO: This file was created by bulk-decaffeinate.
// Sanity-check the conversion and remove this comment.
/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * DS207: Consider shorter variations of null checks
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
let LearnedWordsManager
const db = require('./DB')
const mongoCache = require('./MongoCache')
const logger = require('logger-sharelatex')
const metrics = require('metrics-sharelatex')

module.exports = LearnedWordsManager = {
  learnWord(user_token, word, callback) {
    if (callback == null) {
      callback = function(error) {}
    }
    mongoCache.del(user_token)
    return db.spellingPreferences.update(
      {
        token: user_token
      },
      {
        $push: { learnedWords: word }
      },
      {
        upsert: true
      },
      callback
    )
  },

  getLearnedWords(user_token, callback) {
    if (callback == null) {
      callback = function(error, words) {}
    }
    const mongoCachedWords = mongoCache.get(user_token)
    if (mongoCachedWords != null) {
      metrics.inc('mongoCache', 0.1, { status: 'hit' })
      return callback(null, mongoCachedWords)
    }

    metrics.inc('mongoCache', 0.1, { status: 'miss' })
    logger.info({ user_token }, 'mongoCache miss')

    return db.spellingPreferences.findOne({ token: user_token }, function(
      error,
      preferences
    ) {
      if (error != null) {
        return callback(error)
      }
      const words =
        (preferences != null ? preferences.learnedWords : undefined) || []
      mongoCache.set(user_token, words)
      return callback(null, words)
    })
  },

  deleteUsersLearnedWords(user_token, callback) {
    if (callback == null) {
      callback = function(error) {}
    }
    return db.spellingPreferences.remove({ token: user_token }, callback)
  }
}
;['learnWord', 'getLearnedWords'].map(method =>
  metrics.timeAsyncMethod(
    LearnedWordsManager,
    method,
    'mongo.LearnedWordsManager',
    logger
  )
)
