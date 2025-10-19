vim.keymap.set("n", "Q", "@q", { desc = "play macro q" })

-- <C-/>를 눌러서 검색 하이라이트 기능을 껐다 켰다(토글)합니다.
vim.keymap.set("n", "<M-/>", "<Cmd>nohlsearch | redraw!<CR>", {
	desc = "검색 하이라이트 토글",
	-- silent = true,
})

-- 블랙홀 레지스터
vim.keymap.set("x", "<leader>p", '"0p', { desc = "Pasted keeping register" })

-- 찾아 바꾸기, *N 으로 검색 상태가 되고 해야한다
vim.keymap.set("n", "<Leader>r", ":%s///gc<Left><Left><Left>", { desc = "Global Substitute" })
