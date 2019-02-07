
" =======================================================================
" Basic
" =======================================================================

syntax on
syntax enable

filetype off
filetype plugin on
filetype indent on

set autoread
set autoindent
set showmode
set showcmd
set number
set hlsearch
set showmatch
set nobackup
set smarttab
set backspace=eol,start,indent
set ignorecase
set smartcase
set cmdheight=2
set mouse=a
set cursorline
set noswapfile

set expandtab
set shiftwidth=4
set tabstop=4
set scrolloff=4
set textwidth=100

set encoding=utf-8
set guifont=Sauce\ Code\ Pro\ Nerd\ Font\ Complete\ Mono\ 11

set laststatus=2
set showtabline=2

set pastetoggle=<F2>
set wildmode=longest,list,full
set wildmenu

let mapleader = ','
let g:mapleader = ','

" Colors
set background=dark
let g:seoul256_background = 236

" Tags
set tagstack
set nocscopetag

" Visual Characters
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,nbsp:␣
set showbreak=↪

set synmaxcol=4096


function! Chomp(string)
    return substitute(a:string, '\n\+$', '', '')
endfunction

function! ChompedSystem( ... )
    return substitute(call('system', a:000), '\n\+$', '', '')
endfunction

" python
if executable('pyenv')
  let pyenv_root = system('pyenv root')
  let g:python3_host_prog = ChompedSystem('pyenv root') . '/versions/my/bin/python'
endif
" =======================================================================
" Check vim version
" =======================================================================
if has('nvim')
  let vimv = 'nvim'
  let vims = 'async'
elseif v:version >= 800
  let vimv = 'vim8'
  let vims = 'async'
else
  let vimv = 'vim7'
  let vims = 'sync'
endif

" =======================================================================
" Plugins
" =======================================================================

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction


if has('nvim')
call plug#begin('~/.local/share/nvim/plugged')
else
call plug#begin('~/.vim/plugged')
endif

Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion' " slow
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar', Cond(executable('ctags'))
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'junegunn/vim-peekaboo'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'Yggdroot/vim-mark'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim', Cond(executable('fzf'))
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
elseif v:version == 800
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'Shougo/deoplete.nvim'
endif

Plug 'honza/vim-snippets'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-sleuth'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'wellle/tmux-complete.vim'
Plug 'Konfekt/FastFold'
Plug 'mhinz/vim-startify'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/gv.vim'

Plug 'SirVer/ultisnips'
Plug 'itchyny/lightline.vim'
Plug 'ludovicchabant/vim-gutentags'   " slow vim close
Plug 'jreybert/vimagit'
Plug 'taohexxx/lightline-buffer'
Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-function'               " af/if : function,           aF/iF : extensible
  Plug 'sgur/vim-textobj-parameter'              " a,/i, : argument
  Plug 'kana/vim-textobj-indent'                 " ai/ii : similarly indent,   aI/iI : same indent block
  Plug 'Julian/vim-textobj-variable-segment'     " av/iv : _ or camelCase
  Plug 'kana/vim-textobj-line'                   " al/il : current line
  Plug 'kana/vim-textobj-entire'                 " ae/ie : entire region
  Plug 'terryma/vim-expand-region'               " K/J   : expand/shrink region
Plug 'pboettch/vim-highlight-cursor-words'
Plug 'rbgrouleff/bclose.vim'
  Plug 'francoiscabrol/ranger.vim', Cond(executable('ranger'))
Plug 'tpope/vim-unimpaired' " slow
Plug 'jceb/vim-orgmode'
Plug 'ervandew/supertab'
Plug 'Shougo/echodoc.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'matze/vim-move'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mattn/emmet-vim', { 'for': ['css', 'html'] }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }

Plug 'maxbrunsfeld/vim-yankstack'

Plug 'w0rp/ale', Cond(vims ==# 'async') " slow
" Plug 'zchee/deoplete-jedi', Cond(vims ==# 'async', { 'for': 'python' })
" Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': 'javascript' }

" Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Plug 'roxma/nvim-yarp'
" Plug 'ncm2/ncm2'

" " enable ncm2 for all buffers
" autocmd BufEnter * call ncm2#enable_for_buffer()

" " IMPORTANTE: :help Ncm2PopupOpen for more information
" set completeopt=noinsert,menuone,noselect

" " NOTE: you need to install completion sources to get completions. Check
" " our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-tmux'
" Plug 'ncm2/ncm2-path'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ 'frozen': 1
    \ }

