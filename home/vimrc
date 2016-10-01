"      ___                       ___           ___           ___
"     /\__\          ___        /\__\         /\  \         /\  \
"    /:/  /         /\  \      /::|  |       /::\  \       /::\  \
"   /:/  /          \:\  \    /:|:|  |      /:/\:\  \     /:/\:\  \
"  /:/__/  ___      /::\__\  /:/|:|__|__   /::\~\:\  \   /:/  \:\  \
"  |:|  | /\__\  __/:/\/__/ /:/ |::::\__\ /:/\:\ \:\__\ /:/__/ \:\__\
"  |:|  |/:/  / /\/:/  /    \/__/~~/:/  / \/_|::\/:/  / \:\  \  \/__/
"  |:|__/:/  /  \::/__/           /:/  /     |:|::/  /   \:\  \
"   \::::/__/    \:\__\          /:/  /      |:|\/__/     \:\  \
"    ~~~~         \/__/         /:/  /       |:|  |        \:\__\
"                               \/__/         \|__|         \/__/

" Encoding {{{
set encoding=utf-8
scriptencoding utf-8
" }}}
if &compatible
  set nocompatible               " Be iMproved
endif

"autogroup をリセット {{{
augroup MyAutoGroup
  autocmd!
augroup END
" }}}

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')

function! IsWindows() abort
  return s:is_windows
endfunction

function! IsMac() abort
  return !s:is_windows && !s:is_cygwin
        \ && (has('mac') || has('macunix') || has('gui_macvim') ||
        \   (!executable('xdg-open') &&
        \     system('uname') =~? '^darwin'))
endfunction

" vim-plug でプラグインを管理 {{{
" 要git
" Windows の場合「Use Git from the Windows Command Prompt」でインストールする
if has('vim_starting')
  if has('win32') || has ('win64')
    set rtp+=~/.vim/plugged/vim-plug
    if !isdirectory(expand('~/.vim/plugged/vim-plug'))
      echo 'installed vim-plug...'
      call system('mkdir -p %USERPROFILE%/.vim/plugged/vim-plug')
      call system('git clone https://github.com/junegunn/vim-plug.git %USERPROFILE%/.vim/plugged/vim-plug/autoload')
    end
  endif
  if has('mac')
    set rtp+=~/.vim/plugged/vim-plug
    if !isdirectory(expand('~/.vim/plugged/vim-plug'))
      echo 'installed vim-plug...'
      call system('mkdir -p ~/.vim/plugged/vim-plug')
      call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
    end
  endif
endif
" }}}

" 不要なデフォルトプラグインを無効化 {{{
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_matchparen        = 1
let g:loaded_LogiPat           = 1
let g:loaded_logipat           = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_man               = 1
let g:loaded_matchit           = 1
" }}}

" ##### 基本設定 ##### {{{

" ファイル関連 {{{
set autoread     "外部でファイルが更新されたらオートロード
set noswapfile   "スワップファイルを作らない
set nobackup     "バックアップファイルを作らない
syntax on        "シンタックスハイライトする
set noundofile   "アンドゥーセッションファイルを作らない
" }}}

" 表示関連 {{{
syntax enable
set background=dark

" インサートモードでカーソルを棒状に
if has('nvim')
  :let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif
if has('mac') && has('kaoriya')
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
endif

" カーソル行の強調
if has("autocmd")
  autocmd WinEnter    * set cursorline
  autocmd BufRead     * set cursorline
  autocmd WinLeave    * set nocursorline
  autocmd InsertEnter * set nocursorline
  autocmd InsertLeave * set cursorline
endif

set number            "行番号を表示する
set visualbell        "ビープ音を抑制
set vb t_vb=          "画面フラッシュも止める
set ambiwidth=double  "全角記号対策
set notitle           "編集中のファイル名を表示しない
set showmatch         "閉じ括弧の入力時に対応する括弧を表示する
set matchtime=1       "showmatchの表示時間
set cpoptions-=m
set laststatus=2      "ステータスラインを常に表示する
set cmdheight=2       "コマンドラインを2行に
set showcmd           "入力中のコマンドを表示する
set ruler             "座標を表示する

