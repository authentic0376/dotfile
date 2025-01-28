return {
	'preservim/nerdtree',

	config = function()
		-- EasyMotion 단축키 설정
		vim.api.nvim_set_keymap('n', '<leader>nn', ':NERDTree<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<leader>nf', ':NERDTreeFocus<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<leader>nt', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<leader>nc', ':NERDTreeFind<CR>', { noremap = true, silent = true })
	end

}
