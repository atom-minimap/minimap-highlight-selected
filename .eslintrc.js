module.exports = {
	env: {
		es6: true,
		browser: true,
		node: true,
		jasmine: true,
		atomtest: true,
	},
	extends: [
		'standard',
	],
	globals: {
		atom: 'readonly',
	},
	parserOptions: {
		ecmaVersion: 2018,
	},
	rules: {
		'no-warning-comments': 'warn',
		'comma-dangle': ['error', 'always-multiline'],
		indent: ['error', 'tab', { SwitchCase: 1 }],
		'no-tabs': ['error', { allowIndentationTabs: true }],
		'no-restricted-globals': [
			'error',
			{
				name: 'fit',
				message: 'Do not commit focused tests.',
			},
			{
				name: 'fdescribe',
				message: 'Do not commit focused tests.',
			},
		],
		'no-sync': 'error',
	},
}
