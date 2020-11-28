const { createRunner } = require('atom-jasmine3-test-runner')

module.exports = createRunner({
	specHelper: {
		attachToDom: true,
		ci: true,
	},
	testPackages: ['minimap', 'highlight-selected'],
})
