return {
  -- 1. Treesitter: 코드 구문 분석 엔진 (변경 없음)
  -- 기존의 것들은 regex라 부정확한데, 더 강력한 인식을 가능하게 함
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "json",
        "markdown",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- 2. Mason: LSP 서버, 포맷터, 린터 설치 및 관리 도구 (변경 없음)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        border = "rounded",
      },
      ensure_installed = {
        -- Lua
        "stylua",
        "lua-language-server",
        -- Web
        "prettier",
        "typescript-language-server",
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "tailwindcss-language-server",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },

  -- 3. LSP-Config: LSP 서버 설정 (mason-lspconfig를 사용하여 자동화)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim", -- mason-lspconfig.nvim 추가
    },
    config = function()
      -- nvim-cmp를 사용하지 않으므로, 기본 capabilities를 가져옵니다.
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- 모든 LSP 서버에 공통으로 적용할 on_attach 함수
      local on_attach = function(client, bufnr)
        -- LSP가 포맷팅을 담당하지 않도록 설정 (Conform이 담당)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = bufnr, desc = "LSP: " .. desc })
        end

        -- 주요 LSP 기능 키맵 (기존과 동일)
        map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        map("n", "gr", vim.lsp.buf.references, "Go to References")
        map("n", "gI", vim.lsp.buf.implementation, "Go to Implementation")
        map("n", "<leader>D", vim.lsp.buf.type_definition, "Go to Type Definition")
        map("n", "<leader>ds", vim.diagnostic.open_float, "Show Line Diagnostics")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
      end

      -- mason-lspconfig를 사용하여 mason에 설치된 서버들을 자동으로 설정합니다.
      require("mason-lspconfig").setup({
        -- mason.nvim의 ensure_installed를 통해 설치하므로 여기서는 비워둡니다.
        ensure_installed = {},
        -- 기본 핸들러: 모든 서버에 대해 lspconfig.setup을 공통 설정으로 호출
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
              on_attach = on_attach,
            })
          end,
          -- 특정 서버(예: lua_ls)에만 다른 설정을 적용하고 싶다면 아래처럼 추가합니다.
          -- ["lua_ls"] = function()
          --   require("lspconfig").lua_ls.setup({ ... custom settings ... })
          -- end,
        },
      })
    end,
  },

  -- 4. Conform: 코드 포맷팅 도구 (변경 없음)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      formatters = {
        prettier = { prepend_args = { "--tab-width", "2" } },
        stylua = { prepend_args = { "--indent-width", "2", "--indent-type", "Spaces" } },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        markdown = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer or selection",
      },
    },
  },
}
