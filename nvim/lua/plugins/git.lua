return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "nvim-mini/mini.pick", -- optional
    },
    opts = {
      log_view = { kind = "vsplit" },
    },
    keys = {
      { "<M-3>g", "<Cmd>Neogit<CR>", desc = "Neogit" },
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<M-3>d", "<Cmd>DiffviewOpen<CR>", desc = "Diffview Open" },
      { "<M-3>f", "<Cmd>DiffviewFileHistory<CR>", desc = "Diffview File History" },
    },
  },
}
