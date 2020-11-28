const MinimapHighlightSelected = require('../lib/minimap-highlight-selected')

describe('MinimapHighlightSelected', () => {
	let workspace

	beforeEach(async () => {
		workspace = atom.views.getView(atom.workspace)
		jasmine.attachToDOM(workspace)

		// Package activation will be deferred to the configured, activation hook, which is then triggered
		// Activate activation hook
		atom.packages.triggerDeferredActivationHooks()
		atom.packages.triggerActivationHook('core:loaded-shell-environment')
		await atom.packages.activatePackage('minimap')
		await atom.packages.activatePackage('highlight-selected')
	})

	describe('when the package is activated', () => {
		beforeEach(async () => {
			await atom.packages.activatePackage('minimap-highlight-selected')
		})

		it('should activate', () => {
			expect(MinimapHighlightSelected.isActive()).toBe(true)
		})
	})
})
