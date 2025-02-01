return  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },

    config = function()
        -- `:Neotree`를 `:nt`로 사용할 수 있도록 별칭 생성
        vim.api.nvim_create_user_command("Nt", function(opts)
            vim.cmd("Neotree " .. opts.args)
        end, { nargs = "*" }) -- "*"로 모든 인자 허용

        -- Neotree 기본 설정 적용
        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    visible = true,      -- 기본적으로 숨김 파일 보이게 설정
                    hide_dotfiles = false,  -- .파일 (.git, .config 등) 보이게 설정
                    hide_gitignored = false, -- Git에서 무시된 파일 표시
                },
            },
        })

        -- Neotree 단축키 설정 (필요 없는 경우 삭제 가능)
        vim.api.nvim_set_keymap('n', '<leader>nn', ':Neotree filesystem reveal dir=~/AppData/Local/nvim/lua<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>nc', ':Neotree reveal<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>nf', ':Neotree focus<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>nt', ':Neotree toggle<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>nb', ':Neotree buffers<CR>', { noremap = true, silent = true })
    end
}
