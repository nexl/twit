const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')
const webpack = require('webpack')
const merge = require('webpack-merge')

environment.loaders.append('vue', vue)
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    JQuery: 'jquery',
    jquery: 'jquery',
    'window.Tether': "tether",
    Popper: ['popper.js', 'default']
  })
)

const envConfig = module.exports = environment
const aliasConfig = module.exports = {
  resolve: {
    alias: {
      jquery: 'jquery/src/jquery'
    }
  }
}

module.exports = merge(envConfig.toWebpackConfig(), aliasConfig)