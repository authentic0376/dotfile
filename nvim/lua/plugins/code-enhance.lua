return {
  -- Mason: LSP/DAP/Linter/Formatter 설치 관리자
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Mason Tool Installer: 포맷터/린터 자동 설치
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        -- Formatters
        "prettier",
        "stylua",
        "black",
        "isort",
        "google-java-format",
        "shfmt",
      },
      auto_update = false,
      run_on_start = true,
    },
  },

  -- Mason-LSPConfig: Mason과 LSP 연결
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        -- JavaScript/TypeScript
        "ts_ls", -- TypeScript
        "vue_ls", -- Vue/Nuxt (Volar)
        "tailwindcss", -- Tailwind CSS
        "eslint", -- ESLint

        -- Python
        "pyright",

        -- Java
        "jdtls",

        -- Web
        "html",
        "cssls",
        "jsonls",

        -- Config files
        "yamlls",
        "lua_ls",
        "dockerls",
        "docker_compose_language_service",
      },
      automatic_enable = true, -- 설치된 서버 자동 활성화
    },
  },

  -- LSPConfig: LSP 서버 설정
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      -- LSP 기본 키맵 (Neovim 0.11+ 자동 설정)
      -- gd (정의), gr (참조), K (hover), <C-]> (signature) 등 자동 제공
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf

          -- 추가 LSP 키맵
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Declaration" })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
          vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
          vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { buffer = bufnr, desc = "Line Diagnostics" })
        end,
      })

      -- 진단 설정
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = true,
        },
      })

      -- 진단 기호
      local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- 개별 서버 설정
      local lspconfig = require("lspconfig")

      -- TypeScript/JavaScript
      vim.lsp.enable("ts_ls")

      -- Vue/Nuxt (Volar) - Vue Language Server
      -- Volar 2.0+ (volar가 아닌 vue_language_server 또는 volar로 설치됨)
      vim.lsp.config("vue_ls", {
        filetypes = { "vue" },
        init_options = {
          vue = {
            hybridMode = false,
          },
          typescript = {
            tsdk = vim.fn.expand("~/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib"),
          },
        },
      })
      vim.lsp.enable("vue_ls")

      -- TypeScript를 Vue 파일에서도 사용 (Volar Takeover Mode)
      vim.lsp.config("ts_ls", {
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vim.fn.expand(
                "~/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server"
              ),
              languages = { "vue" },
            },
          },
        },
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      })

      -- Tailwind CSS
      vim.lsp.config("tailwindcss", {
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
              },
            },
          },
        },
      })
      vim.lsp.enable("tailwindcss")

      -- ESLint
      vim.lsp.config("eslint", {
        settings = {
          workingDirectories = { mode = "auto" },
          format = false, -- Conform이 처리
        },
        on_attach = function(client, bufnr)
          -- ESLint autofix on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })
      vim.lsp.enable("eslint")

      -- Python
      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })
      vim.lsp.enable("pyright")

      -- Java (JDTLS는 특수하므로 기본 설정만)
      vim.lsp.enable("jdtls")

      -- HTML
      vim.lsp.config("html", {
        filetypes = { "html", "vue" },
      })
      vim.lsp.enable("html")

      -- CSS
      vim.lsp.enable("cssls")

      -- JSON
      vim.lsp.config("jsonls", {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })
      vim.lsp.enable("jsonls")

      -- YAML
      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            schemas = require("schemastore").yaml.schemas(),
            schemaStore = {
              enable = false,
              url = "",
            },
          },
        },
      })
      vim.lsp.enable("yamlls")

      -- Lua
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      -- Docker
      vim.lsp.enable("dockerls")
      vim.lsp.enable("docker_compose_language_service")
    end,
  },

  -- JSON/YAML 스키마 지원
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  -- Conform: 포맷팅 (통합 포맷터)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
        java = { "google-java-format" },
        sh = { "shfmt" },
        dockerfile = { "prettier" },
      },
      -- 저장시 자동 포맷 (LSP fallback 제거 - Conform만 사용)
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "never", -- LSP 포맷 비활성화, Conform만 사용
      },
      formatters = {
        prettier = {
          -- Tailwind 플러그인이 프로젝트에 설치되어 있으면 자동으로 사용
          -- 없으면 무시됨 (에러 안남)
          prepend_args = function()
            -- node_modules에 tailwind 플러그인이 있는지 확인
            local has_tailwind_plugin = vim.fn.filereadable(
              vim.fn.getcwd() .. "/node_modules/prettier-plugin-tailwindcss/dist/index.mjs"
            ) == 1

            if has_tailwind_plugin then
              return { "--plugin=prettier-plugin-tailwindcss" }
            end
            return {}
          end,
        },
        stylua = {
          prepend_args = {
            "--indent-type",
            "Spaces",
            "--indent-width",
            "2",
            "--quote-style",
            "AutoPreferDouble",
          },
        },
      },
    },
    init = function()
      -- Conform을 기본 포맷 엔진으로 설정
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

      -- 수동 포맷 키맵 (mini.files와 충돌 방지)
      vim.keymap.set({ "n", "v" }, "<leader>cf", function()
        require("conform").format({ async = true })
      end, { desc = "Format" })
    end,
  },

  -- Treesitter: 구문 하이라이팅
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "vue",
        "python",
        "java",
        "lua",
        "vim",
        "vimdoc",
        "html",
        "css",
        "scss",
        "json",
        "jsonc",
        "yaml",
        "toml",
        "bash",
        "dockerfile",
        "gitignore",
        "markdown",
        "markdown_inline",
        "regex",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      -- mini.ai가 이미 textobject 제공하므로 간단하게만 설정
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = false,
          node_incremental = "v",
          scope_incremental = false,
          node_decremental = "V",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- mini.ai와 충돌하지 않는 키맵 사용
            ["aF"] = "@function.outer",
            ["iF"] = "@function.inner",
            ["aC"] = "@class.outer",
            ["iC"] = "@class.inner",
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- Treesitter 기반 폴딩
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo.foldenable = false -- 시작시 접기 비활성화
    end,
  },

  -- Treesitter Textobjects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
  },
}
