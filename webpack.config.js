var webpack = require('webpack');

module.exports = {
  entry: {
    'layout': './assets/stylesheets/layout.sass',
    'print': './assets/stylesheets/print.sass',

    'lokalebasen': './assets/javascripts/work/lokalebasen.js',
    'site': './assets/javascripts/site.js',
    'substance_lab': './assets/javascripts/substance_lab.js'
  },

  module: {
    rules: [
      {
        test: /assets\/javascripts\/.*\.js$/,
        exclude: /node_modules|\.tmp|vendor/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: [
              ['@babel/preset-env', {targets: "defaults"}]
            ]
          }
        },
      },

      {
        test: /assets\/stylesheets\/.*(\.scss|\.sass)$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              name: 'stylesheets/[name].css'
            }
          },
          {
            loader: 'resolve-url-loader'
          },
          {
            loader: 'sass-loader',
            options: {
              sourceMap: true
            }
          }
        ]
      }
    ]
  },

  resolve: {
    modules: [
      __dirname + '/node_modules',
      __dirname + '/assets/javascripts',
      __dirname + '/assets/stylesheets',
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
