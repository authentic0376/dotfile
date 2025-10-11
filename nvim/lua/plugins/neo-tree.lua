return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    config = function()
      require("neo-tree").setup({
        -- 마지막 neo-tree 윈도우를 닫을 때 Neovim 종료 여부
        close_if_last_window = true,
        -- 팝업 윈도우의 테두리 스타일
        popup_border_style = "rounded",
        -- 파일 시스템 변경 사항 자동 감지 (git 등)
        enable_git_status = true,
        -- LSP 진단(에러, 경고) 정보 표시
        enable_diagnostics = true,
        -- 기본적으로 열릴 소스 (filesystem, buffers, git_status 등)
        default_source = "filesystem",
        -- 소스(filesystem, buffers 등)를 탭처럼 보여주는 UI 활성화
        source_selector = {
          winbar = true, -- Neovim 0.8+ 에서만 사용 가능
          statusline = false,
        },
        -- 윈도우 관련 설정
        window = {
          position = "left", -- "left", "right", "float", "current"
          width = 30,
          -- neo-tree 윈도우 안에서의 키 매핑
          mappings = {
            ["<space>"] = "none", -- 스페이스바 기본 동작 비활성화
            ["o"] = "open",
            ["<cr>"] = "open",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["a"] = "add", -- 파일/디렉토리 추가
            ["d"] = "delete",
            ["r"] = "rename",
            ["c"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["?"] = "show_help",
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["<leader>e"] = "close_window", -- 리더키 + e로 닫기
          },
        },
        -- 파일 시스템 소스 관련 설정
        filesystem = {
          -- 현재 열린 파일을 neo-tree에서 자동으로 찾아 포커스
          follow_current_file = {
            enabled = true,
          },
          -- 숨김 파일/폴더 목록
          filtered_items = {
            visible = false, -- 숨김 파일을 보이려면 true로 설정
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true,
            hide_by_name = {
              ".git",
              "node_modules",
            },
            never_show = {
              ".DS_Store",
              "thumbs.db",
            },
          },
          -- Netrw(Neovim 기본 파일 탐색기) 대신 neo-tree 사용
          hijack_netrw_behavior = "open_current", -- "open_default" | "disabled"
        },
        -- 버퍼 소스 관련 설정
        buffers = {
          follow_current_file = {
            enabled = true,
          },
        },
        -- Git 상태 소스 관련 설정
        git_status = {
          window = {
            position = "float", -- git status는 보통 플로팅 창으로 띄움
          },
        },
        -- 이벤트 핸들러: 특정 이벤트 발생 시 함수 실행
        event_handlers = {
          -- 파일 열람 시 neo-tree 창 자동 닫기
          {
            event = "file_opened",
            handler = function()
              require("neo-tree.command").execute({ action = "close" })
            end,
          },
        },
      })

      -- 전역 키 매핑 (플러그인 외부에서 neo-tree를 제어)
      -- <leader>e : neo-tree 열기/닫기 (토글)
      -- 터미널 단축키와 겹치므로 터미널 단축키는 삭제해야 한다
      vim.keymap.set("n", "<M-1>", "<Cmd>Neotree toggle<CR>", { desc = "Explorer: Toggle Neo-tree" })

      -- 현재 파일이 속한 폴더를 루트로 띄운다. 버퍼 기준이기 때문에 Neotree 버퍼가 선택된 상태에서는 안된다
      vim.keymap.set("n", "<M-2>", "<Cmd>Neotree reveal_force_cwd<CR>", { desc = "Explorer: Toggle Neo-tree" })

      -- function 형태여야 dir를 제대로 인식함
      vim.keymap.set("n", "<leader>nn", function()
        require("neo-tree.command").execute({ dir = "~/.config/nvim/lua/plugins" })
      end, { desc = "Neo-tree toggle home directory" })

      vim.keymap.set("n", "<leader>nw", function()
        require("neo-tree.command").execute({ dir = "~/workspace" })
      end, { desc = "Neo-tree toggle home directory" })

      vim.keymap.set("n", "<leader>nd", function()
        require("neo-tree.command").execute({ dir = "~/Downloads" })
      end, { desc = "Neo-tree toggle home directory" })
    end,
  },
}
