set number
set relativenumber
set tabstop=4
set shiftwidth=4
set autoindent
set mouse=a
set cursorcolumn
colorscheme slate

call plug#begin('~/.vim/plugged')

" EasyMotion 플러그인 추가
Plug 'easymotion/vim-easymotion'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-surround'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'  " 테마 추가
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

let mapleader = " "

" EasyMotion 단축키 설정 (예: `<leader><leader>w`로 단어 이동)
nmap <leader>w <Plug>(easymotion-bd-w)
nmap s <Plug>(easymotion-s)

nnoremap <leader>vv :e ~\.vimrc<CR>
nnoremap <leader>vr :w<CR>:source $MYVIMRC<CR>

nnoremap <C-v> "+p
vnoremap <C-v> "+p
vnoremap <C-c> "+y

" Tab으로 자동완성 목록 탐색
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Enter로 현재 선택된 항목 확정
inoremap <expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

" Esc로 자동완성 목록 닫기
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"

