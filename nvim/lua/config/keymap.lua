vim.keymap.set("n", "Q", "@q", { desc = "play macro q" })

-- <C-/>를 눌러서 검색 하이라이트 기능을 껐다 켰다(토글)합니다.
vim.keymap.set("n", "<M-/>", "<Cmd>nohlsearch | redraw!<CR>", {
	desc = "검색 하이라이트 토글",
	-- silent = true,
})

-- 블랙홀 레지스터
vim.keymap.set({ "n", "x" }, "<leader>p", '"0p', { desc = "Pasted keeping register" })

-- 찾아 바꾸기, *N 으로 검색 상태가 되고 해야한다
vim.keymap.set("n", "<Leader>r", ":%s///gc<Left><Left><Left>", { desc = "찾아 바꾸기" })

-- 커서 위치에서 lang(snippet 불러오는 기준) 체크
vim.keymap.set("n", "grl", function()
	-- MiniSnippets에서 현재 컨텍스트를 가져옵니다.
	local context = select(2, MiniSnippets.default_prepare({}))

	if context and context.lang then
		-- 성공: INFO 레벨로 현재 언어를 알림
		vim.notify("Current lang: " .. context.lang, vim.log.levels.INFO, {
			title = "Snippets 'lang'",
		})
	else
		-- 실패: WARN 레벨로 알림
		vim.notify("Could not determine lang.", vim.log.levels.WARN, {
			title = "Snippets 'lang'",
		})
	end
end, { desc = "Get Runtime 'lang' at cursor (Notify)" })
