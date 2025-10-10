vim.opt.number = true        -- 현재 줄은 절대 라인 번호
vim.opt.relativenumber = true -- 나머지 줄은 상대 라인 번호

-- Insert 모드에서는 절대 숫자 사용하기
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  command = "set norelativenumber"
})

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set relativenumber"
})

vim.opt.shiftwidth = 2
