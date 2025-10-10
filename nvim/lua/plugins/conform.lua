-- 코드를 예쁘게 정리해주는 포맷팅 플러그인
return {
  'stevearc/conform.nvim',
  event = 'VeryLazy', -- 파일 저장이나 특정 이벤트 발생 시에만 로드
  opts = {
    -- 1. 파일 타입별로 어떤 포맷터를 사용할지 지정합니다.
    --    하나의 파일 타입에 여러 포맷터를 지정할 수도 있습니다.
    formatters_by_ft = {
      lua = { 'stylua' },

      -- javascript, typescript 등은 prettier를 사용
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      vue = { 'prettier' },
      css = { 'prettier' },
      scss = { 'prettier' },
      html = { 'prettier' },
      json = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      -- python = { 'isort', 'black' }, -- 예시: 파이썬은 isort -> black 순으로 실행
    },

    -- 2. "전역 포맷터 설정" 입니다.
    --    프로젝트에 .prettierrc 같은 설정 파일이 없을 경우, 아래 설정을 기본값으로 따릅니다.
    --    (만약 프로젝트에 .prettierrc 파일이 있다면, 그 파일이 우선 적용됩니다.)
    formatters = {
      prettier = {
        -- Prettier CLI에 전달할 인자(arguments)를 설정합니다.
        -- nvim-lint와 같은 다른 플러그인과 공유하기 위해 prepend_args 대신 args를 사용하면 좋습니다.
        args = {
          ['--tab-width'] = '2', -- 탭 너비 2칸
          ['--single-quote'] = 'false', -- 더블 쿼터(") 사용
          ['--semi'] = 'true', -- 세미콜론 사용
          ['--print-width'] = '120', -- 한 줄의 최대 길이
        },
      },
      stylua = {
        -- stylua의 전역 설정도 가능합니다.
        args = {
          ['--column-width'] = '120',
          ['--indent-type'] = 'Spaces',
          ['--indent-width'] = '2',
        },
      },
    },

    -- 3. 파일을 저장할 때 자동으로 포맷팅을 실행할지 여부
    --    이 기능을 원하지 않으면 이 부분을 주석 처리하거나 삭제하세요.
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },

  -- 4. 단축키 설정 부분
  keys = {
    {
      -- Normal 모드에서 <leader>f 를 누르면 포맷팅 실행
      '<leader>f',
      function()
        -- 포맷팅을 실행하고, 완료되면 메시지를 띄웁니다.
        require('conform').format({ async = true, lsp_fallback = true })
        vim.notify('✨ Formatted buffer!', vim.log.levels.INFO, { title = 'Conform' })
      end,
      mode = 'n',
      desc = '[F]ormat Buffer',
    },
  },
}
