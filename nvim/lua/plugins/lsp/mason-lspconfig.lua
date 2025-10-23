-- Mason-NSPConfig: Mason과 LSP 연결
-- vim.lsp.enable 도 해준다
return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		-- lsp 패키지 매니저
		-- opts를 써서 실행이 필수
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig", -- lsp 기본 설정값 자동설정
	},
	lazy = false,
	opts = {
		auto_install = true,
		ensure_installed = {
			-- JavaScript/TypeScript
			"vtsls", -- vue 공식, ts,js. vue_ls 를 플러그인으로 사용
			"vue_ls", -- Vue/Nuxt
			"tailwindcss", -- Tailwind CSS
			"eslint", -- ESLint
			"jsonls",

			-- Python
			"pyright",

			-- Web
			"html",
			"cssls",

			"lua_ls",
		},
	},
}
