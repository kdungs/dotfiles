" .vimrc
"
" Kevin Dungs <kevin@dun.gs>
" 2016-10-22

filetype plugin on
set enc=utf-8

" Defaults
set autoread
set backspace=indent,eol,start
set clipboard=unnamed
set complete-=i
set hidden
set hlsearch
set ignorecase
set incsearch
set lazyredraw
set magic
set mouse=a
set number
set ruler
set showmatch
set smartcase
set spell

" Whitespace
set autoindent
set expandtab
set shiftwidth=2
set smarttab
set tabstop=4
set wrap

" Colours
set t_Co=256
syntax enable
set background=dark
colorscheme peaksea

" Bindings
let mapleader=","
nnoremap <leader>, :let@/='' <return>
nnoremap <leader>w :w <return>
nnoremap <leader>r :so ~/.vimrc <return>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

" Plugins
"" Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
"" Clang-format
map <C-f> :pyf ~/.vim/clang-format/clang-format.py<return>
map <leader>f <C-f>
imap <C-f> <ESC>:pyf ~/.vim/clang-format/clang-format.py<return>
"" NERD tree
let NERDTreeIgnore=['\~$', '^\.git', '\.swp$', '\.DS_Store$']
let NERDTreeShowHidden=1
nnoremap <C-t> :NERDTreeToggle<return>
"" Syntastic
let g:syntastic_enable_signs=1
