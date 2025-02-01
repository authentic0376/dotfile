return {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
		vim.api.nvim_set_keymap('n', '<leader>tf', ':Telescope find_files<CR>', { noremap = true, silent = true })
    end
}
