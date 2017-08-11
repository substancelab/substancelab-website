var webpack = require('webpack');

module.exports = {
  entry: {
    'lokalebasen.js': './source/javascripts/work/lokalebasen.js',
    'site.js': './source/javascripts/site.js'
  },

  resolve: {
    modules: [
      __dirname,
      'node_modules',
      __dirname + '/source/javascripts',
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
