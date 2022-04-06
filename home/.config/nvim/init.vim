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

let g:ale_set_balloons = 1

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
" Plug 'garbas/vim-snipmate'

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


"" Asynchronous linter
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
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

Plug 'airblade/vim-gitgutter'

Plug 'jparise/vim-graphql'

" Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }

Plug 'plasticboy/vim-markdown'
Plug 'gabrielelana/vim-markdown'

Plug 'sbdchd/neoformat'

" Plug 'neovim/nvim-lsp'
" Plug 'haorenW1025/diagnostic-nvim'

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
" au CursorHold,FocusGained,BufEnter * checktime


let g:ranger_map_keys = 0

" autocmd! BufWritePost * Neomake

autocmd BufNewFile,BufRead *.x   set syntax=alex



au FileType elm setlocal shiftwidth=2 tabstop=2 

let NERDTreeHijackNetrw=1
let g:netrw_liststyle=3
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

let g:deoplete#enable_at_startup = 1

set wildignore+=*.so,*.swp,*.zip,.git,*.pkl,__pycache__
set wildignore+=*.png,*.jpg,*.tgz,*.tar,*.gz,.venv
set wildignore+=*/node_modules/*,*/build/*


if (has("termguicolors"))
  set termguicolors
  set background=dark
  colorscheme dracula
  let g:dracula_underline = 0
  hi MatchParen guifg=#ccffff guibg=#444444
endif

" vertical bars
" set fillchars+=vert:\
" hi VertSplit ctermbg=NONE guibg=#444444
" set foldcolumn=1

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


map <leader>j :%!python -m json.tool<CR>

" set cd to directory of opened file
map <leader>cd :cd %:p:h<CR>

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

    " \ 'haskell': ['hlint', 'hie'],
    " \ 'purescript': []

let g:ale_linters = {
    \ 'python': ['flake8'],
    \ 'haskell': [],
\ }
hi ALEWarning guibg=#343746 ctermbg=green cterm=undercurl
" nmap <F8> :ALEToggle<CR>
nmap <silent> <leader>e :ALEDetail<CR>
let g:ale_cursor_detail = 0

" let g:ale_haskell_hie_executable = "/home/stefan/.nix-profile/bin/ghcide"


set mouse=a


" if !empty($MAIN_EDITOR)
"     autocmd VimEnter * nested :source ~/.session.vim
"     autocmd VimLeave * :mksession! ~/.session.vim
" endif
"
"set guicursor=n:blinkon1
set guicursor=

autocmd FileType netrw setl bufhidden=wipe




autocmd FileType elm setl sw=2

" Haskell
" -------

let g:sql_type_default = 'pgsql'

au FileType haskell setlocal shiftwidth=2 tabstop=2 
let g:neoformat_enabled_haskell = ['ormolu']

augroup tags
au BufWritePost *.hs            silent !init-tags %
au BufWritePost *.hsc           silent !init-tags %
augroup END


" -------

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <leader>fa :Neoformat<CR>
vmap <leader>f  :'<,'>Neoformat<CR>

" disable ex-mode
nnoremap Q <Nop>

" trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" purescript
let purescript_indent_if = 2
let purescript_indent_case = 2
let purescript_indent_let = 2
let purescript_indent_where = 2
let purescript_indent_do = 2
let purescript_indent_in = 2
au FileType purescript setlocal shiftwidth=2 tabstop=2 

let g:neoformat_purescript_mypurty = {
        \ 'exe': '/home/stefan/.npm-global-stefan/bin/purty',
        \ 'args': ['-'],
        \ 'stdin': 1
        \ }
let g:neoformat_enabled_purescript = ['mypurty']

" LSP Config
" ----------

" See code here:
" https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp.lua

" function! LoadGHCIDE()
" lua << EOF
" require'nvim_lsp'.ghcide.setup{}
" EOF
" endfunction
" call LoadGHCIDE()
" " require'nvim_lsp'.purescriptls.setup{}

" function! LSPStop()
" lua << EOF
" local lsp = require('vim.lsp')
" lsp.stop_client(lsp.get_active_clients())
" EOF
" endfunction

" nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>

" let g:diagnostic_enable_virtual_text = 0
" lua require'nvim_lsp'.ghcide.setup{on_attach=require'diagnostic'.on_attach}

nmap <F8> :NextDiagnostic<CR>
nmap <F7> :PrevDiagnostic<CR>

" - vim-lsp (howere this feels sluggish ) ----------------------------------------

" au User lsp_setup call lsp#register_server({
"     \ 'name': 'ghcide',
"     \ 'cmd': {server_info->['ghcide', '--lsp']},
"     \ 'whitelist': ['haskell'],
"     \ })

" au User lsp_setup call lsp#register_server({
"     \ 'name': 'purescript',
"     \ 'cmd': {server_info->['purescript-language-server', '--stdio']},
"     \ 'whitelist': ['purescript'],
"     \ })

" let g:lsp_diagnostics_float_cursor = 1
" let g:lsp_diagnostics_echo_delay = 20
" let g:lsp_diagnostics_float_delay = 20
" let g:lsp_text_document_did_save_delay = -1
" let g:lsp_diagnostics_echo_cursor = 0
" let g:lsp_signs_enabled = 1
" let g:lsp_virtual_text_enabled = 0

" highlight LspErrorHighlight term=underline cterm=underline gui=underline
" highlight LspErrorText guifg=#f8f8f2 guibg=#ff6e67 gui=NONE
" highlight LspWarningHighlight term=underline cterm=underline gui=underline
" highlight LspWarningText guifg=#f8f8f2 guibg=#727808 gui=NONE
" highlight Pmenu ctermbg=gray guibg=#36394a

" nnoremap <silent> K <cmd>LspHover()<CR>

" --------------------------------------------------------------------------------
