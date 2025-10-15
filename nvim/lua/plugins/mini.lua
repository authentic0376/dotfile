return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local map = vim.keymap.set
      ----------------------------------
      -- # mini.nvim 플러그인 설정
      ----------------------------------
      ----------------------------------
      -- ## text editing
      ----------------------------------
      ----------------------------------
      -- ### ai text-object 확장
      --
      -- ┌───┬───────────────┐
      -- │Key│     Name      │
      -- ├───┴───────────────┤
      -- ├┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┤
      -- │ ( │  Balanced ()  │
      -- │ [ │  Balanced []  │
      -- │ { │  Balanced {}  │
      -- │ < │  Balanced <>  │
      -- ├┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┤
      -- │ ) │  Balanced ()  │
      -- │ ] │  Balanced []  │
      -- │ } │  Balanced {}  │
      -- │ > │  Balanced <>  │
      -- │ b │  Alias for    │
      -- │   │  ), ], or }   │
      -- ├┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┤
      -- │ " │  Balanced "   │
      -- │ ' │  Balanced '   │
      -- │ ` │  Balanced `   │
      -- │ q │  Alias for    │
      -- │   │  ", ', or `   │
      -- ├┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┤
      -- │ ? │  User prompt  │
      -- │   │(typed e and o)│
      -- ├┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┤
      -- │ t │      Tag      │
      -- ├┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┤
      -- │ f │ Function call │
      -- ├┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┤
      -- │ a │   Argument    │
      -- ├┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┤
      -- │   │    Default    │
      -- │   │   (typed _)   │
      -- └───┴───────────────┘
      -- ?: 직접입력하는 obj. ? 시작문자<CR> 끝문자 <CR>
      -- g[ <obj> 다음 obj의 왼쪽 경계로 가기
      -- g] <obj> 다음 obj의 오른쪽 경계로 가기
      -- obj 변형접미사: n 다음, l 이전 (vanb = 다음 bracket 객체의 around 선택)
      -- ## 기능
      -- 커스텀 text-obj 생성 가능
      require("mini.ai").setup({
        custom_textobjects = {
          -- Whole buffer
          g = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line("$"),
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
          end,
        },
      })
      --
      -- ### ai end
      ----------------------------------

      -- gcc 로 줄 코멘팅, gc + text obj
      -- gc 라는 obj 생성
      require("mini.comment").setup()

      ----------------------------------
      -- ### completion
      --
      -- 자동완성
      -- <C-n> <C-p> 드롭다운 한칸씩 이동
      -- esc 나 아무 문자가 곧 선택이다. 효율적인 방식임
      --
      -- <C-space> LSP+fallback 자동완성 강제 실행
      -- <A-space> Fallback 자동완성 강제실행
      -- <C-f>/<C-b> 설명창 스크롤
      -- <C-y> 스니펫확장, 아무키 누르는 것도 똑같음
      -- <C-e> 스니펫말고 텍스트 자동완성
      require("mini.completion").setup()
      --
      -- ### completion end
      ----------------------------------

      -- 복잡한 키맵, 조건부 키맵. 같은 키인데 상황에 따라 다르게 작동
      require("mini.keymap").setup()

      -- alt j,k로 줄 옮기기
      require("mini.move").setup()

      -- 괄호, 따옴표 입력시 쌍으로 입력
      require("mini.pairs").setup()

      ----------------------------------
      -- ### snippets
      --
      -- <C-j> 스니펫 확장
      -- snippets 플러그인은 completion과 달리 먼저 선택하는 게 아니라
      -- 스니펫 문자(예를 들면, ! = html 스니펫)를 입력한 뒤
      -- 스니펫확장키를 누르면 스니펫이 작성된다 이걸 확장이라고 부른다
      -- 만약 그 문자에 해당하는 스니펫이 여러개면 snippets 전용 선택창이 나온다
      -- completion 과 순서가 반대인 것이다
      --
      -- <C-l> <C-h> 점프 포인트 이동
      -- <C-c> 스니펫 중단
      local gen_loader = require("mini.snippets").gen_loader
      require("mini.snippets").setup({
        -- 스니펫 로더 설정
        snippets = {
          -- 'runtimepath'에서 현재 언어에 맞는 스니펫 파일을 로드합니다.
          -- friendly-snippets가 이 경로에 파일을 설치하므로 자동으로 인식됩니다.
          -- friendly-snippets 은 상단에 mini.nvim 디펜던시에 있다
          gen_loader.from_lang(),
        },
      })
      -- 스니펫 LSP 서버를 시작하여 자동완성에 스니펫이 표시되도록 합니다.
      require("mini.snippets").start_lsp_server()
      --
      -- ### snippets end
      ----------------------------------

      -- gS 로 열었다 닫었다
      require("mini.splitjoin").setup()

      -- 괄호, 따옴표 추가, 수정 sa (add), sd (delete), sr (remove)
      require("mini.surround").setup()

      ----------------------------------
      -- ## general workflow
      ----------------------------------

      ----------------------------------
      -- ### basics
      --
      -- * **리더(Leader) 키**: `<Space>` 키가 리더 키로 설정됩니다.
      -- * **파일 타입**: 파일 종류에 맞는 플러그인과 들여쓰기가 활성화됩니다 (`:filetype plugin indent on`).
      -- * **백업 및 복구**: 변경 사항을 되돌릴 수 있도록 언두 파일(`undofile`)이 활성화됩니다.
      -- * **화면 표시**:
      --     * 줄 번호(`number`)와 현재 줄 강조(`cursorline`)가 켜집니다.
      --     * 창 분할 시 새로운 창이 오른쪽(`splitright`)과 아래쪽(`splitbelow`)에 생깁니다.
      --     * 터미널에서 트루 컬러(`termguicolors`)를 사용합니다.
      -- * **검색 및 편집**:
      --     * 검색 시 대소문자를 무시하되(`ignorecase`), 대문자가 포함되면 구분합니다(`smartcase`).
      --     * 검색어를 입력하는 동안 일치하는 항목을 바로 보여줍니다(`incsearch`).
      --     * go/gO 로 줄 삽입
      --
      -- * **이동**: `j`와 `k`를 눌렀을 때 실제 줄이 아닌 화면에 보이는 줄 단위로 커서가 이동합니다.
      -- * **저장**+S) 키로 파일을 저장할 수 있습니다.
      -- * **복사/붙여넣기**: `gy`로 시스템 클립보드에 복사하고, `gp`로 붙여넣을 수 있습니다.
      -- * **옵션 토글**: `\` 키를 조합하여 특정 옵션을 켜고 끌 수 있습니다.
      --     * `\n`: 줄 번호 (`number`) 토글
      --     * `\r`: 상대적 줄 번호 (`relativenumber`) 토글
      --     * `\w`: 자동 줄 바꿈 (`wrap`) 토글
      --     * `\s`: 맞춤법 검사 (`spell`) 토글
      --     * `\h`: 검색어 하이라이트 (`hlsearch`) 토글
      --
      -- * **터미널**: 터미널 창을 열면 바로 입력 모드로 시작됩니다.
      -- * **텍스트 복사(Yank)**: 텍스트를 복사하면 잠시 동안 해당 부분이 하이라이트되어 시각적으로 확인하기 편해집니다.
      --
      -- ### ⚠️ 기본으로 비활성화된 기능
      --
      -- 참고로 다음 기능들은 유용하지만, 개인 취향에 따라 설정할 수 있도록 기본적으로는 **비활성화**되어 있습니다.
      --
      -- * 추가적인 UI 기능 (`extra_ui`)
      -- * `<C-h/j/k/l>`을 이용한 창 간 이동 (`windows`)
      -- * `<M-h/j/k/l>` (Alt+hjkl)을 이용한 커서 이동 (`move_with_alt`)
      require("mini.basics").setup({
        mappings = {
          -- Window navigation with <C-hjkl>, resize with <C-arrow>
          windows = true,
          move_with_alt = true,
        },
      })
      --
      -- basics end
      ----------------------------------

      -- [,] 으로 왔다갔다, 대문자는 끝으로
      -- b 버퍼, c 주석, f 파일, i 들여쓰기, t treesitter
      -- x,d,jump,l,o,q,u,w,y
      require("mini.bracketed").setup()

      -- 버퍼 닫으면 윈도우도 같이 닫히면서 레이아웃이 무너지는데
      -- 빈 버퍼나, 다른 버퍼를 띄워주면서 레이아웃을 보존한다
      require("mini.bufremove").setup()

      ----------------------------------
      -- ### clue 단축키 힌트 팝업
      --
      -- 밑에 설정에서 miniclue 라는 변수를 여러곳에서 쓰기 때문에 선언해줘야 한다.
      local miniclue = require("mini.clue")
      require("mini.clue").setup({
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),

          -- LSP 키맵 그룹 힌트 추가
          { mode = "n", keys = "<leader>c", desc = "+Code" },
        },
      })
      --
      -- clue end
      ----------------------------------

      ----------------------------------
      -- ### diff
      --
      -- 실수인 수정을 막고, 되돌리는 용도가 가장 크다. 깃은 활용할 뿐 깃툴이라 생각말자
      -- gh 라는 git 변경점을 나타내는 text-obj 추가
      -- gh 는 text-obj 이기도 하지만, action이기도 하다
      -- gh 는 git add 같은 것
      -- gH 는 되돌리기
      -- ghgh 현재커서 변경점 적용
      -- gHgh 현재커서 되돌리기
      -- 영역선택 + gh/gH
      -- gH_ 한줄 되돌리기
      -- [,]h 변경점 이동, mini.bracketed와 같은 방식. 충돌 x
      --
      -- git은 index(staging area)가 변경의 기준점이다
      -- git add 를 하면 diff 가 사라진다
      -- git 이 아닌 경우, 저장이 기준이고, gh 명령어는 에러난다, GHgh는 가능
      require("mini.diff").setup({
        -- 만약 Git 파일에서는 기존처럼 Git과 비교하고,
        -- 그 외 파일에서만 저장 내용과 비교하고 싶다면 아래와 같이 배열로 설정
        source = {
          require("mini.diff").gen_source.git(),
          require("mini.diff").gen_source.save(),
        },
      })
      map("n", "<M-3>o", function()
        require("mini.diff").toggle_overlay()
      end, { desc = "[D]iff [O]verlay Toggle" })
      --
      -- diff end
      ----------------------------------

      -- mini 플러그인들에 추가기능을 준다
      -- :Pick {explorer, git_commits, git_hunks, diagnostic, ..등등 } 각종 picker 추가
      require("mini.extra").setup()

      ----------------------------------
      -- ### files
      --
      -- | Action      | Keys | Description                                    |
      -- |-------------|------|------------------------------------------------|
      -- | Close       |  q   | Close explorer                                 |
      -- |-------------|------|------------------------------------------------|
      -- | Go in       |  l   | Expand entry (show directory or open file)     |
      -- |-------------|------|------------------------------------------------|
      -- | Go in plus  |  L   | Expand entry plus extra action                 |
      -- |-------------|------|------------------------------------------------|
      -- | Go out      |  h   | Focus on parent directory                      |
      -- |-------------|------|------------------------------------------------|
      -- | Go out plus |  H   | Focus on parent directory plus extra action    |
      -- |-------------|------|------------------------------------------------|
      -- | Go to mark  |  '   | Jump to bookmark (waits for single key id)     |
      -- |-------------|------|------------------------------------------------|
      -- | Set mark    |  m   | Set bookmark (waits for single key id)         |
      -- |-------------|------|------------------------------------------------|
      -- | Reset       | <BS> | Reset current explorer                         |
      -- |-------------|------|------------------------------------------------|
      -- | Reveal cwd  |  @   | Reset current current working directory        |
      -- |-------------|------|------------------------------------------------|
      -- | Show help   |  g?  | Show help window                               |
      -- |-------------|------|------------------------------------------------|
      -- | Synchronize |  =   | Synchronize user edits and/or external changes |
      -- |-------------|------|------------------------------------------------|
      -- | Trim left   |  <   | Trim left part of branch                       |
      -- |-------------|------|------------------------------------------------|
      -- | Trim right  |  >   | Trim right part of branch                      |
      -- |-------------|------|------------------------------------------------|
      local MiniFiles = require("mini.files")
      MiniFiles.setup()
      -- Set focused directory as current working directory
      local set_cwd = function()
        local path = (MiniFiles.get_fs_entry() or {}).path
        if path == nil then
          return vim.notify("Cursor is not on valid entry")
        end
        vim.fn.chdir(vim.fs.dirname(path))
      end

      -- Yank in register full path of entry under cursor
      local yank_path = function()
        local path = (MiniFiles.get_fs_entry() or {}).path
        if path == nil then
          return vim.notify("Cursor is not on valid entry")
        end
        vim.fn.setreg(vim.v.register, path)
      end

      -- Open path with system default handler (useful for non-text files)
      local ui_open = function()
        vim.ui.open(MiniFiles.get_fs_entry().path)
      end

      vim.api.nvim_create_autocmd("User", {
        -- MiniFilesBufferCreate 가 단축키가 mini.files 안에서만 작동하도록 해준다
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local b = args.data.buf_id
          map("n", "g~", set_cwd, { buffer = b, desc = "Set cwd" })
          map("n", "gX", ui_open, { buffer = b, desc = "OS open" })
          map("n", "gy", yank_path, { buffer = b, desc = "Yank path" })
        end,
      })
      map("n", "<M-1>1", "<Cmd>lua MiniFiles.open()<CR>", { desc = "Open mini.files" })
      map("n", "<M-1>f", "<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", { desc = "mini.files focus" })
      map(
        "n",
        "<M-1>n",
        "<Cmd>lua MiniFiles.open('~/.config/nvim/lua/plugins')<CR>",
        { desc = "mini.files nvim plugins" }
      )
      map("n", "<M-1>d", "<Cmd>lua MiniFiles.open('~/Downloads')<CR>", { desc = "mini.files ~/Downloads" })
      map("n", "<M-1>w", "<Cmd>lua MiniFiles.open('~/workspace')<CR>", { desc = "mini.files ~/workspace" })
      map("n", "<M-1>s", "<Cmd>lua MiniFiles.open('~/.local/state/nvim/swap')<CR>", { desc = "mini.files swap/" })
      --
      -- ### files end
      ----------------------------------

      ----------------------------------
      -- ### git
      --
      -- 상태표시줄에 브랜치등 깃정보 표시
      -- 명령줄에서 :Git 으로 깃명령어 실행
      -- 명령어 결과창은 :q로 끄면 된다
      require("mini.git").setup()
      map({ "n", "x" }, "<leader>gs", "<Cmd>lua MiniGit.show_at_cursor()<CR>", { desc = "Show git history at cursor" })
      --
      -- ### git end
      ----------------------------------

      -- fFtT를 여러줄로 확장
      require("mini.jump").setup()

      ----------------------------------
      -- ### jump2d 점프 힌트
      --
      require("mini.jump2d").setup({
        -- 라벨에 대문자를 추가해 두 글자 라벨이 나올 확률을 줄임
        labels = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
        view = {
          -- 라벨을 미리 2단계까지 보여줘서 더 빠름
          n_steps_ahead = 2,
        },
      })
      -- 점프 스팟 하이라이트 반전
      vim.api.nvim_set_hl(0, "MiniJump2dSpot", { reverse = true })
      -- s + 한글자 점프
      map(
        { "n", "o", "x" },
        "<cr>",
        "<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>",
        { desc = "Jump anywhere" }
      )
      --
      -- ### jump2d end
      ----------------------------------

      ----------------------------------
      -- ### pick 검색기
      --
      -- Tab 미리보기, S-Tab 속성보기
      -- <C-x> 선택 토글, <C-a> 전체 선택 토글
      -- <C-Space> 검색결과 고정, 재검색
      -- MiniPick 설정 후에 추가
      local pick = require("mini.pick")
      pick.setup()
      map("n", "<M-2>f", "<Cmd>Pick files<CR>", { desc = "Pick files" })
      map("n", "<M-2>g", "<Cmd>Pick grep<CR>", { desc = "Pick grep" })

      -- Recent buffers picker 등록
      pick.registry.buffers_recent = function(local_opts)
        local_opts = vim.tbl_deep_extend("force", {
          include_current = true,
          include_unlisted = false,
        }, local_opts or {})

        -- 기본 buffers 함수와 동일한 로직으로 아이템 생성
        local buffers_output = vim.api.nvim_exec("buffers" .. (local_opts.include_unlisted and "!" or ""), true)
        local cur_buf_id, include_current = vim.api.nvim_get_current_buf(), local_opts.include_current
        local items = {}

        for _, l in ipairs(vim.split(buffers_output, "\n")) do
          local buf_str, name = l:match("^%s*%d+"), l:match('"(.*)"')
          local buf_id = tonumber(buf_str)
          if buf_id and vim.api.nvim_buf_is_valid(buf_id) then
            local item = {
              text = name,
              bufnr = buf_id,
              -- 정렬을 위한 lastused 추가
              _lastused = vim.fn.getbufinfo(buf_id)[1].lastused,
            }
            if buf_id ~= cur_buf_id or include_current then
              table.insert(items, item)
            end
          end
        end

        -- lastused 기준 내림차순 정렬 (최신순)
        table.sort(items, function(a, b)
          return a._lastused > b._lastused
        end)

        -- 기본 buffers와 동일한 show 함수 사용 (아이콘 포함)
        local show = pick.config.source.show
          or function(buf_id, items_to_show, query)
            return pick.default_show(buf_id, items_to_show, query, { show_icons = true })
          end

        local opts = {
          source = {
            name = "Buffers (Recent)",
            items = items,
            show = show,
          },
        }

        return pick.start(opts)
      end

      -- 키 매핑
      map("n", "<M-2>b", function()
        pick.registry.buffers_recent()
      end, { desc = "Pick recent buffers" })
      --
      -- ### pick end
      ----------------------------------

      ----------------------------------
      -- ## appearance
      ----------------------------------

      -- 부드러운 스크롤을 위해 필요.
      -- 반페이지, 한페이지 이동 시 부드럽게.
      require("mini.animate").setup()

      -- 커서 있는 곳 밑줄
      require("mini.cursorword").setup()

      -- FIXME, TODO 같은 패턴을 직접 만들어서 하이라이트 한다. 예쁘게 하는 용도
      require("mini.hipatterns").setup()

      -- 들여쓰기 단위를 text-obj i 로 제공함
      -- [,]i 로 이동도 가능
      require("mini.indentscope").setup()

      -- 사이드바 코드 요약
      local MiniMap = require("mini.map")
      MiniMap.setup()
      map("n", "<Leader>mc", MiniMap.close, { desc = "mini map close" })
      map("n", "<Leader>mf", MiniMap.toggle_focus, { desc = "mini map focus" })
      map("n", "<Leader>mo", MiniMap.open, { desc = "mini map open" })
      map("n", "<Leader>mr", MiniMap.refresh, { desc = "mini map refresh" })
      map("n", "<Leader>ms", MiniMap.toggle_side, { desc = "mini map toggle side" })
      map("n", "<Leader>mt", MiniMap.toggle, { desc = "mini map toggle" })

      -- 오른쪽 상단에 알림창
      require("mini.notify").setup()
    end,
  },
}
