return {
  "rmagatti/auto-session",
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    auto_create = false, -- ⭐️ 가장 중요한 설정: 자동 생성 비활성화
    -- allowed_dirs = { "~/workspace" },
    -- log_level = "debug",
  },
  keys = {
    { "<M-2>s", "<Cmd>AutoSession search<CR>", desc = "Session to start" },
    { "<M-2>S", "<Cmd>AutoSession deletePicker<CR>", desc = "Session to delete" },
  },
}
