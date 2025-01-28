-- wrap 토글 기능 추가
vim.api.nvim_set_keymap('n', '<leader>nw', ':lua vim.o.wrap = not vim.o.wrap<CR>', { noremap = true, silent = true })

-- 키맵 열기
vim.api.nvim_set_keymap('n', '<leader>vk', ':e ~/AppData/Local/nvim/lua/config/keymap.lua<CR>', { noremap = true, silent = true })

