var webpack = require('webpack');

module.exports = {
  entry: {
    'lokalebasen': './assets/javascripts/work/lokalebasen.js',
    'site': './assets/javascripts/site.js',
    'substance_lab': './assets/javascripts/substance_lab.js'
  },

  module: {
    loaders: [
      {
        test: /assets\/javascripts\/.*\.js$/,
        exclude: /node_modules|\.tmp|vendor/,
        loader: 'babel-loader',
        query: {
          presets: ['env']
        },
      }
    ]
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
