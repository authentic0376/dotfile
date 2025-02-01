return {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>tf', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>tg', builtin.live_grep, { desc = 'Telescope live grep' })
        
        -- 디렉토리 검색
        vim.api.nvim_set_keymap('n', '<leader>td', '', {
            noremap = true,
            silent = true,
            callback = function()
                builtin.find_files {
                    find_command = { "fd", "--type", "d", "--hidden", "--no-ignore"}
                }
            end
        })

        -- 파일, 디렉토리 검색
        vim.api.nvim_set_keymap('n', '<leader>tt', '', {
            noremap = true,
            silent = true,
            callback = function()
                builtin.find_files {
                    find_command = { "fd", "--type", "f", "--type", "d", "--hidden", "--no-ignore"}
                }
            end
        })
    end
}
