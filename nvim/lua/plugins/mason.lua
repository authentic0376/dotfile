-- 포맷터, 린터 등 외부 도구를 관리하는 플러그인
return {
  'williamboman/mason.nvim',
  lazy = false, -- Neovim 시작 시 항상 실행
  config = function()
    require('mason').setup({
      ui = {
        border = 'rounded',
      },
      -- 여기에 설치하고 싶은 LSP, 포맷터, 린터 등을 적어두면
      -- Neovim 시작 시 자동으로 설치해줍니다.
      ensure_installed = {
        -- Lua 포맷터
        'stylua',

        -- 웹 개발용 포맷터
        'prettier',

        -- 추가로 필요한 도구들을 여기에 계속 추가...
        -- 'eslint_d',
        -- 'gopls',
      },
    })
  end,
}
