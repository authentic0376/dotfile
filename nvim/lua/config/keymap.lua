vim.keymap.set("n", "Q", "@q", { desc = "play macro q" })

-- <C-/>를 눌러서 검색 하이라이트 기능을 껐다 켰다(토글)합니다.
vim.keymap.set("n", "<M-/>", "<Cmd>nohlsearch | redraw!<CR>", {
  desc = "검색 하이라이트 토글",
  -- silent = true,
})