set formatexpr=autofmt#japanese#formatexpr()
" オペレーション系 {{{
" キーマップのタイムアウトを設定
set timeout timeoutlen=3000 ttimeoutlen=100
set iminsert=0                  "入力モードで自動的にIMEがオンになるのを抑制
set formatoptions=q             "自動改行を抑制
set mouse=a                     "ターミナルでマウスを利用する
set scrolloff=8                 "上下8行の余裕を持たせてスクロール
set whichwrap+=h,l,<,>,[,],b,s  "行をまたいで移動可能
set virtualedit=block           "矩形ビジュアルモードをブロック表示に

" ESCで確実にIMEをオフにする
inoremap <ESC> <ESC>:set iminsert=0<CR>

" 削除でレジスタに格納しない(ビジュアルモードでは格納する)
nnoremap x "_x
nnoremap X "_X
"}}}

" 補完 {{{
set wildmenu                    " コマンド入力をタブで補完
set wildchar=<Tab>              " コマンド補完を開始するキー
set wildmode=list:longest,full  " 補完動作（リスト表示で最長一致、その後選択）
set history=1000                " コマンドの履歴数
set infercase                   " 補完時に大文字小文字を区別しない
" }}}

" .md ファイルを markdownとして扱う
au BufRead,BufNewFile *.md set filetype=markdown

" 不可視文字を表示
set list
set listchars=tab:>-
"}}}

" インデント関連 {{{
set expandtab     "TABをスペースに
set autoindent    "自動インデントを有効
set smartindent   "適切にインデントを調整
" set tabstop=2     "TABの幅
" set shiftwidth=2  "自動インデントの幅
" set softtabstop=0 "連続した空白に対してTABやBSで移動する量(0の場合はtabstopと同じ値)
set shiftround    "インデントを'shiftwidth'の倍数に丸める
set modeline      "モードラインを有効化

if !has('vim_starting')
"ファイルタイプの検索を有効にする
  filetype plugin on
"そのファイルタイプにあわせたインデントを利用する
  filetype indent on

"  autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
"  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
"  autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
"  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
"  autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
"  autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
"  autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
"  autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
"  autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
"  autocmd FileType sh         setlocal sw=4 sts=4 ts=4 et
"  autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
"  autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
"  autocmd FileType xhtml      setlocal sw=4 sts=4 ts=4 et
"  autocmd FileType xml        setlocal sw=4 sts=4 ts=4 et
"  autocmd FileType zsh        setlocal sw=4 sts=4 ts=4 et
endif

" ソフトラップもインデント
set wrap           "ソフトラップを有効に
set linebreak      "ブラケットや区切り文字で折り返し
"set breakat=\     "折り返し文字の設定 (default " ^I!@*-+;:,./?")
set showbreak=+\   "折り返し行の先頭に表示
if (v:version == 704 && has("patch338")) || v:version >= 705
  set breakindent  "ソフトラップをインデント
  " breakindent option
  " autocmd is necessary when new file is opened in Vim
  " necessary even for default(min:20,shift:0)
  autocmd MyAutoGroup BufEnter * set breakindentopt=min:20,shift:0
endif
" }}}

" 検索関連 {{{
set hlsearch     " 検索文字列をハイライトする
set incsearch    " インクリメンタルサーチを行う
set noignorecase " 小文字で入力すると大文字と小文字を区別しない
set smartcase    " 大文字が含まれると大文字小文字を区別
set wrapscan     " 循環検索
set gdefault     " 置換で g オプションをデフォルトにする
"esc連打でハイライトをオフ
nnoremap <silent> <ESC><ESC> :noh<CR>
" }}}

" 削除 {{{
set backspace=indent,eol,start  " BS でindent,改行,挿入開始前を削除
set smarttab                    " BS でインデント幅を削除
" }}}

