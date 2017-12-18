" TODOS
"
" * snippets: ipdb; ifmain
" * edit remote files locally; challenge: sudo
" * project-wide fuzzy search
" * Problem: GFiles only works if a file from the repo has been opened.
" *          What i want is a GFiles search where the repo is taken from CWD
" 
" if terminal is too small <C-K> will not execute immediaetely
"
call plug#begin()
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
" Plug 'vim-syntastic/syntastic'
Plug 'neomake/neomake'
" Plug 'Valloric/YouCompleteMe', {'do': './install.py'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'hynek/vim-python-pep8-indent'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'sjl/gundo.vim'
Plug 'godlygeek/tabular'

" Colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'rakr/vim-one'
Plug 'zanglg/nova.vim'
Plug 'muellan/am-colors'
" Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

set novisualbell
set noerrorbells
"set cursorline
set number
set hidden
set colorcolumn=80
set clipboard=unnamedplus

"indenting
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
set nowrap
set nofoldenable
set autoread

let g:ranger_map_keys = 0

autocmd! BufWritePost * Neomake

let NERDTreeHijackNetrw=1
let g:netrw_liststyle=3
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

let g:deoplete#enable_at_startup = 1

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.git,*.pkl,__pycache__
set wildignore+=*.png,*.jpg,*.tgz,*.tar,*.gz,.venv


if (empty($TMUX))
  if (has("termguicolors"))
    set termguicolors
    set background=dark
    colorscheme one
    hi MatchParen guifg=#ccffff guibg=#444444
  endif
endif


" vertical bars
set fillchars+=vert:\  
hi VertSplit ctermbg=NONE guibg=#444444
set foldcolumn=1

function! BlaFun(hu)
    exe "lcd! " a:hu
    let g:netrw_list_hide= netrw_gitignore#Hide() . ',' . '\(^\|\s\s\)\zs\.\S\+'
endfunction

command! -nargs=1 Bla call BlaFun(<q-args>)
nmap <C-K> :silent :call fzf#run(fzf#wrap('my-stuff', {'source': 'find ~/ -not -path ''*/\.*'' -type d -maxdepth 2', 'sink': 'Bla'}))<cr>

command! Conf :e ~/.config/nvim/init.vim
nmap <C-P> :silent :GFiles<CR>
nmap <C-F> :silent :Files .<CR>
nmap <C-B> :silent :Buffers<CR>
nmap <C-S> :write<CR>
nmap <C-H> :nohls<CR>
nmap - :Ranger<CR>
map <leader>f :RangerWorkingDirectory<CR>
map <leader>j :%!python -m json.tool<CR>
" set cd to directory of opened file
map <leader>cd :cd %:p:h<CR>
" delete all buffers
map <leader>dab :%bdelete<CR>


let g:airline_theme='solarized'
let g:airline_left_sep=''
let g:airline_right_sep=''

