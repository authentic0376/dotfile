return {
	on_attach = function(_, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.cmd("EslintFixAll")
			end,
		})
	end,
	settings = {
		workspaceFolder = {
			uri = vim.uri_from_fname(vim.fn.getcwd()),
			name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
		},
	},
}
