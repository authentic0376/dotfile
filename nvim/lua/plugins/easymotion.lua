
return {
  -- EasyMotion 플러그인 설정
  {
    'easymotion/vim-easymotion',
    config = function()
      -- EasyMotion 단축키 설정
      vim.api.nvim_set_keymap('n', '<leader>w', '<Plug>(easymotion-bd-w)', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>s', '<Plug>(easymotion-s)', { noremap = true, silent = true })
    end
  }
}