" 折りたたみ関連 {{{
set foldenable
" set foldmethod=expr
set foldmethod=marker
" Show folding level.
set foldcolumn=1
set fillchars=vert:\|
set commentstring=%s

if exists('*FoldCCtext')
  " Use FoldCCtext().
  set foldtext=FoldCCtext()
endif
" }}}

" バグ対策 {{{
" 日本語のヘルプファイルを開くとループして固まる
if v:version < 703 || (v:version == 7.3 && !has('patch336'))
   set notagbsearch
endif
" }}}

set keywordprg=:help
set helplang& helplang=ja

" }}}

 " ファイル保存時に行末のスペースを削除する
 " ただしマークダウンファイルを除く
let g:does_remove_trailing_white_space = 1
au MyAutoGroup BufWritePre * call s:removeTrailingWhiteSpace()
func! s:removeTrailingWhiteSpace()
  if &ft != 'markdown' && g:does_remove_trailing_white_space == 1
    :%s/\s\+$//ge
  endif
endf

highlight TrailingSpaces ctermbg=magenta guibg=#FF0000
au BufNewFile,BufRead * call matchadd('TrailingSpaces', ' \{-1,}$')

" ##### FileType ##### {{{
autocmd MyAutoGroup FileType,Syntax,BufNewFile,BufNew,BufRead
      \ * call s:my_on_filetype()
function! s:my_on_filetype() abort
  if &l:filetype == '' && bufname('%') == ''
    return
  endif

  redir => filetype_out
  silent! filetype
  redir END
  if filetype_out =~# 'OFF'
    " Lazy loading
    silent! filetype plugin indent on
    syntax enable
    filetype detect
  endif
endfunction
call s:my_on_filetype()
" }}}

" ##### キーマップ ##### {{{
" 共通

" スペースにLeaderキーを割当
let mapleader = "\<Space>"

" Visualモード {{{
" <TAB>: indent.
xnoremap <TAB>  >
" <S-TAB>: unindent.
xnoremap <S-TAB>  <

" インデント
nnoremap > >>
nnoremap < <<
" xnoremap > >gv
" xnoremap < <gv
"}}}

" insertモード {{{
" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> っｊ <ESC>`^
inoremap <silent> kk <ESC>
inoremap <silent> っｋ <ESC>`^

"inoremap <Leader><Leader> <Space>
" intertモードでのカーソル移動
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>
" }}}

"行頭/行末移動
noremap gh  ^
noremap gl  $
inoremap <Leader>h <HOME>
inoremap <Leader>l <END>
"tabの入力
inoremap <C-t> <C-v><TAB>
" undo <C-w> and <C-u>.
inoremap <C-w>  <C-g>u<C-w>
inoremap <C-u>  <C-g>u<C-u>
" <Space>pと<Space>yでシステムのクリップボードにコピー＆ペーストする
nmap <Leader>y "+y
vmap <Leader>y "+y
nmap <Leader>p "+p
vmap <Leader>p "+p

"ノーマルモード {{{
"ノーマルモード中にEnterで改行
noremap <CR> i<CR><Esc>

" 大文字小文字を切り替え
nnoremap gu g~iw`]

" ZZ を無効化
nnoremap ZZ  <Nop>
" }}}
" 折りたたみ関連 {{{
" If press h on head, fold close.
"nnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zc' : 'h'
" l で折りたたみを開く
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
" If press h on head, range fold close.
"xnoremap <expr> h col('.') == 1 && foldlevel(line('.')) > 0 ? 'zcgv' : 'h'
" l で折りたたみを開く
xnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'
"}}}
" }}}


























" インストールするプラグイン {{{
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-plug',
      \ {'dir': '~/.vim/plugged/vim-plug/autoload'}
Plug 'yegappan/mru'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'thinca/vim-splash'
  let g:splash#path = $HOME . '/.config/nvim/rc/vimgirl.txt'
Plug 'altercation/vim-colors-solarized'


