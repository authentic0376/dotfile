return {
  "akinsho/bufferline.nvim",
  version = "*", -- 안정성을 위해 특정 태그(예: "v4.9.1")를 사용할 수도 있습니다.
  dependencies = "nvim-tree/nvim-web-devicons", -- 아이콘 표시를 위한 의존성 플러그인
  config = function()
    -- 설정 전 termguicolors 활성화는 필수입니다.
    vim.opt.termguicolors = true

    require("bufferline").setup({
      options = {},
    })

    -- 단축키 설정
    -- 다음 버퍼로 이동
    vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "다음 버퍼로 이동" })
    -- 이전 버퍼로 이동
    vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "이전 버퍼로 이동" })
    -- 버퍼 닫기
    vim.keymap.set("n", "<leader>bd", "<Cmd>bdelete<CR>", { desc = "버퍼 닫기" })
    -- 버퍼 선택 (Fuzzy-finder와 유사)
    vim.keymap.set("n", "<leader>bs", "<Cmd>BufferLinePick<CR>", { desc = "버퍼 선택" })
    -- 오른쪽 버퍼 모두 닫기
    vim.keymap.set("n", "<leader>bcr", "<Cmd>BufferLineCloseRight<CR>", { desc = "오른쪽 버퍼 모두 닫기" })
    -- 왼쪽 버퍼 모두 닫기
    vim.keymap.set("n", "<leader>bcl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "왼쪽 버퍼 모두 닫기" })
  end,
}
