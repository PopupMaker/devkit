const eslintConfig = {
	root: true,
	extends: [ 'plugin:@code-atlantic/base' ],
	plugins: [ '@code-atlantic' ],
	settings: {
		react: {
			version: '16.9.0',
		},
	},
	globals: {
		_: 'readonly',
		wp: 'readonly',
		jQuery: 'readonly',
	},
	rules: {
		// 'react/react-in-jsx-scope': 'off',
		// 'react/jsx-pascal-case': 'off',
		// 'react/jsx-props-no-spreading': 'off',
		// 'no-undefined': 'off',
		// 'import/no-unresolved': [ 'error', {
		// 	ignore: [ '@wordpress' ],
		// } ],
		// 'jsx-a11y/media-has-caption': 'off',
	},
};

module.exports = eslintConfig;
