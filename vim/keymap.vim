"" KEYBOARD MAPPINGS

" jj as Escape
inoremap jj <Esc>
" move and edit soft tabs as hard tabs
nnoremap <silent> h :VagueSofttabLeft<CR>
nnoremap <silent> l :VagueSofttabRight<CR>
nnoremap <silent> x :VagueSofttabBS<CR>
nnoremap <silent> X :VagueSofttabDelete<CR>

"" VIM Leader Map

" Define prefix dictionary
let g:which_key_map = {}

"" Keymaps begin with Q
"" qq & qQ is defined at defaults.vim
let g:which_key_map.q = { 'name': 'Quit',
    \ 'q': ['q', 'Quit'],
    \ 'Q': ['q!', 'Quit Forcibly'],
\ }

"" Keymaps begin with W
"" ww and wq is defined at defaults.vim
nnoremap <Leader>wW :<C-u>w!<CR>
nnoremap <silent> <Leader>wr :<C-u>source<Space>~/.vim/vimrc<CR>:<C-u>noh<CR>
let g:which_key_map.w = { 'name': 'Write',
    \ 'w': ['w', 'Write'],
    \ 'W': ['w!', 'Write Forcibly'],
    \ 'q': ['wq', 'Write & Quit VIM'],
    \ 'r': ['source ~/.vim/vimrc', 'Reload VIMRC'],
\ }

"" Keymaps begin with E
nnoremap <silent> <Leader>ee :<C-u>VagueToggleFocusLoclist<CR>
nnoremap <silent> <Leader>ei :<C-u>VagueToggleOpenLoclist<CR>
let g:which_key_map.e = { 'name': 'Error',
    \ 'e': ['VagueToggleFocusLoclist', 'Focus Error'],
    \ 'i': ['VagueToggleOpenLoclist', 'Open Error'],
\ }

"" Keymaps begin with R
nnoremap <silent> <Leader>rr :<C-u>VagueToggleFocusQuickfix<CR>
nnoremap <silent> <Leader>ri :<C-u>VagueToggleOpenQuickfix<CR>
nnoremap <silent> <Leader>rh :<C-u>VagueToggleOpenLspHover<CR>
nnoremap <silent> <Leader>rt :<C-u>LspReferences<CR>
nnoremap <silent> <Leader>rg :<C-u>LspDefinition<CR>
let g:which_key_map.r = { 'name': 'Reference',
    \ 'r': ['VagueToggleFocusQuickfix', 'Focus Reference'],
    \ 'i': ['VagueToggleOpenQuickfix', 'Open Reference'],
    \ 'h': ['VagueToggleOpenLspHover', 'Hover Reference'],
    \ 't': ['LspReferences', 'This Word → Reference'],
    \ 'g': ['LspDefinition', 'Go to Definition'],
\ }

"" Keymaps begin with T
nnoremap <silent> <Leader>tt :<C-u>Buffers<CR>
nnoremap <silent> <Leader>tq :<C-u>bdelete<CR>
nnoremap <silent> <Leader>th :<C-u>bprevious<CR>
nnoremap <silent> <Leader>tj :<C-u>bfirst<CR>
nnoremap <silent> <Leader>tk :<C-u>blast<CR>
nnoremap <silent> <Leader>tl :<C-u>bnext<CR>
let g:which_key_map.b = { 'name': 'Tab',
    \ 't': ['Buffers', 'Tabs'],
    \ 'q': ['bdelete', 'Close Tab'],
    \ 'h': ['bprevious', '← Tab'],
    \ 'j': ['bfirst', 'First Tab'],
    \ 'k': ['blast', 'Last Tab'],
    \ 'l': ['bnext', '→ Tab'],
\ }

"" Keymaps begin with S
nnoremap <Leader>ss :<C-u>BLines <C-r><C-w><CR>
nnoremap <Leader>st :<C-u>Lines <C-r><C-w><CR>
nnoremap <Leader>sf :<C-u>Ag <C-r><C-w><CR>
let g:which_key_map.s = { 'name': 'Search',
    \ 's': ['BLines', 'Search this word from current'],
    \ 't': ['Lines', 'Search this word from buffers'],
    \ 'f': ['Ag', 'Search this word from files'],
\ }

"" Keymaps begin with F
nnoremap <silent> <Leader>ff :<C-u>Files<CR>
nnoremap <silent> <Leader>fn :<C-u>GFiles<CR>
nnoremap <silent> <Leader>fo :<C-u>GFiles?<CR>
let g:which_key_map.f = { 'name': 'File',
    \ 'f': ['Files', 'Find File'],
    \ 'n': ['GFiles', 'Find File (gitignore concerned)'],
    \ 'o': ['GFiles?', 'Find File (changed)'],
\ }

"" Keymaps begin with G
nnoremap <Leader>gg gg
nnoremap <Leader>gG G
let g:which_key_map.g = { 'name': 'Go',
    \ 'g': ['gg', 'Go to Top'],
    \ 'G': ['G', 'Go to Bottom'],
\ }

"" Keymaps begin with Z
nnoremap <silent> <Leader>zz :<C-u>Goyo<CR>
let g:which_key_map.z = { 'name': 'Zen',
    \ 'z': ['Goyo', 'Zen Mode'],
\ }

"" Keymaps begin with C
"" cc is defined at defaults.vim
nnoremap <silent> <Leader>co :<C-u>Colors<CR>
let g:which_key_map.c = { 'name': 'Color',
    \ 'c': ['noh', 'Clear Hilight Color'],
    \ 'o': ['Colors', 'Change Color Scheme'],
\ }

"" Keymaps begin with U
"" uu is defined at defaults.vim
let g:which_key_map.u = { 'name': 'Undo',
    \ 'u': ['undo', 'Undo'],
\ }

"" Keymaps begin with H
nnoremap <silent> <Leader>hh :<C-u>VagueMoveLeft<CR>
nnoremap <silent> <Leader>he :<C-u>Helptags<CR>
let g:which_key_map.h = { 'name': '← Move',
    \ 'h': ['VagueMoveLeft', '← Move'],
    \ 'e': ['Helptags', 'Help'],
\ }

"" Keymaps begin with J
nnoremap <silent> <Leader>jj :<C-u>VagueMoveDown<CR>
let g:which_key_map.j = { 'name': '↓ Move',
    \ 'j': ['VagueMoveDown', '↓ Move'],
\ }

"" Keymaps begin with K
nnoremap <silent> <Leader>kk :<C-u>VagueMoveUp<CR>
let g:which_key_map.k = { 'name': '↑ Move',
    \ 'k': ['VagueMoveUp', '↑ Move'],
\ }

"" Keymaps begin with L
nnoremap <silent> <Leader>ll :<C-u>VagueMoveRight<CR>
let g:which_key_map.l = { 'name': '→ Move',
    \ 'l': ['VagueMoveRight', '→ Move'],
\ }

"" Keymaps begin with N
nnoremap <silent> <Leader>nn :<C-u>set relativenumber!<CR>
let g:which_key_map.n = { 'name': 'Number',
    \ 'n': ['relativenumber!', 'Toggle Relative Line Number'],
\ }

"" setup WhichKey
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<C-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<C-u>Whichkey ','<CR>
vnoremap <silent> <leader> :<C-u>WhichKeyVisual '<Space>'<CR>
set timeoutlen=500
let g:which_key_sep = ':'