call plug#end()

" Unused
" Plug 'terryma/vim-multiple-cursors'

" Plug 'junegunn/vim-slash'

" Plug 'Shougo/neco-vim', { 'for': 'vim' }
" Plug 'Shougo/neco-syntax', { 'for': 'vim' }
" Plug 'tweekmonster/deoplete-clang2', Cond(executable('clang') && vims ==# 'async', {'for': 'c'})
" Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" Plug 'racer-rust/vim-racer', { 'for': 'rust' }
" Plug 'nbouscal/vim-stylish-haskell', { 'for': 'haskell' }

Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'luochen1990/rainbow', { 'for': 'clojure' }
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }

Plug 'leafgarland/typescript-vim'


" Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
" Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
" Plug 'ndmitchell/ghcid', { 'for': 'haskell', 'rtp': 'plugins/nvim' }
" Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
" Plug 'parsonsmatt/intero-neovim', { 'for': 'haskell' }
" Plug 'trevordmiller/nova-vim'
" Plug 'mswift42/vim-themes'
" Plug 'morhetz/gruvbox'
" Plug 'dracula/vim', {'as': 'dracula'}
" Plug 'liuchengxu/space-vim-dark'
" Plug 'mhinz/vim-galore'
" Plug 'sheerun/vim-polyglot'
" Plug 'ryanoasis/vim-devicons'
" Plug 'ciaranm/detectindent'
" Plug 'luochen1990/indent-detector.vim'
" Plug 'Shougo/neoyank.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'wesleyche/SrcExpl'
" Plug 'vimwiki/vimwiki'
" Plug 'mileszs/ack.vim'
" Plug 'junegunn/vim-pseudocl'
" Plug 'junegunn/vim-oblique'
" Plug 'airblade/vim-rooter'
" Plug 'lambdalisue/gina.vim'
" Plug 'editorconfig/editorconfig-vim'
" Plug 'Chiel92/vim-autoformat'
" Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
" Plug 'moll/vim-node', { 'for': 'javascript' }
" Plug 'jeffkreeftmeijer/vim-numbertoggle'
" Plug 'chrisbra/NrrwRgn'
" Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }

"
colo seoul256
" colo gruvbox
" colo dracula
" colo darktooth
" colo space-vim-dark
" colo nova
"
hi Comment cterm=italic


" =======================================================================
" Plugin Setting
" =======================================================================

" let g:lc_filetypes = []
" let g:LanguageClient_serverCommands = {}
" if executable('pyls')
"   let g:LanguageClient_serverCommands.python = ['pyls']
"   call add(g:lc_filetypes, 'python')
" endif
" if executable('javascript-typescript-stdio')
"   let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
"   call add(g:lc_filetypes, 'javascript')
" endif
" if executable('rustup')
"   let g:LanguageClient_serverCommands.rust = ['rustup', 'run', 'stable', 'rls']
"   call add(g:lc_filetypes, 'rust')
" endif
" if executable('hie')
"   let g:LanguageClient_serverCommands.rust = ['hie', '--lsp']
"   call add(g:lc_filetypes, 'haskell')
" endif
" let g:lc_filetypes_str = join(g:lc_filetypes, ',')
" aug languageclient_map
"   au!
"   execute 'au FileType ' . g:lc_filetypes_str . ' nnoremap <silent> <buffer>
"     \ <F5> :call LanguageClient_contextMenu()<CR>'
"   execute 'au FileType ' . g:lc_filetypes_str . ' nnoremap <silent> <buffer>
"     \ lt :call LanguageClient#textDocument_typeDefinition()<CR>'
" aug END
"
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'haskell': ['hie', '--lsp'],
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'python': ['pyls'],
    \ }

