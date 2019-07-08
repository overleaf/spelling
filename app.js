/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * DS103: Rewrite code to no longer use __guard__
 * DS207: Consider shorter variations of null checks
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
const metrics = require('metrics-sharelatex')
metrics.initialize('spelling')

const Settings = require('settings-sharelatex')
const logger = require('logger-sharelatex')
logger.initialize('spelling')
if ((Settings.sentry != null ? Settings.sentry.dsn : undefined) != null) {
  logger.initializeErrorReporting(Settings.sentry.dsn)
}
metrics.memory.monitor(logger)

const SpellingAPIController = require('./app/js/SpellingAPIController')
const express = require('express')
const server = express()
metrics.injectMetricsRoute(server)
const bodyParser = require('body-parser')
const HealthCheckController = require('./app/js/HealthCheckController')

server.use(bodyParser.json({ limit: '2mb' }))
server.use(metrics.http.monitor(logger))

server.del('/user/:user_id', SpellingAPIController.deleteDic)
server.get('/user/:user_id', SpellingAPIController.getDic)
server.post('/user/:user_id/check', SpellingAPIController.check)
server.post('/user/:user_id/learn', SpellingAPIController.learn)
server.get('/status', (req, res) => res.send({ status: 'spelling api is up' }))

server.get('/health_check', HealthCheckController.healthCheck)

const settings =
  Settings.internal && Settings.internal.spelling
    ? Settings.internal.spelling
    : undefined
const host = settings && settings.host ? settings.host : 'localhost'
const port = settings && settings.port ? settings.port : 3005

if (!module.parent) {
  // application entry point, called directly
  server.listen(port, host, function(error) {
    if (error != null) {
      throw error
    }
    return logger.info(`spelling starting up, listening on ${host}:${port}`)
  })
}

module.exports = server
