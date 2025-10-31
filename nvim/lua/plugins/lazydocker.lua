return {
	"crnvl96/lazydocker.nvim",

	-- 플러그인을 로드할 키 설정 (README의 키맵 예시)
	-- 'n' (normal) 모드와 't' (terminal) 모드에서 모두 작동
	keys = {
		{
			"<leader>ld",
			"<Cmd>lua require('lazydocker').toggle({ engine = 'docker' })<CR>",
			desc = "LazyDocker (docker)",
			mode = { "n", "t" },
		},
	},

	-- 'config' 함수를 사용하면 플러그인이 로드된 직후에 setup 함수가 실행됩니다.
	config = function()
		require("lazydocker").setup({
			window = {
				settings = {
					width = 1, -- Percentage of screen width (0 to 1)
					height = 1, -- Percentage of screen height (0 to 1)
				},
			},
		})
	end,
}
