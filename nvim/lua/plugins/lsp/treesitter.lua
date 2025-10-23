-- Treesitter: 구문 하이라이팅
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	opts = {
		ensure_installed = {
			"javascript",
			"typescript",
			"tsx",
			"vue",
			"python",
			"lua",
			"vim",
			"vimdoc",
			"html",
			"css",
			"scss",
			"json",
			"jsonc",
			"yaml",
			"toml",
			"bash",
			"dockerfile",
			"gitignore",
			"markdown",
			"markdown_inline",
			"regex",
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
		},
		-- mini.ai가 이미 textobject 제공하므로 간단하게만 설정
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = false,
				node_incremental = "v",
				scope_incremental = false,
				node_decremental = "V",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					-- mini.ai와 충돌하지 않는 키맵 사용
					["aF"] = "@function.outer",
					["iF"] = "@function.inner",
					["aC"] = "@class.outer",
					["iC"] = "@class.inner",
				},
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)

		-- Treesitter 기반 폴딩
		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo.foldenable = false -- 시작시 접기 비활성화
	end,
}
