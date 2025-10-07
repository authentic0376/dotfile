return {
  {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
      -- 이 안에 사용하고 싶은 mini 모듈들의 setup 코드를 넣습니다.
      require('mini.surround').setup()
      require('mini.jump2d').setup()
      require('mini.pairs').setup()
      require('mini.move').setup()
      require('mini.comment').setup()
    end,
  },
}
