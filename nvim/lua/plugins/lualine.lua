return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      globalstatus = true,
    },
    sections = {
      lualine_c = { -- 활성창 winbar 중앙에 파일명 표시
        {
          "filename",
          path = 1, -- 0: 파일명만, 1: 상대 경로, 2: 절대 경로, 3: ~ 포함 절대 경로
        },
      },
    },
    winbar = {
      lualine_c = { -- 활성창 winbar 중앙에 파일명 표시

        "filename",
      },
    },
    inactive_winbar = {
      lualine_c = { "filename" }, -- 비활성창 winbar 중앙에 파일명 표시
    },
  },
}
