-- myththeme.lua
-- mini.base16으로 만든 신화적인 느낌의 Neovim 테마
-- 이 파일을 '.../nvim/colors/' 디렉토리에 위치시키세요.

-- 리로드 시 오류 방지를 위한 Neovim 색상 테마 표준 코드
vim.cmd("hi clear")
if vim.g.colors_name then
  vim.cmd("hi clear")
end

-- 색상 테마의 이름을 설정합니다.
vim.g.colors_name = "myththeme"

-- 1. 테마의 핵심 색상을 정의합니다.
-- 일관되고 균형 잡힌 테마를 위해 mini_palette() 생성기를 사용합니다.
-- 배경색으로는 어둡고 신비로운 보라-파랑색을, 전경색으로는 따뜻하고
-- 빛나는 아이보리/금색을 선택합니다.
local background = "#28243D" -- 깊고 어두운 황혼의 보라색
local foreground = "#F3EAD3" -- 따뜻한 고서(古書) 느낌의 아이보리색
local accent_chroma = 60 -- 생생하지만 눈에 거슬리지 않는 강조색을 위한 중간-높음 채도

-- 2. 핵심 색상을 사용하여 전체 16색 팔레트를 생성합니다.
-- 이 함수는 mini.base16에서 제공하며, 테마 생성을 매우 빠르게 해줍니다.
local palette = require("mini.base16").mini_palette(background, foreground, accent_chroma)

-- 3. 생성된 팔레트를 적용합니다.
-- 이 함수가 모든 하이라이트 그룹을 생성하는 메인 함수입니다.
require("mini.base16").setup({
  -- 방금 생성한 팔레트입니다. 이 필드는 필수 항목입니다.
  palette = palette,

  -- 트루 컬러(true color)를 지원하지 않는 터미널을 위해 cterm 색상을 활성화합니다.
  -- mini.base16이 자동으로 가장 가까운 256색으로 근사치를 찾아줍니다.
  use_cterm = true,

  -- 기본 플러그인 연동 설정을 사용하여, 문서에 명시된
  -- 모든 지원 플러그인의 하이라이팅을 활성화합니다.
  -- plugins = { default = true }, -- 이 값이 기본값이므로 생략할 수 있습니다.
})

-- myththeme.lua 파일의 맨 아래에 추가하세요.

-- mini.diff 오버레이 하이라이트 커스터마이징
-- 아래 색상 코드를 원하는 값으로 변경해서 사용하세요.

-- 추가된 라인 (연한 녹색 배경)
vim.api.nvim_set_hl(0, "MiniDiffOverAdd", { bg = "#2A402E" })

-- 변경된 라인 (연한 노란색 배경)
vim.api.nvim_set_hl(0, "MiniDiffOverChange", { bg = "#50412E" })

-- 삭제된 라인 (연한 붉은색 배경)
vim.api.nvim_set_hl(0, "MiniDiffOverDelete", { bg = "#4D2A2E" })
