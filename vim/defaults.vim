"" STARTUP
if has('vim_starting')
    set nocompatible
endif

"" ENCODING
set encoding=utf-8  " ファイル読み込み時の文字コード
scriptencoding utf-8  " Vim script内でマルチバイト文字を使う場合の設定（vimrcを含む）
set fileencoding=utf-8  " 保存時の文字コード
set fileencodings=utf-8  " 読み込み時の文字コードの自動判別
set fileformats=unix,dos,mac  " 改行コードの自動判別
"set bomb  " BOMを付ける
"set binary  " バイナリモード

"" FILE
set nobackup  " ファイルを上書きする際にバックアップファイルを作らない
set noswapfile  " スワップファイルを使用しない
set hidden  " 保存しないで他のファイルを表示することが出来る
set autoread  " ファイルが変更されたら自動的に読み直す

"" INDENT
set expandtab  " タブを空白に置き換える
set tabstop=4  " 画面上でタブ文字が占める幅
set softtabstop=4  " 連続した空白に対して<Tab>,<Backspace>でカーソルが動く幅
set autoindent  " 改行時に前の行のインデントを継続する
set smartindent  " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4  " smartindentで増減する幅
" JSON, JavaScript, TypeScript, CSS, HTML, YAML はインデントを2にする
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.json,*.js,*.jsx,*.ts,*.tsx,*.css,*.html,*.yml,*.yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END
"" SEARCH
set incsearch  " インクリメンタルサーチ（１文字毎に検索を行う）
set ignorecase  " 検索パターンに大文字小文字を区別しない
set smartcase  " 検索パターンに大文字が含まれていたら大文字小文字を区別する
set wrapscan  " ファイルの末尾まで検索したらファイルの先頭へループする
set hlsearch  " 検索結果をハイライトする

"" CURSOR
set backspace=indent,eol,start  " <Backspace>で削除できるもの
set whichwrap=  " 改行を乗り越えられるコマンド
"set whichwrap=b,s,h,l,<,>,[,]

"" BEHAVIOR
set shortmess+=I  " 起動時のメッセージを消す
set timeout  " コマンド入力にタイムアウトを付ける
set timeoutlen=1000  " タイムアウトの長さ[ms]
set ttimeout  " INSERTモードからの切り替えにタイムアウトを付ける
set ttimeoutlen=50  " タイムアウトの長さ[ms]
set hidden  " バッファを切り替えてもundoの効力を失わない
set lazyredraw  " スクリプト実行中に画面を表示しない
set ttyfast  " 高速ターミナル接続を行う
set scrolloff=3  " スクロールする時にカーソルの上下に表示する最低限の行数
if has('unix')
    set clipboard=unnamedplus,autoselect  " OSのclipboardと共有
endif
if has('mac')
    set clipboard=unnamed,autoselect
endif
"set mouse=a  " すべてのモードでマウスを使う（ドラッグするとVisualモード）
set mouse=ni  " NORMALモードとINSERTモードでマウスでカーソル移動（ドラッグは無効）
set ttymouse=xterm2  " マウスで色々なことが出来るように
set mousefocus  " マウスの場所がフォーカスされる
set modeline  " モードライン（ファイルの先頭か一番下に書かれているvimの設定）を利用する
set modelines=0  " モードラインを読み込む行数（0 なので結局モードラインは使わない）
set splitright  " ウィンドウを分割する時に新しいウィンドウを右に作る
set splitbelow  " ウィンドウを分割する時に新しいウィンドウを下に作る
set virtualedit=block  " C-vの矩形選択で行末よりも後ろにもカーソルを置ける
set nofoldenable  " 折り畳まない
set diffopt=internal,filler,iwhiteall,iwhiteeol,vertical

