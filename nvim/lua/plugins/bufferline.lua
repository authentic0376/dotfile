return {
	"akinsho/bufferline.nvim",
	version = "*", -- 안정성을 위해 특정 태그(예: "v4.9.1")를 사용할 수도 있습니다.
	dependencies = "nvim-tree/nvim-web-devicons", -- 아이콘 표시를 위한 의존성 플러그인
	-- 키맵을 config 안에서 하는것이든, options를 setup에 직접 넣는 것이든
	-- 어떤 게 bufferline의 로딩을 활성화 했어서 예전엔 lazy=false가 필요 없었다
	-- 그런데, keys 에 키맵을 하니 bufferline이 로딩이 안되는 문제가 생겼다
	-- 또한, lazy=false 를 해 놓아도, config setup이 필요하다.
	-- 아무튼 vim.keymap.set 보다 깔끔한 문법이므로 이렇게 수정한다
	lazy = false,
	keys = {
		-- 탭닫기
		{ "<leader>td", "<Cmd>tabclose<CR>", desc = "탭 닫기" },
		-- 탭열기
		{ "<leader>tn", "<Cmd>tabnew<CR>", desc = "탭 열기" },
		-- 탭픽
		{ "<leader>tp", "<Cmd>BufferLinePick<CR>", desc = "탭 픽" },
	},
	opts = { options = { mode = "tabs" } },
}
