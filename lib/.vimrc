" Set up pathogen
execute pathogen#infect()

set relativenumber
set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
syntax enable
colorscheme badwolf
set showcmd
set showmatch
set incsearch
set hlsearch
filetype plugin indent on

" Quick leave insert.
inoremap jj <ESC>

" Makefiles need tabs
autocmd FileType make set noexpandtab
" R files use two spaces
autocmd FileType r set tabstop=2 softtabstop=2 shiftwidth=2
" No tab expansion for tsvs
autocmd BufEnter *.tsv set noexpandtab

" Show lines over length
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"Open stuff in the right spot
set splitbelow
set splitright

"Fix backspacing
set backspace=indent,eol,start

"Syntastic checkers
let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint']
