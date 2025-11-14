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
	-- root_markers 로는 설정이 부족해서 root_dir로 설정
	-- diffview.nvim 을 쓸 경우, file://./ 같은 임시 파일 경로인데
	-- 이때 경로 인식을 잘 못해서, 루트를 못찾고 매우 많은 파일을
	-- 스캔하게 돼서 느려짐. 그걸 방지하기 위한 설정
	root_dir = function(bufnr, on_dir)
		local bufname = vim.fn.bufname(bufnr)

		-- 버퍼 이름이 비어있거나 특수 버퍼면 LSP 비활성화
		if bufname == "" or bufname:match("^%w+://") then
			return
		end

		local filepath = vim.fn.fnamemodify(bufname, ":p")
		local dir = vim.fn.fnamemodify(filepath, ":h")

		-- 홈 디렉토리나 루트 디렉토리는 제외
		local home = vim.fn.expand("~")
		if dir == home or dir == "/" then
			return
		end

		-- 프로젝트 루트 마커들
		local root_markers = {
			".git",
			"package.json",
			"pyproject.toml",
		}

		-- 현재 디렉토리부터 상위로 올라가며 프로젝트 루트 찾기
		local current = dir
		while current ~= "/" do
			for _, marker in ipairs(root_markers) do
				if
					vim.fn.filereadable(current .. "/" .. marker) == 1
					or vim.fn.isdirectory(current .. "/" .. marker) == 1
				then
					on_dir(current)
					return
				end
			end
			current = vim.fn.fnamemodify(current, ":h")
		end

		-- 프로젝트 루트를 찾지 못한 경우, 파일이 있는 디렉토리 사용
		on_dir(dir)
	end,
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
