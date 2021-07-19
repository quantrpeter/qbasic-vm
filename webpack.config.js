const path = require('path')

module.exports = {
	mode: 'development',
	entry: './src/index.ts',
	output: {
		path: __dirname,
		filename: './dist/qb.js'
	},
	devtool: 'source-map',
	resolve: {
		extensions: ['.js', '.ts', '.json']
	},
	module: {
		rules: [
			{
				test: /\.tsx?$/,
				exclude: /node_modules/,
				use: {
					loader: 'ts-loader',
					options: {
						transpileOnly: true
					}
				}
			}
		]
	},
	devServer: {
		contentBase: [
			path.join(__dirname, 'demo'),
			path.join(__dirname, 'assets'),
			path.join(__dirname, 'dist')
		],
		compress: true,
		port: 9000,
		open: true,
		openPage: 'index.html',
		watchContentBase: true,
		filename: 'qb.js'
	},
}
