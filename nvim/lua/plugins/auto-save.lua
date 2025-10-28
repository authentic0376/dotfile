return {
	"okuuva/auto-save.nvim",
	version = "*", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
	lazy = false,
	opts = {
		debounce_delay = 2500,
	},
	keys = {
		{ "<M-4>", "<Cmd>ASToggle<CR>", desc = "ASToggle" },
	},
}
