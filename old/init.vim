
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
set textwidth=0
set wrapmargin=0

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
  let g:python3_host_prog = ChompedSystem('pyenv root') . '/versions/dev/bin/python'
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

" Plug 'junegunn/seoul256.vim'
" Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'morhetz/gruvbox'
" Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'NLKNguyen/papercolor-theme'
let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'allow_bold': 1,
  \       'override' : {
  \         'color00' : ['#303030', '236'],
  \         'color07' : ['#303030', '250'],
  \         'cursorline' : ['', '237']
  \       }
  \     }
  \   }
  \ }


" =======================================================================
" Essential Light Plugins
" =======================================================================
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" Plug 'jiangmiao/auto-pairs'
Plug 'tmsvg/pear-tree'
Plug 'easymotion/vim-easymotion'
Plug 'ntpeters/vim-better-whitespace'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-fugitive'
" Plug 'majutsushi/tagbar', Cond(executable('ctags'))
" Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'junegunn/vim-peekaboo'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'Yggdroot/vim-mark'
Plug 'tpope/vim-dispatch'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim', Cond(executable('fzf'))


Plug 'liuchengxu/vim-which-key'
" Plug 'honza/vim-snippets'
Plug 'kshenoy/vim-signature'
Plug 'airblade/vim-gitgutter'
" Plug 'mhinz/vim-signify'
Plug 'tpope/vim-sleuth'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'wellle/tmux-complete.vim'
Plug 'Konfekt/FastFold'
Plug 'mhinz/vim-startify'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/gv.vim'

" Plug 'SirVer/ultisnips'
Plug 'itchyny/lightline.vim'
Plug 'ludovicchabant/vim-gutentags'   " slow vim close
Plug 'jreybert/vimagit'
Plug 'taohexxx/lightline-buffer'
Plug 'kana/vim-textobj-user'
  "Plug 'kana/vim-textobj-function'               " af/if : function,           aF/iF : extensible
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
" Plug 'ervandew/supertab'
Plug 'Shougo/echodoc.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'matze/vim-move'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mattn/emmet-vim', { 'for': ['css', 'html'] }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }

" Plug 'maxbrunsfeld/vim-yankstack'
Plug 'vim-python/python-syntax'
let g:python_highlight_operators = 1
let g:python_highlight_class_vars = 1
let g:python_highlight_string_format = 1
let g:python_highlight_builtins = 1
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'justinmk/vim-sneak'
Plug 'Yggdroot/indentLine'

Plug 'w0rp/ale', Cond(vims ==# 'async') " slow


Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'liuchengxu/vista.vim'
let g:vista_sidebar_width = 50
let g:vista_default_executive = 'coc'
let g:vista_icon_indent = ["▸ ", ""]

Plug 'posva/vim-vue'
Plug 'ekalinin/Dockerfile.vim'

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

" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
" Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
" Plug 'luochen1990/rainbow', { 'for': 'clojure' }
" Plug 'guns/vim-sexp', { 'for': 'clojure' }
" Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }

" Plug 'leafgarland/typescript-vim'


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
Plug 'sheerun/vim-polyglot'
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
" colo seoul256
colo PaperColor
" colo gruvbox
" colo dracula
" colo onehalfdark
"
" colo darktooth
" colo space-vim-dark
" colo nova
"
hi Comment cterm=italic


" =======================================================================
" Plugin Setting
" =======================================================================

" -----------------------------------------------
" WhichKey
" -----------------------------------------------
" nnoremap <silent> <leader>      :<c-u>WhichKey ','<CR>
" nnoremap <silent> <localleader> :<c-u>WhichKey  '<Space>'<CR>

" -----------------------------------------------
" COC
" -----------------------------------------------
" Use `[c` and `]c` for navigate diagnostics
" nmap <silent> [d <Plug>(coc-diagnostic-prev)
" nmap <silent> ]d <Plug>(coc-diagnostic-next)

nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>y <Plug>(coc-type-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader>r <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR><Paste>
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>

" Remap for rename current word
nmap <leader>n <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format)

nmap <leader>l  <Plug>(coc-codelens-action)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

 " Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')
hi CocHighlightText ctermbg=DarkBlue ctermfg=Yellow



" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

let g:coc_snippet_next = '<tab>'

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
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

let g:haskell_indent_disable = 1

" -----------------------------------------------
" ALE
" -----------------------------------------------
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
      \  'python': ['flake8', 'pylint'],
      \}

