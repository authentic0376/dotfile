return {
    'neovim/nvim-lspconfig',
    config = function()
      -- JavaScript LSP 설정 (tsserver)
      require'lspconfig'.ts_ls.setup{}
      
      -- Python LSP 설정 (pyright)
      require'lspconfig'.pyright.setup{}
      
      -- CSS LSP 설정 (cssls)
      require'lspconfig'.cssls.setup{}
      
      -- HTML LSP 설정 (html)
      require'lspconfig'.html.setup{}
      
      -- Java LSP 설정 (jdtls)
      require'lspconfig'.jdtls.setup{}
    end
  }
