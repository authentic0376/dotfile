
---------------------
-- 터미널 타이틀 설정
local function update_terminal_title()
	local session_name

	-- auto-session의 현재 세션 이름 가져오기 시도
	local ok, auto_session = pcall(require, "auto-session.lib")
	if ok then
		session_name = auto_session.current_session_name(true)
	end

	-- 세션이 없으면 현재 디렉토리 이름으로 폴백
	if not session_name or session_name == "" then
		session_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	end

	vim.opt.titlestring = session_name
	vim.opt.title = true
end

-- nvim 시작 시
vim.opt.title = true
update_terminal_title()

-- 디렉토리 변경 시
vim.api.nvim_create_autocmd("DirChanged", {
	pattern = "*",
	callback = update_terminal_title,
})

-- 세션 복구 후 (auto-session 사용 시)
vim.api.nvim_create_autocmd("SessionLoadPost", {
	pattern = "*",
	callback = update_terminal_title,
})
-- 터미널 타이틀 설정 끝
---------------------
