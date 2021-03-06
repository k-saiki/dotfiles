" Vim-plug
"   https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Git
Plug 'tpope/vim-fugitive'

" Language
Plug 'fatih/vim-go'

" Syntax
Plug 'tpope/vim-markdown'

" Looks
Plug 'nathanaelkane/vim-indent-guides'
Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Tools
Plug 'thinca/vim-quickrun'
Plug 'tyru/open-browser.vim'
Plug 'rhysd/accelerated-jk'
Plug 'ConradIrwin/vim-bracketed-paste'

" Themes
" Plug 'altercation/vim-colors-solarized'

call plug#end()

" ###############
" Vim setting
" ###############
set nobackup
set noswapfile
set autoread
set hidden
set showcmd

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932
set fileformats=unix,dos,mac

" Looks
set number
set cursorline
set cursorcolumn
set virtualedit=onemore
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest

" Tab
set list listchars=tab:\▸\-
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent

" Search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

" Vim keymap
nnoremap j gj
nnoremap k gk
imap jj <ESC>
imap kk <ESC>
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" Enable plugin
filetype plugin on
filetype indent on

" Colorscheme
set background=dark
" colorscheme solarized
if &term =~ "xterm-256color" || "screen-256color"
    set t_Co=256
    set t_Sf=[3%dm
    set t_Sb=[4%dm
elseif &term =~ "xterm-color"
    set t_Co=8
    set t_Sf=[3%dm
    set t_Sb=[4%dm
endif

" ###############
" Plugins setting
" ###############
"
" NERDTree
" Show hidden file
let NERDTreeShowHidden = 1
" Start up with NERDTree
autocmd vimenter * NERDTree
" Keymap
nnoremap <silent><C-e> :NERDTreeToggle<CR>
nnoremap <silent><C-c> :NERDTreeTabsClose<CR>
nnoremap <C-n> gt
nnoremap <C-p> gT


" vim-airline
let g:airline_theme = 'solarized'
let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#branch#enabled = 1

" vim-quickrun
set splitbelow
set splitright

" acceleraed-jk
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
