-- plugins/conform.lua
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- 저장 시 자동 포맷
  cmd = { "ConformInfo" },
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
  opts = {
    formatters = {
      prettier = {
        prepend_args = { "--tab-width", "2" },
      },
      stylua = {
        prepend_args = { "--indent-width", "2", "--indent-type", "Spaces" },
      },
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
      lsp_format = "fallback",
    },
  },
}
