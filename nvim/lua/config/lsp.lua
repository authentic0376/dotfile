-- =================================================================
-- 1. MiniCompletion이 LSP의 모든 기능을 사용하도록 capabilities 설정
-- =================================================================
-- 이 한 줄로 mini.completion이 필요한 모든 capability를 설정합니다.
local capabilities = require("mini.completion").get_lsp_capabilities()

-- basedpyright은utf-16만 지원하는데 ruff 랑 encoding이 달라서
-- 둘다 utf-16 으로 통일 이건 위치인코딩이고, 보통 말하는 건
-- 파일인코딩이다 서로 상관 없다
--
-- capabilities.general.positionEncodings = 이런식으로 하면
-- general 필드가 없을 경우 에러가 나므로 tbl_deep_extend을 쓴다
capabilities = vim.tbl_deep_extend("force", capabilities, {
	general = {
		positionEncodings = { "utf-16" },
	},
})

-- =================================================================
-- 2. 공통 설정 (모든 서버에 적용)
-- =================================================================
vim.lsp.config("*", {
	capabilities = capabilities,
	root_markers = {
		".git",
		"package.json",
		"nuxt.config.ts",
		"pyproject.toml",
		"tsconfig.json",
		"lazy-lock.json",
	},
})

-- lsp 서버가 버퍼에 적용되는 순간
-- 그 버퍼에 로컬로 키맵을 설정하는 설정
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- LSP 기본 키맵 (Neovim 0.11+ 자동 설정)
		-- gd (정의), gr (참조), K (hover), <C-]> (signature) 등 자동 제공
		-- mini.completion을 이 버퍼의 omnifunc로 설정 (공식 문서 권장 방식)
		vim.bo[ev.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"

		-- 기타 키맵 설정
		local map = function(keys, func, desc)
			-- 버퍼 로컬 키맵이다. 이 버퍼에서만 작동한다
			vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
		end

		map("grd", vim.diagnostic.open_float, "Line Diagnostics")
		map("grs", function()
			vim.lsp.buf.workspace_symbol(vim.fn.expand("<cword>"))
		end, "Workspace Symbols (Current Word)")
		map("grk", "<Cmd>LspRestart<CR>", "Lsp Restart")
	end,
})