let g:LanguageClient_diagnosticsEnable = 1

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <leader>d :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>t :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <silent> <leader>i :call LanguageClient#textDocument_implementation()<CR>
nnoremap <silent> <leader>n :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <leader>r :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <leader>h :call LanguageClient#textDocument_documentHighlight()<CR>
nnoremap <silent> <leader>c :call LanguageClient#clearDocumentHighlight()<CR>
nnoremap <silent> <leader>s :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> <leader>ws :call LanguageClient#workspace_symbol()<CR>
nnoremap <silent> <leader>f :call LanguageClient#textDocument_formatting()<CR>


" autocmd FileType python nnoremap <buffer>
"   \ <leader>lf :call LanguageClient_textDocument_documentSymbol()<cr>


let g:haskell_indent_disable = 1

" -----------------------------------------------
" Deoplete
" -----------------------------------------------

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1

" let g:deoplete#sources#jedi#python_path = '/home/mok/anaconda3/bin/python'
" let g:deoplete#sources#jedi#python_path = substitute(system('which python'), '\n', '', '')
let g:deoplete#sources#jedi#enable_cache = 1
let g:deoplete#sources#jedi#show_docstring = 1

let g:deoplete#sources#jedi#server_timeout = 60

" Let <Tab> also do completion
inoremap <silent><expr> <Tab>
\ pumvisible() ? "\<C-n>" :
\ deoplete#mappings#manual_complete()

" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" autocmd InsertLeave * if pumvisible() == 0 | pclose | endif


" -----------------------------------------------
" jedi-vim
" -----------------------------------------------
let g:jedi#completions_enabled = 1
let g:jedi#auto_initialization = 1

      " \  'haskell': ['stack ghc', 'hlint', 'hdevtools']
      " \  'python': ['flake8', 'pylint', 'pycodestyle'],
      " \  'python': ['pylint', 'pycodestyle'],
" ale
let g:ale_linters = {
      \  'javascript': ['eslint', 'jshint'],
      \  'html': ['htmlhint'],
      \  'vim': ['vint'],
      \  'markdown': ['alex'],
      \  'cpp': ['clangcheck', 'clangtidy', 'cpplint'],
      \  'c': ['clangtidy', 'cppcheck'],
      \  'css': ['csslint', 'prettier'],
      \  'sh': ['shellcheck'],
      \  'yaml': ['prettier'],
      \}
let g:ale_fixers = {
      \  'javascript': ['eslint'],
      \  'css': ['prettier'],
      \  'python': ['black'],
      \  'yaml': ['prettier'],
      \}
      " \  'javascript': ['eslint', 'prettier'],
let g:ale_python_pylint_options = "--diable=W0311,C0111 --msg-template='{msg_id}:{line:3d},{column}: {obj}: {msg}'"
let g:ale_python_flake8_options = '--ignore=E111,E114,E501'
let g:ale_python_pycodestyle_options = '--ignore=E111,E114,E501'

let g:ale_completion_enabled = 0

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
  " let g:ale_echo_msg_format = '[%linter%][%code%] %s'
autocmd FileType * let g:ale_echo_msg_format = '[%code%] %s'
autocmd FileType python let g:ale_echo_msg_format = '[%linter%][%code%] %s'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
" let g:ale_echo_delay = 10000
" let g:ale_echo_cursor = 0
" if len(readfile(expand('%:p'))) > 1000
"   let g:ale_lint_on_enter = 0
" endif

" -----------------------------------------------
" Fugitive
" -----------------------------------------------
nnoremap <Leader>gb :Gblame<cr>
nnoremap <Leader>gc :Gcommit<cr>
nnoremap <Leader>gd :Gdiff<cr>
nnoremap <Leader>gp :Git push<cr>
nnoremap <Leader>gr :Gremove<cr>
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gw :Gwrite<cr>
" Quickly stage, commit, and push the current file. Useful for editing .vimrc
nnoremap <Leader>gg :Gwrite<cr>:Gcommit -m 'update'<cr>:Git push<cr>

" -----------------------------------------------
" FZF
" -----------------------------------------------

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>),
  \                   0,
  \                   <bang>0 ? fzf#vim#with_preview('up:60%')
  \                           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                   <bang>0)

command! -bang -nargs=* Agw
  \ call fzf#vim#ag(<q-args>,
  \                 '-w',
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

command! -bang -nargs=* Agp
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* Rgw
  \ call fzf#vim#grep(
  \   'rg -w --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <silent> <space><space> :Files<CR>
