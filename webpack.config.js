module.exports = {
	mode: 'development',
	entry: './src/index.ts',
	output: {
		path: __dirname,
		filename: 'qb.js'
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
	}
}
