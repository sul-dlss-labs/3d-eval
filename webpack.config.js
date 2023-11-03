const path = require('path');

module.exports = {
  entry: {
    virtex_viewer: path.resolve(__dirname, '_js', 'virtex-viewer.js')
  },
  mode: 'production',
  output: {
    path: path.resolve(__dirname, 'assets/js'),
    filename: '[name].bundle.js'
  }
}
