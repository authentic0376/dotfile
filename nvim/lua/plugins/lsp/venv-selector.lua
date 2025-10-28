return {
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		ft = "python", -- Python 파일 열 때 로드
		opts = {
			-- pyright, ruff 등 지원되는 LSP 이름
			-- 이 플러그인이 자동으로 해당 LSP의 인터프리터 경로를 설정함
			name = { "basedpyright", "ruff" },
		},
		keys = {
			{ "<leader>vs", "<cmd>VenvSelect<cr>", desc = "가상 환경 선택" },
		},
	},
}
