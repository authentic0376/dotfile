return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "mason-org/mason.nvim", opts = {} },
	opts = {
		ensure_installed = {
			-- Formatters
			"prettier",
			"stylua",
			"black",
		},
		auto_update = true,
		run_on_start = true,
	},
}
