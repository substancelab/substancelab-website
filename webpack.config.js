var webpack = require('webpack');

module.exports = {
  entry: {
    'lokalebasen': './assets/javascripts/work/lokalebasen.js',
    'site': './assets/javascripts/site.js',
    'substance_lab': './assets/javascripts/substance_lab.js'
  },

  resolve: {
    modules: [
      __dirname + '/node_modules',
      __dirname + '/assets/javascripts',
    ],
  },

  output: {
    path: __dirname + '/.tmp/webpack-build',
    filename: 'javascripts/[name].js',
  },

  plugins: [
    new webpack.ProvidePlugin({
      'window.jQuery': 'jquery',
      $: 'jquery',
      jQuery: 'jquery',
    }),
  ],
};