Plug 'itchyny/lightline.vim'
  let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFilename'
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-operator-user'
Plug 'vim-jp/autofmt'
Plug 'vim-jp/vimdoc-ja'
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'thinca/vim-ft-diff_fold', { 'for': 'diff' }
Plug 'thinca/vim-ft-help_fold', { 'for': 'help' }
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'Shougo/echodoc.vim', { 'on': 'CompleteDone', 'do': 'call echodoc#enable()' }
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/neco-vim', { 'for': 'vim' }
Plug 'Shougo/neoinclude.vim', { 'on': 'InsertEnter' }





Plug 'nathanaelkane/vim-indent-guides'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-expand-region'
Plug 'Shougo/unite-outline'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'kana/vim-smartword'
Plug 'easymotion/vim-easymotion'
Plug 'bronson/vim-trailing-whitespace'

if has('mac')
  Plug 'itspriddle/vim-marked'
endif

" colorscheme
Plug 'nanotech/jellybeans.vim'
Plug 'w0ng/vim-hybrid'
Plug 'junegunn/seoul256.vim'
Plug 'altercation/vim-colors-solarized'

call plug#end()
" }}}


let g:solarized_termtrans=1
colorscheme solarized
" ################################# プラグインの設定 #################################

" EasyMotion {{{
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_startofline = 0
let g:EasyMotion_keys = 'QZASDFGHJKL'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_use_migemo = 0
" }}}

"unite.vim {{{
"インサートモードで開始
let g:unite_enable_start_insert = 1
"ヒストリー/ヤンク機能を有効化
let g:unite_source_history_yank_enable =1
"file_recのキャッシュの最小値/最大値を設定
let g:unite_source_rec_min_cache_files = 100
let g:unite_source_rec_max_cache_files = 5000
"prefix keyの設定
nmap <Space> [unite]
"スペースキーとaキーでVimShellを起動
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"スペースキーとfキーでバッファと最近開いたファイル一覧を表示
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>
"スペースキーとdキーで最近開いたディレクトリを表示
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
"スペースキーとhキーでヒストリ/ヤンクを表示
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
"スペースキーとoキーでoutline
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>
"スペースキーとENTERキーでfile_rec:!
nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec:!<CR>
"unite.vimを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()

" vim-expand-region {{{
    vmap v <Plug>(expand_region_expand)
    vmap <C-v> <Plug>(expand_region_shrink)

let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i]'  :1,
      \ 'ib'  :1,
      \ 'iB'  :1,
      \ 'il'  :1,
      \ 'ip'  :0,
      \ 'ie'  :1,
      \ }
" }}}

" vim-trailing-whitespace {{{
let g:extra_whitespace_ignored_filetypes = ['unite']
" ファイル保存時に行末のスペースを削除する
" ただしマークダウンファイルを除く
fun! StripTrailingWhiteSpace()
  " don't strip on these filetypes
  if &ft =~ 'markdown'
    return
  endif
  :FixWhitespace
endfun
autocmd bufwritepre * :call StripTrailingWhiteSpace()
" }}}


" vim-smartword {{{
" wやeでの単語移動を賢く
  map w <Plug>(smartword-w)
  map b <Plug>(smartword-b)
  map e <Plug>(smartword-e)
  map ge <Plug>(smartword-ge)
" }}}

" tcomment {{{
" Space + / コメントをトグル
nmap <Leader>/ <C-_><C-_>
vmap <Leader>/ <C-_><C-_>

if !exists( 'g:tcomment_types' )
  let g:tcomment_types = {}
endif
let g:tcomment_types = {
  \'php_surround' : "<?php %s ?>",
  \'php_surround_echo' : "<?php echo %s ?>"
\}
au FileType php imap <buffer><C-_>c :TCommentAs php_surround<CR>
au FileType php imap <buffer><C-_>= :TCommentAs php_surround_echo<CR>
au FileType php imap <buffer><C-_>e :TCommentAs php_surround_echo<CR>
" }}}

" marked.vim {{{
if has('mac')
  let g:marked_app = "Marked 2"
endif
" }}}
