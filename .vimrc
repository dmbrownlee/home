if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
"Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'
Plug 'tmux-plugins/vim-tmux'
"Plug 'edkolev/tmuxline.vim'

" Color Theme
Plug 'sainnhe/forest-night'
Plug 'morhetz/gruvbox'
call plug#end()

set nocompatible
set mouse=a

" UI tweaks
set number
set relativenumber
syntax on
set hlsearch
set incsearch
set cursorline
set colorcolumn=81

" set statusline
set showcmd
set t_Co=256
set laststatus=2
set showmode
set title

" TmuxLine settings
let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = 'righteous'

" Indenting
set smartindent
set tabstop=2 softtabstop=2
set shiftwidth=2
set shiftround
set smarttab
set expandtab

" Because the ESC "key" on the Mac touchbar sucks
"inoremap jk <ESC>
"vnoremap jk `<<ESC>

" Folding
set foldmethod=syntax
set foldcolumn=4
nnoremap <space> za
vnoremap <space> zf

"autocmd Syntax c,cpp,vim,python,yaml,shell normal zR

" Python folding override
setlocal foldmethod=indent

" Visual line wrapping (not adding LF to text in buffer)
set wrap
set linebreak
let &showbreak = '>\ '

" Scrolling

" Start scrolling slightly before the cursor reaches the edge
set scrolloff=3
set sidescrolloff=5

" Scroll horizontally a character at a time
set sidescroll=1

" Disable arrow keys (hardcore)
map  <up>    <nop>
imap <up>    <nop>
map  <down>  <nop>
imap <down>  <nop>
map  <left>  <nop>
imap <left>  <nop>
map  <right> <nop>
imap <right> <nop>

" Persistent undo without the mess
set undodir=~/.vim/undodir
set undofile

" With both of these on, searches with no capitals are case insensitive, while
" searches with a capital characters are case sensitive.
"set smartcase
"set ignorecase
" Watch https://www.youtube.com/watch?v=wlR5gYd6um0 to see cool plugin demo
"
" Commentary - https://github.com/tpope/vim-commentary
autocmd FileType python setlocal commentstring=#\ %s

" Add vertical to the defaults for using :diffsplit <file> from within vim
set diffopt=filler,vertical,foldcolumn:4

" Colors
set background=dark
colorscheme gruvbox
hi clear CursorColumn
hi clear CursorLine
hi clear CursorLineNr
hi CursorLine cterm=reverse
hi CursorLineNr cterm=reverse
hi link CursorColumn CursorLine

" Termcap settings to make cursor visible
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Disable sounds
set noerrorbells

" Key mappings
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>
