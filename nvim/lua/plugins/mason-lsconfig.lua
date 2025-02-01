return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = { "lua_ls", "ts_ls", "cssls", "html", "jdtls", "lemminx", "pyright" },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- 각 언어별 LSP 추가 설정
      require("lspconfig").lua_ls.setup({})
      require("lspconfig").ts_ls.setup({})
      require("lspconfig").pyright.setup({})
      require("lspconfig").cssls.setup({})
      require("lspconfig").html.setup({})
      require("lspconfig").jdtls.setup({})
      require("lspconfig").lemminx.setup({})

      vim.api.nvim_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
    end,
  },
}
