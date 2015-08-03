path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root: rootPath
    app:
      name: 'source'
    port: 3000
    db: 'postgres://postgres:password@192.168.59.103/kiwiprints'

  test:
    root: rootPath
    app:
      name: 'source'
    port: 3000
    db: 'postgres://localhost/source_test'

  production:
    root: rootPath
    app:
      name: 'source'
    port: 3000
    db: 'postgres://localhost/source_production'

module.exports = config[env]