nnoremap <silent> <space>a       :Buffers<CR>
nnoremap <silent> <space>A       :Windows<CR>
nnoremap <silent> <space>;       :Lines<CR>
nnoremap <silent> <space>.       :BLines<CR>
nnoremap <silent> <space>T       :Tags<CR>
nnoremap <silent> <space>t       :BTags<CR>
nnoremap <silent> <space>h       :History<CR>
nnoremap <silent> <space>h/      :History/<CR>
nnoremap <silent> <space>h:      :History:<CR>
" nnoremap <silent> <space>/       :execute 'Agp ' . input('Ag/')<CR>
nnoremap <silent> <space>/       :execute 'Rg ' . input('Rg/')<CR>
nnoremap <silent> <space>//      :execute 'GGrep ' . input('GGrep/')<CR>
nnoremap <silent> **             :call SearchWordWithRgW()<CR>
vnoremap <silent> **             :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent> <space>C       :Commits<CR>
nnoremap <silent> <space>c       :BCommits<CR>
nnoremap <silent> <space>m       :FZFMru<CR>
nnoremap <silent> <space>M       :Marks<CR>
nnoremap <silent> <space>?       :Helptags<CR>
"nnoremap <silent> <space>ft :Filetypes<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

function! SearchWordWithRgW()
  execute 'Rgw' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Ag' selection
endfunction


let g:fzf_mru_file_list_size = 50

" \ 'source':  reverse(s:all_files()),
command! FZFMru call fzf#run({
\ 'source':  s:all_files(),
\ 'sink':    'edit',
\ 'options': '-m -x +s',
\ 'down':    '40%' })

