
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

Plug 'honza/vim-snippets'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  " Plug 'junegunn/fzf.vim', Cond(executable('fzf'))
  Plug 'pbogut/fzf-mru.vim', Cond(executable('fzf'))
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
elseif v:version == 800
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'Shougo/deoplete.nvim'
endif
Plug 'ntpeters/vim-better-whitespace'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar', Cond(executable('ctags'))
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'easymotion/vim-easymotion'
Plug 'nathanaelkane/vim-indent-guides'
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
Plug 'Yggdroot/vim-mark'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'SirVer/ultisnips'
Plug 'itchyny/lightline.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'jreybert/vimagit'
Plug 'obxhdx/vim-auto-highlight'
Plug 'taohex/lightline-buffer'
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
Plug 'tpope/vim-unimpaired'
Plug 'jceb/vim-orgmode'
Plug 'ervandew/supertab'
Plug 'Shougo/echodoc.vim'
Plug 'neomake/neomake'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'matze/vim-move'
Plug 'junegunn/vim-slash'


Plug 'Shougo/neco-vim', { 'for': 'vim' }
Plug 'Shougo/neco-syntax', { 'for': 'vim' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'zchee/deoplete-jedi', Cond(vims ==# 'async', { 'for': 'python' })
Plug 'tweekmonster/deoplete-clang2', Cond(vims ==# 'async', {'for': 'c'})
" Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
call plug#end()

" Unused
" Plug 'trevordmiller/nova-vim'
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
" Plug 'w0rp/ale', Cond(vims ==# 'async')
" Plug 'Chiel92/vim-autoformat'
" Plug 'zchee/deoplete-clang', {'for': 'c'}
" Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
" Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
" Plug 'ndmitchell/ghcid', { 'for': 'haskell', 'rtp': 'plugins/nvim' }
" Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
" Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
" Plug 'moll/vim-node', { 'for': 'javascript' }
" Plug 'jeffkreeftmeijer/vim-numbertoggle'
" Plug 'chrisbra/NrrwRgn'
" Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': 'javascript' }
" Plug 'racer-rust/vim-racer', { 'for': 'rust' }
" Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }

"
colo seoul256
" colo nova


" =======================================================================
" Plugin Setting
" =======================================================================

" -----------------------------------------------
" Deoplete
" -----------------------------------------------

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1

" let g:deoplete#sources#jedi#python_path = '/home/mok/anaconda3/bin/python'
" let g:deoplete#sources#jedi#python_path = substitute(system('which python'), '\n', '', '')
let g:deoplete#sources#jedi#enable_cache = 1
let g:deoplete#sources#jedi#show_docstring = 1

let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
let g:deoplete#sources#clang#std#c = 'c11'
let g:deoplete#sources#clang#std#cpp = 'c++1z'
let g:deoplete#sources#clang#sort_algo = 'priority'

" Let <Tab> also do completion
inoremap <silent><expr> <Tab>
\ pumvisible() ? "\<C-n>" :
\ deoplete#mappings#manual_complete()

" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" autocmd InsertLeave * if pumvisible() == 0 | pclose | endif


" -----------------------------------------------
" jedi-vim
" -----------------------------------------------
let g:jedi#completions_enabled = 0
let g:jedi#auto_initialization = 1


" -----------------------------------------------
" Neomake
" -----------------------------------------------
let g:neomake_sh_enabled_markers = ['shellcheck']
let g:neomake_vim_enabled_markers = ['vint']
let g:neomake_c_enabled_markers = ['cppcheck', 'clangtidy', 'clang']
let g:neomake_cpp_enabled_markers = ['cppcheck']
" npm install jsonlint -g
let g:neomake_json_enabled_markers = ['jsonlint']
" let g:neomake_python_enabled_makers = ['flake8', 'pep8', 'vulture', 'pylint']
let g:neomake_python_enabled_makers = ['flake8', 'pep8', 'pylint']
" E111,E114 indent should be multiple of 4
let g:neomake_python_flake8_maker = {'args': ['--ignore=E111,E114,E115,E266,E501']}
let g:neomake_python_pep8_maker = {'args': ['--ignore=E111,E114,E115,E266,E501']}
let g:neomake_python_pylint_maker = {'args': ['--ignore=C0111']}

" autocmd! BufWritePost,BufEnter *.py,*.json Neomake
autocmd! BufWritePost,BufEnter * Neomake


" ale
      " \  'python': ['flake8', 'pylint', 'pep8', 'pycodestyle', 'mypy']
let g:ale_linters = {
      \  'python': ['flake8', 'pycodestyle']
      \}
let g:ale_fixers = {
      \  'python': ['autopep8', 'yapf', 'isort']
      \}
let g:ale_python_pylint_options= "--msg-template='{msg_id}:{line:3d},{column}: {obj}: {msg}'"

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%][%severity%] %s'
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

nnoremap <silent> <space><space> :Files<CR>
nnoremap <silent> <space>a       :Buffers<CR>
nnoremap <silent> <space>A       :Windows<CR>
nnoremap <silent> <space>;       :Lines<CR>
nnoremap <silent> <space>.       :BLines<CR>
nnoremap <silent> <space>T       :Tags<CR>
nnoremap <silent> <space>t       :BTags<CR>
nnoremap <silent> <space>?       :History<CR>
nnoremap <silent> <space>hs      :History/<CR>
nnoremap <silent> <space>hc      :History:<CR>
nnoremap <silent> <space>/       :execute 'Agp ' . input('Ag/')<CR>
nnoremap <silent> <space>//      :execute 'GGrep ' . input('GGrep/')<CR>
nnoremap <silent> **             :call SearchWordWithAgW()<CR>
vnoremap <silent> **             :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent> <space>C       :Commits<CR>
nnoremap <silent> <space>c       :BCommits<CR>
nnoremap <silent> <space>m       :FZFMru<CR>
nnoremap <silent> <space>M       :Marks<CR>
"nnoremap <silent> <space>ft :Filetypes<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

function! SearchWordWithAg()
  execute 'Agp' expand('<cword>')
endfunction

function! SearchWordWithAgW()
  execute 'Agw' expand('<cword>')
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


" -----------------------------------------------
" GGtagsCscope
" -----------------------------------------------
let GtagsCscope_Auto_Load = 0
let GtagsCscope_Auto_Map = 0
let GtagsCscope_Quiet = 0

" -----------------------------------------------
" indent_guides
" -----------------------------------------------
let g:indent_guides_enable_on_vim_startup = 0

" -----------------------------------------------
" Gutentags
" -----------------------------------------------
" let g:gutentags_project_root = ['.mprj']
" let g:gutentags_add_default_project_roots = 1

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
" Cscope
" -----------------------------------------------
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter *.c,*.cpp,*.h call LoadCscope()

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" -----------------------------------------------
" Ack
" -----------------------------------------------
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

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
" autocmd BufReadPost * :DetectIndent
" function! LoadDetectIndent()
"   if (empty(findfile(".editorconfig", expand('%:p:h') . ';')))
"     autocmd BufReadPost * :DetectIndent
"   endif
" endfunction
" autocmd BufReadPost * call LoadDetectIndent()

" -----------------------------------------------
"  Highlight Curwor Words
" -----------------------------------------------
let g:HiCursorWords_delay = 400

" -----------------------------------------------
"  Ranger
" -----------------------------------------------
let g:ranger_map_keys = 0
map <leader>f :Ranger<CR>.

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
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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
nnoremap <F5> :%s/\r/\r/g<CR>
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
