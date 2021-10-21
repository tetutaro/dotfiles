"" Plugins
call plug#begin(expand('~/.vim/plugged'))
" Interface
Plug 'airblade/vim-rooter'
"Plug 'hecal3/vim-leader-guide'
Plug 'liuchengxu/vim-which-key'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Visualize
Plug 'Yggdroot/indentLine'
Plug 'ntpeters/vim-better-whitespace'
Plug 'luochen1990/rainbow'
Plug 'airblade/vim-gitgutter'
" Zen Mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
" Python
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'plytophogy/vim-virtualenv'
" Language Server
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'w0rp/ale'
" Original Plugins
Plug 'tetutaro/vague-move.vim'
Plug 'tetutaro/vague-input-python.vim'
Plug 'tetutaro/vague-input-markdown.vim'
" Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'Wildog/airline-weather.vim'
call plug#end()

"" settings for Status Line
" COMMAND mode
" INSERT mode
" INSERT COMPLETION mode
" INSERT COMPLETION mode
" NORMAL mode
" NORMAL mode
" OPERATION PENDING mode
" REPLACE mode (R in n)
" VIRTUAL REPLACE mode (gR in n)
" SELECT mode (gh in n, ^G in v)
" SELECT-LINE mode (gH in n, ^G in V)
" SELECT-BLOCK mode (g^H in n, ^G in ^V)
" VIRTUAL mode
" VIRTUAL-LINE mode
" VIRTUAL-BLOCK mode
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'c'  : 'c',
    \ 'i'  : 'i',
    \ 'ic' : 'ic',
    \ 'ix' : 'ix',
    \ 'n'  : 'n',
    \ 'ni' : 'ni',
    \ 'no' : 'o',
    \ 'R'  : 'R',
    \ 'Rv' : 'vR',
    \ 's'  : 's',
    \ 'S'  : 'S',
    \ '' : '^S',
    \ 'v'  : 'v',
    \ 'V'  : 'V',
    \ '' : '^V',
\ }
let g:airline_theme = 'tomorrow'
let g:airline_powerline_fonts = 0
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#show_line_numbers = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_count = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = ' '
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
"let g:airline#extensions#whitespace#checks = ['trailing']
"let g:airline#extensions#whitespace#trailing_format = 'T:%s'
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#readonly#enabled = 1
let g:airline_section_z = airline#section#create([
    \ 'windowswap', '%3p%%', 'linenr', ':%2v'
\ ])
let g:airline_symbols = get(g:, 'airline_symbols', {})
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = ' '
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
" use octicons font
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'
" airline weather
"let g:weather#area = 'Sapporo,JP'
"let g:weather#unit = 'metric'
"let g:weather#appid = 'XXXXXXXX'
"let g:weather#cache_file = '~/.cache/.weather'
"let g:weather#cache_ttl = '3600'
"" use wearther font
let g:weather#format = '%s %.0f'
let g:weather#status_map = {
    \ "01d": " ",
    \ "02d": " ",
    \ "03d": " ",
    \ "04d": " ",
    \ "09d": " ",
    \ "10d": " ",
    \ "11d": " ",
    \ "13d": " ",
    \ "50d": " ",
    \ "01n": " ",
    \ "02n": " ",
    \ "03n": " ",
    \ "04n": " ",
    \ "09n": " ",
    \ "10n": " ",
    \ "11n": " ",
    \ "13n": " ",
    \ "50n": " ",
\}
