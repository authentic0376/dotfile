return {
	-- Mason: LSP/DAP/Linter/Formatter 설치 관리자
	{
		"mason-org/mason.nvim",
		opts = {},
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
			},
			auto_update = true,
			run_on_start = true,
		},
	},

	-- Mason-NSPConfig: Mason과 LSP 연결
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		lazy = false,
		opts = {
			auto_install = true,
			ensure_installed = {
				-- JavaScript/TypeScript
				"vtsls", -- vue 공식, ts,js. vue_ls 를 플러그인으로 사용
				"vue_ls", -- Vue/Nuxt
				"tailwindcss", -- Tailwind CSS
				"eslint", -- ESLint
				"jsonls",

				-- Python
				"pyright",

				-- Web
				"html",
				"cssls",

				"lua_ls",
			},
		},
	},

	-- LSPConfig: LSP 서버 설정
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		lazy = false,
		config = function()
			-- =================================================================
			-- 1. MiniCompletion이 LSP의 모든 기능을 사용하도록 capabilities 설정
			-- =================================================================
			-- 이 한 줄로 mini.completion이 필요한 모든 capability를 설정합니다.
			local capabilities = require("mini.completion").get_lsp_capabilities()

			-- =================================================================
			-- 2. 공통 설정 (모든 서버에 적용)
			-- =================================================================
			vim.lsp.config("*", {
				capabilities = capabilities,
				root_markers = { ".git", "package.json", "nuxt.config.ts", "pyproject.toml", "tsconfig.json" },
			})

			vim.lsp.config("eslint", {
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
			})

			local vue_language_server_path = vim.fn.expand("$MASON/packages/vue-language-server")
				.. "/node_modules/@vue/language-server"

			local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
			local vue_plugin = {
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
				configNamespace = "typescript",
			}
			local vtsls_config = {
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								vue_plugin,
							},
						},
					},
				},
				filetypes = tsserver_filetypes,
			}
			vim.lsp.config("vtsls", vtsls_config)
			vim.lsp.config("vue_ls", {})

			vim.lsp.config("pyright", {})

			vim.lsp.config("html", {
				filetypes = { "html" },
			})

			vim.lsp.config("cssls", {})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
			vim.lsp.config("jsonls", {})

			vim.lsp.enable({ "vtsls", "vue_ls", "eslint", "pyright", "html", "cssls", "lua_ls", "jsonls" })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- LSP 기본 키맵 (Neovim 0.11+ 자동 설정)
					-- gd (정의), gr (참조), K (hover), <C-]> (signature) 등 자동 제공
					-- mini.completion을 이 버퍼의 omnifunc로 설정 (공식 문서 권장 방식)
					vim.bo[ev.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"

					-- 기타 키맵 설정
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
					end

					map("grd", vim.diagnostic.open_float, "Line Diagnostics")
					map("grs", function()
						vim.lsp.buf.workspace_symbol(vim.fn.expand("<cword>"))
					end, "Workspace Symbols (Current Word)")
				end,
			})
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
				python = { "black" },
			},
			-- 저장시 자동 포맷 (LSP fallback 제거 - Conform만 사용)
			format_on_save = function(bufnr)
				-- ESLint가 있으면 ESLint로, 아니면 Conform으로 포맷
				if
					vim.tbl_contains(vim.lsp.get_clients({ bufnr = bufnr }), function(client)
						return client.name == "eslint"
					end)
				then
					return { lsp_format = "first", timeout_ms = 1000 }
				else
					-- eslint가 없으면, lsp format은 건너 뛰고 conform이 포멧
					-- timeout 은 실제로 중용하다. 짧으면 실패한다
					return { timeout_ms = 1000 }
				end
			end,
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
