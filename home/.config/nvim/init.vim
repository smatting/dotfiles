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
" brackets editing and more
Plug 'tpope/vim-surround'

Plug 'tpope/vim-fugitive'

" ]q [q paired mappings
Plug 'tpope/vim-unimpaired'

" :Rename and co
Plug 'tpope/vim-eunuch'

" Nice status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" gc - comment toggling
Plug 'tpope/vim-commentary'

" Super-fast searching throug stuff, :Ag, :Buffers and more
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Python
Plug 'hynek/vim-python-pep8-indent'
Plug 'nvie/vim-flake8'

" :Ranger - start the ranger file commander
Plug 'francoiscabrol/ranger.vim'

" Plug 'tpope/vim-vinegar'

" So that bufffers opened by ranger get closed
Plug 'rbgrouleff/bclose.vim'

" <C-N> - multiple cursor; great for renaming
Plug 'terryma/vim-multiple-cursors'

" :GundoToggle
Plug 'sjl/gundo.vim'

" line up text
Plug 'godlygeek/tabular'

Plug 'elmcast/elm-vim'
let g:elm_format_autosave = 0

" Plug 'vim-syntastic/syntastic'
" Plug 'eagletmt/ghcmod-vim'
" Plug 'eagletmt/neco-ghc'
Plug 'Shougo/neocomplete.vim'
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'

" Colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'rakr/vim-one'
Plug 'zanglg/nova.vim'
Plug 'muellan/am-colors'
" Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'

" Plug 'neomake/neomake'
" Plug 'Valloric/YouCompleteMe', {'do': './install.py'}
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'rbgrouleff/bclose.vim'
"
Plug 'vim-scripts/alex.vim'
Plug 'andy-morris/happy.vim'

Plug 'neovimhaskell/haskell-vim'
Plug 'rust-lang/rust.vim'


Plug 'LnL7/vim-nix'

" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': './install.sh'
"     \ }

Plug 'dracula/vim'


" Asynchronous linter
Plug 'w0rp/ale'

" Plug 'ludovicchabant/vim-gutentags'

Plug 'jlanzarotta/bufexplorer'

Plug 'vmchale/dhall-vim'

"
call plug#end()

set novisualbell
set noerrorbells
"set cursorline
set number
set hidden
set colorcolumn=""
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

syntax on
filetype plugin indent on

set autoread
au CursorHold,FocusGained,BufEnter * checktime


let g:ranger_map_keys = 0

" autocmd! BufWritePost * Neomake

autocmd BufNewFile,BufRead *.x   set syntax=alex
au FileType haskell setlocal shiftwidth=2 tabstop=2 

au FileType elm setlocal shiftwidth=2 tabstop=2 

let NERDTreeHijackNetrw=1
let g:netrw_liststyle=3
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

let g:deoplete#enable_at_startup = 1

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.git,*.pkl,__pycache__
set wildignore+=*.png,*.jpg,*.tgz,*.tar,*.gz,.venv
set wildignore+=*/node_modules/*,*/build/*


" if (empty($TMUX))
"   if (has("termguicolors"))
" 
"     set termguicolors
"     set background=dark
"     colorscheme dracula
"     hi MatchParen guifg=#ccffff guibg=#444444
"   endif
" endif

if (has("termguicolors"))
  set termguicolors
  set background=dark
  colorscheme dracula
  let g:dracula_underline = 0
  hi MatchParen guifg=#ccffff guibg=#444444
endif

" vertical bars
set fillchars+=vert:\  
hi VertSplit ctermbg=NONE guibg=#444444
set foldcolumn=1

function! BlaFun(dir)
    exe "lcd! " a:dir
    exe "pwd"
    " let g:netrw_list_hide= netrw_gitignore#Hide() . ',' . '\(^\|\s\s\)\zs\.\S\+'
endfunction

command! -nargs=1 Bla call BlaFun(<q-args>)

nmap <C-K> :silent :call fzf#run(fzf#wrap('my-stuff', {'source': 'find ~/ -not -path ''*/\.*'' -type d -maxdepth 2', 'sink': 'Bla'}))<cr>
nmap <C-J> :silent :call fzf#run(fzf#wrap('my-stuff', {'source': 'find . -not -path ''*/\.*'' -type d', 'sink': 'Bla'}))<cr>
nmap <leader>u :cd ..<CR>:pwd<CR>

