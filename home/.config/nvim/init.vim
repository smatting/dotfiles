call plug#begin()
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'rakr/vim-one'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'Valloric/YouCompleteMe', {'do': './install.py'}
" Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

set visualbell
set noerrorbells
"set cursorline
set number
set hidden
set colorcolumn=80
set clipboard=unnamedplus
set autoread "automatically update files if externally changed

"indenting
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
set nowrap
set nofoldenable

let NERDTreeHijackNetrw=1
let g:netrw_liststyle=3
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.git,*.pkl,__pycache__
set wildignore+=*.png,*.jpg,*.tgz,*.tar,*.gz,.venv


if (empty($TMUX))
  if (has("termguicolors"))
    set termguicolors
    set background=dark
    colorscheme one
  endif
endif

" vertical bars
set fillchars+=vert:\  
hi VertSplit ctermbg=NONE guibg=#444444
set foldcolumn=1

function! BlaFun(hu)
    exe "cd! " a:hu
endfunction
command! -nargs=1 Bla call BlaFun(<q-args>)
nmap <C-K> :silent :call fzf#run(fzf#wrap('my-stuff', {'source': 'find ~/ -not -path ''*/\.*'' -type d -maxdepth 2', 'sink': 'Bla'}))<cr>

command! Conf :e ~/.config/nvim/init.vim
nmap <C-P> :silent :GFiles<CR>
nmap <C-F> :silent :Files .<CR>
nmap <C-B> :silent :Buffers<CR>
nmap <C-S> :update<CR>


let g:airline_theme='solarized'
let g:airline_left_sep=''
let g:airline_right_sep=''

