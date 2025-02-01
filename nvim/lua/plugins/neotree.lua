return  {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },

	config = function()
		-- EasyMotion 단축키 설정
		vim.api.nvim_set_keymap('n', '<leader>nn', ':Neotree filesystem reveal dir=~/AppData/Local/nvim/lua<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<leader>nc', ':Neotree reveal<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<leader>nf', ':Neotree focus<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<leader>nt', ':Neotree toggle<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<leader>nb', ':Neotree buffers<CR>', { noremap = true, silent = true })
	end
}
