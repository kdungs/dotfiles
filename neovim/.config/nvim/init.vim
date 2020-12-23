" General
set clipboard+=unnamedplus
set cursorline
set hidden
set ignorecase
set lazyredraw
set mouse=a
set noswapfile
set number
set showmatch
set smartcase
set spell
set undofile

" Visual
set listchars=tab:>•,trail:•
set list
set scrolloff=3
set sidescrolloff=5

" White space
set expandtab
set shiftwidth=2
set tabstop=4

set colorcolumn=80

" Coc stuff
" TODO: sort later
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Python for neovim
let g:python_host_prog = $HOME.'/.pyenv/versions/py2neovim/bin/python'
let g:python3_host_prog = $HOME.'/.pyenv/versions/py3neovim/bin/python'

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
" plug#end automatically calls `filetype plugin indent on` and `syntax enable`

" UI
set termguicolors
set background=dark
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
let g:airline_theme = 'nord'
color nord
highlight Comment cterm=italic

" Bindings
let mapleader=","
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <leader>, :let@/='' <return>
nnoremap <leader>l :set invrelativenumber <return>
nnoremap <leader>r :so ~/.vimrc <return>
nnoremap <leader>w :w <return>

" Plugin options
"" Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

"" Coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"" FZF
let g:fzf_command_prefix='Fzf'


"" Vim-go
let g:go_def_mapping_enabled=0
let g:go_info_mode='gopls'

"" NERD tree
let NERDTreeIgnore=['\~$', '^\.git', '\.swp$', '\.DS_Store$']
let NERDTreeShowHidden=1
nnoremap <leader>t :NERDTreeToggle<return>
