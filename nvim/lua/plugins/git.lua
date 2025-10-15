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
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<M-5>5", "<Cmd>DiffviewOpen<CR>", desc = "Diffview Open" },
      { "<M-5>f", "<Cmd>DiffviewFileHistory<CR>", desc = "Diffview File History" },
    },
  },
}
