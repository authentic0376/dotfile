-- Conform: 포맷팅 (통합 포맷터)
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			vue = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			lua = { "stylua" },
			python = { "ruff_format" },
		},

		-- 저장시 자동 포맷 (LSP fallback 제거 - Conform만 사용)
		format_on_save = {
			lsp_fallback = false,
			timeout_ms = 3000,
		},
	},
	init = function()
		-- Conform을 기본 포맷 엔진으로 설정
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

		-- 수동 포맷 키맵 (mini.files와 충돌 방지)
		vim.keymap.set({ "n", "v" }, "<leader>cf", function()
			require("conform").format({ async = true })
		end, { desc = "Format" })
	end,
}