let g:ale_fixers = {
      \  '*': ['remove_trailing_lines', 'trim_whitespace'],
      \  'javascript': ['prettier', 'eslint'],
      \  'css': ['prettier'],
      \  'html': ['prettier'],
      \  'python': ['autopep8', 'isort'],
      \  'yaml': ['prettier'],
      \}

let g:ale_python_pylint_options = "--diable=W0311,C0111 --msg-template='{msg_id}:{line:3d},{column}: {obj}: {msg}'"
let g:ale_python_flake8_options = '--ignore=E111,E114,E501'
let g:ale_python_pycodestyle_options = '--ignore=E111,E114,E501'
let g:ale_completion_enabled = 0
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1

autocmd FileType * let g:ale_echo_msg_format = '[%code%] %s'
autocmd FileType python let g:ale_echo_msg_format = '[%linter%][%code%] %s'

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

" command! -bang -nargs=* GGrep
"   \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>),
"   \                   0,
"   \                   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \                           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \                   <bang>0)

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \   <bang>0)

command! -bang -nargs=* Rgw
  \ call fzf#vim#grep(
  \   'rg -w --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


" nnoremap <silent> <expr> <space><space> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <space><space> :Files<CR>
nnoremap <silent> <space>g       :GFiles<CR>
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
nnoremap <silent> <space>/       :Rg<CR>
" nnoremap <silent> <space>/       :execute 'Rg ' . input('Rg/')<CR>
nnoremap <silent> <space>//      :execute 'GGrep ' . input('GGrep/')<CR>
nnoremap <silent> **             :call SearchWordWithRgW()<CR>
vnoremap <silent> **             :call SearchVisualSelectionWithRg()<CR>
nnoremap <silent> <space>C       :Commits<CR>
nnoremap <silent> <space>c       :BCommits<CR>
nnoremap <silent> <space>m       :FZFMru<CR>
nnoremap <silent> <space>M       :Marks<CR>
nnoremap <silent> <space>?       :Helptags<CR>
"nnoremap <silent> <space>ft :Filetypes<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

function! SearchWordWithRgW()
  execute 'Rgw' expand('<cword>')
endfunction

function! SearchVisualSelectionWithRg() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Rg' selection
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
" Gutentags
" -----------------------------------------------
let g:gutentags_enabled = 0


" -----------------------------------------------
" EasyAlign
" -----------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" -----------------------------------------------
" Lightline
" -----------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], ['cocstatus', 'fugitive', 'filename' ]]
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
      \   'cocstatus': 'coc#status'
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
" let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsExpandTrigger="<c-y>"
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
let g:vim_json_syntax_conceal = 0

" =======================================================================
" More Customization
" =======================================================================

" -----------------------------------------------
" Restore Last Position
" -----------------------------------------------
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" -----------------------------------------------
"  Man Page
" -----------------------------------------------
" nnoremap M :Man<CR>

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
nnoremap <F7> :%!python -m json.tool<CR>
" nnoremap <F8> :TagbarToggle<CR>
nnoremap <F8> :Vista!!<CR>
nnoremap <F9> :NERDTreeToggle<CR>

nnoremap <leader><space> :noh<cr>
" nnoremap <tab> %
" vnoremap <tab> %
" nnoremap <tab>   <c-w>w
" nnoremap <S-tab> <c-w>W
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

autocmd FileType json syntax match Comment +\/\/.\+$+

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
