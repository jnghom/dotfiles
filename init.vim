"== Basic ======================================================================
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

set shiftwidth=4
set tabstop=4
set scrolloff=4
set textwidth=80

set encoding=utf-8
set guifont=Sauce\ Code\ Pro\ Nerd\ Font\ Complete\ Mono\ 11

set laststatus=2
set showtabline=2

let mapleader = ','
let g:mapleader = ','

"== Last Position ==============================================================
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

"== Easier split navigations ===================================================
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"== Plugins ====================================================================
call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/seoul256.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'sheerun/vim-polyglot'
Plug 'ntpeters/vim-better-whitespace'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'easymotion/vim-easymotion'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-sleuth'
Plug 'Shougo/neoyank.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'zchee/deoplete-jedi'
Plug 'wellle/tmux-complete.vim'
Plug 'Konfekt/FastFold'
Plug 'mhinz/vim-startify'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/vim-mark'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'mhinz/vim-galore'
Plug 'nhooyr/neoman.vim'
Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'wesleyche/SrcExpl'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'mileszs/ack.vim'
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'
Plug 'pbogut/fzf-mru.vim'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-dispatch'
Plug 'lambdalisue/gina.vim'
Plug 'jreybert/vimagit'
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'ndmitchell/ghcid', { 'for': 'haskell', 'rtp': 'plugins/nvim' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'obxhdx/vim-auto-highlight'
Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs', 'frozen':1, 'do': 'cd omnisharp-roslyn && ./build.sh' }
Plug 'astralhpi/deoplete-omnisharp', { 'for': 'cs', 'frozen':1 }
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }

Plug 'KabbAmine/zeavim.vim', {'on': [
            \   'Zeavim', 'Docset',
            \   '<Plug>Zeavim',
            \   '<Plug>ZVVisSelection',
            \   '<Plug>ZVKeyDocset',
            \   '<Plug>ZVMotion'
            \ ]}
Plug 'editorconfig/editorconfig-vim'
Plug 'moll/vim-node'
Plug 'taohex/lightline-buffer'
Plug 'zchee/deoplete-clang', {'for': 'c'}
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function' " af/if and aF/iF for a function / extensible
Plug 'sgur/vim-textobj-parameter' " a,/i, : argument
Plug 'kana/vim-textobj-indent' " ai/ii : similarly indent, aI/iI : same indent block
Plug 'Julian/vim-textobj-variable-segment' " av/iv : _ or camelCase
Plug 'kana/vim-textobj-line' " al/il : current line

call plug#end()

"== Colors =====================================================================
set background=dark
let g:seoul256_background = 236
colo seoul256

"== Tags =======================================================================
set tagstack
set nocscopetag

"===============================================================================
" Deoplete
"===============================================================================

let g:deoplete#enable_at_startup = 1

let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
let g:deoplete#sources#clang#std#c = 'c11'
let g:deoplete#sources#clang#std#cpp = 'c++1z'
let g:deoplete#sources#clang#sort_algo = 'priority'

"===============================================================================
" Fugitive
"===============================================================================

nnoremap <Leader>gb :Gblame<cr>
nnoremap <Leader>gc :Gcommit<cr>
nnoremap <Leader>gd :Gdiff<cr>
nnoremap <Leader>gp :Git push<cr>
nnoremap <Leader>gr :Gremove<cr>
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gw :Gwrite<cr>
" Quickly stage, commit, and push the current file. Useful for editing .vimrc
nnoremap <Leader>gg :Gwrite<cr>:Gcommit -m 'update'<cr>:Git push<cr>

"===============================================================================
" FZF
"===============================================================================

command! -bang -nargs=* Agw call fzf#vim#ag(<q-args>, '-w', <bang>0)

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
nnoremap <silent> <space>/       :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> K              :call SearchWordWithAgW()<CR>
vnoremap <silent> K              :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent> <space>C       :Commits<CR>
nnoremap <silent> <space>c       :BCommits<CR>
nnoremap <silent> <space>m       :FZFMru<CR>
nnoremap <silent> <space>M       :Marks<CR>
"nnoremap <silent> <space>ft :Filetypes<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

function! SearchWordWithAg()
  execute 'Ag' expand('<cword>')
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

"===============================================================================
" GGtagsCscope
"===============================================================================
let GtagsCscope_Auto_Load = 0
let GtagsCscope_Auto_Map = 0
let GtagsCscope_Quiet = 0

"===============================================================================
" indent_guides
"===============================================================================
let g:indent_guides_enable_on_vim_startup = 0

"===============================================================================
" Gutentags
"===============================================================================
let g:gutentags_project_root = ['.mprj']
let g:gutentags_add_default_project_roots = 1

"===============================================================================
" EasyAlign
"===============================================================================

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"===============================================================================
" Lightline
"===============================================================================
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ]]
      \ },
      \ 'component_expand': {
      \   'buffercurrent': 'lightline#buffer#buffercurrent2',
      \ },
      \ 'component_type': {
      \   'buffercurrent': 'tabsel',
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
      \ 'tabline': {
      \   'left': [ [ 'bufferinfo' ], [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
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
"===============================================================================
" Cscope
"===============================================================================
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"===============================================================================
" Ack
"===============================================================================
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"===============================================================================
" Ultisnips
"===============================================================================

"===============================================================================
" Tagbar
"===============================================================================

let g:tagbar_width = 60

"===============================================================================
" Rooter
"===============================================================================
let g:rooter_manual_only = 1
let g:rooter_use_lcd = 1
"===============================================================================
"
"===============================================================================
" OmniSharp
"===============================================================================
let g:OmniSharp_server_type = 'v1'
let g:OmniSharp_server_type = 'roslyn'

let g:OmniSharp_selector_ui = 'fzf'    " Use fzf.vim
"===============================================================================

nmap <F7> :SrcExplToggle<CR>
nmap <F8> :TagbarToggle<CR>
nmap <F9> :NERDTreeToggle<CR>

set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,nbsp:␣
set showbreak=↪

" coming home to vim
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
noremap ; :
" save when lost focus
au FocusLost * :wa

highlight ExtraWhitespace ctermbg=52

"strip all trailing whitespace
nnoremap <F4> :%s/\s\+$//<cr>:let @/=''<CR>
"re-hardwrap paragraphs of text
nnoremap <leader>q gqip

nnoremap <leader>ev <C-w><C-v><C-l>:e ~/.config/nvim/init.vim<cr>
nnoremap <leader>w <C-w>v<C-w>l

" Open help vertically
autocmd FileType help wincmd L

" <Leader>cd: Switch to the directory of the open buffer
nnoremap <Leader>cd :cd %:p:h<cr>:pwd<cr>

" Keep working directory same as file's
" set autochdir
"autocmd BufEnter * silent! lcd %:p:h

" Clone Paragraph with cp
noremap cp yap<S-}>p

" Toggle Paste Mode
"set pastetoggle=<leader>z
set pastetoggle=<F2>

set wildmode=longest,list,full
set wildmenu

nnoremap tn :tnext<CR>
nnoremap tp :tprev<CR>
nnoremap ]n :tabnext<CR>
nnoremap [p :tabprev<CR>
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>

nnoremap M :Man<CR>

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

set updatetime=750

function! HighlightWordUnderCursor()
    if getline(".")[col(".")-1] !~# '\W'
        exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/'
    else
        match none
    endif
endfunction

autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()
