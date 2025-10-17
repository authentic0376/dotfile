return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			globalstatus = true,
		},
		sections = {
			lualine_c = { -- 활성창 winbar 중앙에 파일명 표시
				{
					"filename",
					path = 1, -- 0: 파일명만, 1: 상대 경로, 2: 절대 경로, 3: ~ 포함 절대 경로
				},
			},
			lualine_x = {
				{
					function()
						-- .lib 는 플러그인 명 뒤에 생략되던 lib를 넣은 게 아니라,
						-- 하부 폴더 lib를 의미한다
						local session_name = require("auto-session.lib").current_session_name(true)
						if not session_name or session_name == "" then
							return ""
						end
						return "Session: " .. session_name
					end,
					color = { bg = "#565f89", fg = "#c0caf5" },
				},
			},
		},
		winbar = {
			lualine_c = { -- 활성창 winbar 중앙에 파일명 표시

				"filename",
			},
		},
		inactive_winbar = {
			lualine_c = { "filename" }, -- 비활성창 winbar 중앙에 파일명 표시
		},
	},
}
