return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				-- 이 키로 터미널을 열고 닫습니다. (Ctrl + \)
				open_mapping = [[<c-\>]],

				-- 터미널이 열릴 때 바로 Insert 모드로 시작합니다.
				start_in_insert = true,

				-- 터미널 창을 닫아도 프로세스는 유지합니다 (다시 열면 내용이 살아있음).
				persist_size = true,

				-- 터미널 창의 방향 (수평, 수직, 플로팅, 탭)
				direction = "horizontal", -- 'horizontal', 'vertical', 'tab' 도 가능

				-- 터미널이 종료되면 창도 자동으로 닫습니다.
				close_on_exit = true,

				-- 플로팅 터미널 설정
				float_opts = {
					border = "curved", -- 'single', 'double' 등 가능
				},
			})
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<M-\\>", [[<C-\><C-n>]], opts)
			end

			-- TermOpen 이벤트 발생시 키맵 설정
			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		end,
	},
}
