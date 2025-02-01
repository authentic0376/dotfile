return  {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},

	config = function()
		-- `:Neotree`를 `:nt`로 사용할 수 있도록 별칭 생성
		vim.api.nvim_create_user_command("Nt", function(opts)
			vim.cmd("Neotree " .. opts.args)
		end, { nargs = "*" }) -- "*"로 모든 인자 허용

		-- Neotree 단축키 설정 (필요 없는 경우 삭제 가능)
		vim.api.nvim_set_keymap('n', '<leader>nn', ':Neotree filesystem reveal dir=~/AppData/Local/nvim/lua<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<leader>nc', ':Neotree reveal<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<leader>nf', ':Neotree focus<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<leader>nt', ':Neotree toggle<CR>', { noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<leader>nb', ':Neotree buffers<CR>', { noremap = true, silent = true })
	end
}
