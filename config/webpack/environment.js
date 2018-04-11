const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')
const webpack = require('webpack')

environment.loaders.append('vue', vue)
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery'
  })
)
module.exports = environment