nmap <F4> :let @+=expand("%:p")<CR>

command! Conf :e ~/.config/nvim/init.vim
nmap <C-P> :silent :GFiles<CR>
nmap <C-F> :silent :Files .<CR>
nmap <C-B> :silent :Buffers<CR>
nmap <C-S> :write<CR>
nmap <C-H> :nohls<CR>

nmap - :Ranger<CR>
nmap _ :RangerWorkingDirectory<CR>

nmap <F8> :ALEToggle<CR>

map <leader>j :%!python -m json.tool<CR>
" set cd to directory of opened file
map <leader>cd :cd %:p:h<CR>
" delete all buffers
map <leader>dab :%bdelete<CR>

map gu :echo "Nothing happens. I prevented a potentially unintented function for you."<CR>
map gU :echo "Nothing happens. I prevented a potentially unintented function for you."<CR>
map g~ :echo "Nothing happens. I prevented a potentially unintented function for you."<CR>
map <C-a> :echo "Nothing happens. I prevented a potentially unintented function for you."<CR>
map <C-x> :echo "Nothing happens. I prevented a potentially unintented function for you."<CR>

" ghc-mod type helpers
" map <silent> tw :GhcModTypeInsert<CR>
" map <silent> ts :GhcModSplitFunCase<CR>
" map <silent> tq :GhcModType<CR>
" map <silent> te :GhcModTypeClear<CR>


map == :Tabularize /^[^=]*\zs=/l1l1<CR>

let g:airline_theme='solarized'
let g:airline_left_sep=''
let g:airline_right_sep=''

" recommended by syntastic
" map <Leader>s :SyntasticToggleMode<CR>
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_python_checkers = ["flake8"]

let g:ale_python_mypy_options = "--ignore-missing-imports --strict-optional"
let g:ale_completion_enabled = 1
let g:ale_haskell_cabal_ghc_options = "-fno-code -v0 -i./src -i./larala"

let g:ale_linters = {
    \ 'python': ['flake8'],
    \ 'haskell': ['hlint', 'cabal-ghc']
\ }

hi ALEWarning guibg=#343746 ctermbg=green cterm=undercurl

set mouse=a

" set rtp+=~/.config/nvim/plugged/LanguageClient-neovim
" let g:LanguageClient_serverCommands = { 'haskell': ['hie-8.2'] }


" map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
" map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
" map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
" map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
" map <Leader>lb :call LanguageClient#textDocument_references()<CR>
" map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
" map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>

if !empty($MAIN_EDITOR)
    autocmd VimEnter * nested :source ~/.session.vim
    autocmd VimLeave * :mksession! ~/.session.vim
endif
"
"
" Helper function, called below with mappings
function! HaskellFormat(which) abort
  if a:which ==# 'hindent' || a:which ==# 'both'
    :Hindent
  endif
  if a:which ==# 'stylish' || a:which ==# 'both'
    " silent! exe 'undojoin'
    silent! exe 'keepjumps %!stylish-haskell'
  endif
endfunction

" augroup haskellStylish
"   au!
"   " Just hindent
"   " au FileType haskell nnoremap <leader>hi :Hindent<CR>
"   " Just stylish-haskell
"   au FileType haskell nnoremap <leader>hs :call HaskellFormat('stylish')<CR>
"   " First hindent, then stylish-haskell
"   " au FileType haskell nnoremap <leader>hf :call HaskellFormat('both')<CR>
" augroup END
"
"set guicursor=n:blinkon1
set guicursor=

