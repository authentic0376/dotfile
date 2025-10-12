vim.opt.number = true -- 현재 줄은 절대 라인 번호
vim.opt.relativenumber = true -- 나머지 줄은 상대 라인 번호

-- Insert 모드에서는 절대 숫자 사용하기
vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	command = "set norelativenumber",
})

vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set relativenumber",
})

-- 탭 문자(\t) 하나가 차지하는 화면상의 너비를 2칸으로 설정합니다. 즉, 탭이 2칸처럼 보이게 만듭니다.
vim.opt.tabstop = 2

-- 자동 들여쓰기나 > (들여쓰기), < (내어쓰기) 명령을 사용할 때 적용될 들여쓰기의 너비를 2칸으로 설정합니다.
vim.opt.shiftwidth = 2

-- 탭 문자를 공백으로 변환하는 설정입니다. 이 설정을 켜면 탭 키를 눌렀을 때 실제 탭 문자(\t)가 입력되는 대신, shiftwidth에 설정된 값만큼의 공백 문자가 대신 입력됩니다.
vim.opt.expandtab = true
