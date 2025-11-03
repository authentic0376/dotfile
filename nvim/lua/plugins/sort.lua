return {
	"sQVe/sort.nvim",
	-- 1. '<leader>s' 와 '<leader>S'로 안전하게 맵핑합니다.
	keys = {
		{ "<leader>s", ":Sort<CR>", mode = "x", desc = "Sort selection" },
		{ "<leader>S", ":Sort!<CR>", mode = "x", desc = "Sort selection (reverse)" },
	},
	-- 2. 플러그인의 기본 맵핑은 비활성화합니다.
	config = function()
		require("sort").setup({
			mappings = {
				operator = false,
				textobject = false,
				motion = false,
			},
		})
	end,
}
