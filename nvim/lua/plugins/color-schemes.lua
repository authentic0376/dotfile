-- Or with configuration
return {
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
	},
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("tokyonight").setup({
				-- ...
			})

			vim.cmd("colorscheme tokyonight-moon")
		end,
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