"" DISPLAY
set linespace=0  " 行間を縮める
set showtabline=0  " タブバーを表示しない
set ambiwidth=single  " □や○など曖昧な幅の文字をどのように扱うか
set t_vb=
set visualbell  " エラー音の代わりに画面をフラッシュする
set noerrorbells  " エラーが出てもベルを鳴らさない
set number  " 行番号を表示する
set signcolumn=yes  " 行番号の所にガターを表示するスペースを開けておく
set notitle  " ウィンドウのタイトルを変更しない
set showmatch  " 対応する括弧を表示する
set wrap  " 行の折り返しをする
set nolist  " 不可視文字を表示しない

"" STATUS LINE
set cmdheight=1  " コマンドラインの行数
set laststatus=2  " ステータスラインを常に表示する
set showmode  " 現在のモードを表示
set noruler  " ステータスラインの右側にカーソルの位置を表示しない（下で補完）
"" CONTENTS OF STATUS LINE
set statusline=%F  " ファイル名表示
set statusline+=%m  " 変更チェック表示
set statusline+=%r  " 読み込み専用か表示
set statusline+=%h  " ヘルプページなら[HELP]と表示
set statusline+=%w  " プレビューウィンドウなら[Preview]と表示
set statusline+=%=  " 以降は右寄せ表示
" 文字コード表示
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
set statusline+=\ %y  " ファイルタイプ表示
" 行数,列数表示
set statusline+=\ (%l/%L,%c)

"" COLOR
syntax on  " シンタックスを有効にする
set t_Co=256  " 256色の設定にする
source $HOME/.vim/colors.vim  " カラースキーマを定義するファイルの読み込み
set cursorline  " カーソルラインをハイライトする
" カーソルラインの行全体をハイライトする
hi CursorLine ctermbg=233
" 検索結果のハイライトの色を変更する
hi Search ctermbg=22 ctermfg=174
" 挿入モードの時はカーソルラインのハイライトを消す
augroup ChangeCursorLineHilight
    autocmd!
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
    autocmd InsertEnter,InsertLeave * set cursorline!
augroup END
" 背景色を透過させる
"highlight Normal ctermbg=NONE guibg=NONE
"highlight NonText ctermbg=NONE guibg=NONE
"highlight SpecialKey ctermbg=NONE guibg=NONE
"highlight EndOfBuffer ctermbg=NONE guibg=NONE

"" IGNORE WRAP
"" j,kは折返しされた行も見た目通りに移動する
"" カーソルキーもしくは Ctrl-p,nは折返しを飛ばす
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

"" ALWAYS <Tab> AS INDENT
nnoremap <Tab> >>
nnoremap <S-Tab> <<
imap <S-Tab> <C-d>

"" KEYBINDINGS LIKE EMACS
"" move like Emacs in normal-mode
nnoremap <C-a> 0
nnoremap <C-e> $
nnoremap <C-f> l
nnoremap <C-b> h
"" move like Emacs in insert-mode
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-k> D
"" move like Emacs in visual-mode and select-mode
vnoremap <C-f> <Right>
vnoremap <C-b> <Left>
vnoremap <C-a> <Home>
vnoremap <C-e> <End>
"" yank area like Mac OSX in visual-mode
xnoremap c y
"" move like Emacs in command-mode
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-k> <C-\>estrpart(getcmdline(),0,getcmdpos()-1)<CR>

"" KEYBOARD SHORTCUTS LIKE SPACEMACS
"" Leader for shortcut commands
let g:mapleader = "\<Space>"
"" Quit, Cancel, Undo
nnoremap <Leader>qq :<C-u>q<CR>
nnoremap <Leader>qQ :<C-u>q!<CR>
nnoremap <silent> <Leader>cc :<C-u>noh<CR>
nnoremap <Leader>uu :<C-u>undo<CR>
"" File operations
nnoremap <Leader>ww :<C-u>w<CR>
nnoremap <Leader>wq :<C-u>wq<CR>

"" numerical operaions
nnoremap + <C-a>
nnoremap - <C-x>