function! s:all_files()
  return extend(
  \ filter(copy(v:oldfiles),
  \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
  \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
endfunction

" -----------------------------------------------
" indent_guides
" -----------------------------------------------
let g:indent_guides_enable_on_vim_startup = 0

" -----------------------------------------------
" Gutentags
" -----------------------------------------------
" let g:gutentags_project_root = ['.mprj']
" let g:gutentags_add_default_project_roots = 1
let g:gutentags_enabled = 0

" -----------------------------------------------
" EasyAlign
" -----------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" -----------------------------------------------
" Airline
" -----------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline_theme='tomorrow'

" -----------------------------------------------
" Lightline
" -----------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ]]
      \ },
      \ 'component_expand': {
      \   'buffercurrent': 'lightline#buffer#buffercurrent',
      \   'bufferbefore': 'lightline#buffer#bufferbefore',
      \   'bufferafter': 'lightline#buffer#bufferafter',
      \ },
      \ 'component_type': {
      \   'buffercurrent': 'tabsel',
      \   'bufferbefore': 'raw',
      \   'bufferafter': 'raw',
      \ },
      \ 'component_function': {
      \   'modified': 'LightlineModified',
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'bufferbefore': 'lightline#buffer#bufferbefore',
      \   'bufferafter': 'lightline#buffer#bufferafter',
      \   'bufferinfo': 'lightline#buffer#bufferinfo',
      \ },
      \ 'component': {
      \   'separator': '',
      \ },
      \ 'tabline': {
      \   'left': [ [ 'bufferinfo' ], [ 'separator' ], [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
      \   'right': [ [ 'close' ], ],
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction=

" lightline-buffer settings
let g:lightline_buffer_logo = ''
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '✭'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = ' '

let g:lightline_buffer_show_bufnr = 1
let g:lightline_buffer_rotate = 0
let g:lightline_buffer_fname_mod = ':t'
let g:lightline_buffer_excludes = ['vimfiler']

let g:lightline_buffer_maxflen = 30
let g:lightline_buffer_maxfextlen = 3
let g:lightline_buffer_minflen = 16
let g:lightline_buffer_minfextlen = 3
let g:lightline_buffer_reservelen = 20

" -----------------------------------------------
" Ultisnips
" -----------------------------------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" -----------------------------------------------
" Tagbar
" -----------------------------------------------
let g:tagbar_width = 60

" -----------------------------------------------
" Rooter
" -----------------------------------------------
let g:rooter_manual_only = 1
let g:rooter_use_lcd = 1
"

" -----------------------------------------------
"  DetectIndent
" -----------------------------------------------
let g:detectindent_preffered_expandtab = 1
let g:detectindent_preffered_indent = 4

" -----------------------------------------------
"  Highlight Curwor Words
" -----------------------------------------------
let g:HiCursorWords_delay = 400

" -----------------------------------------------
"  Ranger
" -----------------------------------------------
let g:ranger_map_keys = 0
map <leader>R :Ranger<CR>.

" -----------------------------------------------
"  Auto Pairs
" -----------------------------------------------
let g:AutoPairsShortcutToggle = '<F6>'

" -----------------------------------------------
let g:vim_json_syntax_conceal = 0

" =======================================================================
" More Customization
" =======================================================================

" -----------------------------------------------
" Move Line/Block
" -----------------------------------------------
" nnoremap <A-j> :m .+1<CR>==
" nnoremap <A-k> :m .-2<CR>==

" nnoremap <A-j> :m .+1<CR>
" nnoremap <A-k> :m .-2<CR>
" inoremap <A-j> <Esc>:m .+1<CR>==gi
" inoremap <A-k> <Esc>:m .-2<CR>==gi

" vnoremap <A-j> :m '>+1<CR>gv=gv
" vnoremap <A-k> :m '<-2<CR>gv=gv
"
" vnoremap <A-j> :m '>+1<CR>gv
" vnoremap <A-k> :m '<-2<CR>gv

" -----------------------------------------------
" Restore Last Position
" -----------------------------------------------
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" -----------------------------------------------
" Easier split navigations
" -----------------------------------------------
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" -----------------------------------------------
"  Man Page
" -----------------------------------------------
nnoremap M :Man<CR>

" -----------------------------------------------
"  Git Root
" -----------------------------------------------
function! GitRootPathWithCWD()
  let gitdir = finddir(".git", getcwd() . ';')
  if (!empty(gitdir))
    return fnamemodify(gitdir, ":p:h:h")
  endif
endfunction

function! GitRootPathWithCurrentBuffer()
  let gitdir = finddir(".git", expand('%:p:h') . ';')
  if (!empty(gitdir))
    return fnamemodify(gitdir, ":p:h:h")
  endif
endfunction

" -----------------------------------------------
"  Super Tab
" -----------------------------------------------
let g:SuperTabDefaultCompletionType = "<c-n>"

" -----------------------------------------------
"  Some conveniences
" -----------------------------------------------
" nmap <F7> :SrcExplToggle<CR>
" Strip all trailing whitespace
nnoremap <F4> :%s/\s\+$//<cr>:let @/=''<CR>
" nnoremap <F5> :%s/\r/\r/g<CR>
nnoremap <F7> :%!python -m json.tool<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <F9> :NERDTreeToggle<CR>

nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
" noremap ; :

" save when lost focus
au FocusLost * :wa

highlight ExtraWhitespace ctermbg=52


" Re-hardwrap paragraphs of text
nnoremap <leader>q gqip

" Open configuration file
if has('nvim')
  nnoremap <leader>ev <C-w><C-v><C-l>:e ~/.config/nvim/init.vim<cr>
else
  nnoremap <leader>ev <C-w><C-v><C-l>:e ~/.vimrc<cr>
endif

" Duplicate & Switch window
nnoremap <leader>w <C-w>v<C-w>l

" Open help vertically
autocmd FileType help wincmd L

" <Leader>cd: Switch to the directory of the open buffer
nnoremap <Leader>cd :cd %:p:h<cr>:pwd<cr>

" Clone Paragraph with cp
noremap cp yap<S-}>p

autocmd FileType help noremap <buffer> q :q<cr>
autocmd FileType man noremap <buffer> q :q<cr>

" -----------------------------------------------
" Expand region
" -----------------------------------------------
map ) <Plug>(expand_region_expand)
map ( <Plug>(expand_region_shrink)
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i]'  :1,
      \ 'i}'  :1,
      \ 'ib'  :1,
      \ 'iB'  :1,
      \ 'il'  :0,
      \ 'ip'  :0,
      \ 'af'  :1,
      \ 'ie'  :0,
      \ }
