return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
    "nvim-mini/mini.pick", -- optional
  },
  opts = {
    log_view = { kind = "vsplit" },
  },
}
