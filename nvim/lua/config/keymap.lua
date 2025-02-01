-- wrap 토글 기능 추가
vim.api.nvim_set_keymap('n', '<leader>vw', ':lua vim.o.wrap = not vim.o.wrap<CR>', { noremap = true, silent = true })

-- lua 디렉토리로 이동
vim.api.nvim_set_keymap('n', '<leader>vv', ':NERDTree ~/AppData/Local/nvim<CR>', { noremap = true, silent = true })

-- buffer
-- -- delete except current
vim.api.nvim_set_keymap('n', '<leader>ba', ':%bd|e#<CR>', { noremap = true, silent = true })
-- -- delete unchaged
vim.api.nvim_set_keymap('n', '<leader>bu', ':bufdo if !&modified | bd | endif<CR>', { noremap = true, silent = true })
-- -- switch to prev, next buffer
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Tab>', ':bn<CR>', { noremap = true, silent = true })


