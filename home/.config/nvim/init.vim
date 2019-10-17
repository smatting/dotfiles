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
" Plug 'francoiscabrol/ranger.vim'

Plug 'tpope/vim-vinegar'

" So that bufffers opened by ranger get closed
"Plug 'rbgrouleff/bclose.vim'

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
Plug 'scrooloose/nerdtree'
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

Plug 'hashivim/vim-terraform'

Plug 'exu/pgsql.vim'

Plug 'sheerun/vim-polyglot'

" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'

"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }

" Plug 'plasticboy/vim-markdown'
" Plug 'gabrielelana/vim-markdown'

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

nmap <C-K> :silent :call fzf#run(fzf#wrap('my-stuff', {'source': 'find ~/ -not -path ''*/\.*'' -type d -maxdepth 2', 'sink': 'Bla'}))<CR><C-I>

nmap <C-I> :silent :call fzf#run(fzf#wrap('my-stuff', {'source': 'find $PWD -not -path ''*/\.*'' -type d -maxdepth 10', 'sink': 'Bla'}))<CR><C-I>

nmap <C-J> :silent :call fzf#run(fzf#wrap('my-stuff', {'source': 'find . -not -path ''*/\.*'' -type d', 'sink': 'Bla'}))<CR><C-I>
nmap <leader>u :cd ..<CR>:pwd<CR>

nmap <leader>nn :silent :call fzf#run(fzf#wrap('my-stuff', {'source': 'find $NOTES -not -path ''*/\.*'' -type f -maxdepth 10', 'sink': 'e'}))<CR><C-I>

nmap _ :e ./<CR>

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

nmap <F4> :let @+=expand("%:p")<CR>

command! Conf :e ~/.config/nvim/init.vim
nmap <C-P> :silent :GFiles<CR>
nmap <C-F> :silent :Files .<CR>
nmap <C-B> :silent :Buffers<CR>
nmap <C-S> :write<CR>
nmap <C-H> :nohls<CR>

" nmap - :Ranger<CR>
" nmap _ :RangerWorkingDirectory<CR>

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

" let g:airline_theme='solarized'
" let g:airline_extensions = []
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_left_sep=''
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#ale#enabled = 0
let g:airline_section_z = airline#section#create(['%3v'])

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
    \ 'haskell': ['hlint']
\ }

hi ALEWarning guibg=#343746 ctermbg=green cterm=undercurl

nmap <silent> [l :ALEDetail<CR>

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

autocmd FileType netrw setl bufhidden=wipe



autocmd FileType elm setl sw=2

augroup tags
au BufWritePost *.hs            silent !init-tags %
au BufWritePost *.hsc           silent !init-tags %
augroup END

let g:sql_type_default = 'pgsql'


"

" au User lsp_setup call lsp#register_server({
"     \ 'name': 'hie-core',
"     \ 'cmd': {server_info->['/home/stefan/.bin/hie-core-wrapper.sh', '--lsp']},
"     \ 'whitelist': ['haskell'],
"     \ })

" let g:lsp_diagnostics_echo_cursor = 1
let g:ghcid_command = "/home/stefan/.bin/ghcid-nix-shell"

" nnoremap <silent> <F5> :LspHover<CR>
" nnoremap <silent> <F6> :LspDefinition<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" coc.vim haskell configuration """""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" https://github.com/digital-asset/daml/issues/2801

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)


" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

nmap <leader>ra  :%!ormolu<CR>
nmap <leader>rp  vip:'<,'>!ormolu<CR>
vmap <leader>r  :'<,'>!ormolu<CR>
