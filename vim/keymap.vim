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
nnoremap <Leader>wr :<C-u>source<Space>$HOME/.vim/vimrc<CR>:noh<CR>
let g:which_key_map.w = { 'name': 'Write',
    \ 'w': ['w', 'Write'],
    \ 'q': ['wq', 'Write & Quit VIM'],
    \ 'r': ['source $MYVIMRC', 'Reload VIMRC'],
\ }

"" Keymaps begin with E
nnoremap <Leader>ee :<C-u>VagueToggleFocusLoclist<CR>
nnoremap <Leader>ei :<C-u>VagueToggleOpenLoclist<CR>
nnoremap <Leader>ej <Plug>(ale_next_wrap)
nnoremap <Leader>ek <Plug>(ale_previous_wrap)
let g:which_key_map.e = { 'name': 'Error',
    \ 'e': ['VagueToggleFocusLoclist', 'Focus Error'],
    \ 'i': ['VagueToggleOpenLoclist', 'Open Error'],
    \ 'j': ['ale_next_wrap', '↓ Error'],
    \ 'k': ['ale_previous_wrap', '↑ Error'],
\ }

"" Keymaps begin with R
nnoremap <Leader>rr :<C-u>VagueToggleFocusQuickfix<CR>
nnoremap <Leader>ri :<C-u>VagueToggleOpenQuickfix<CR>
nnoremap <Leader>rh :<C-u>VagueToggleOpenLspHover<CR>
nnoremap <Leader>rt :<C-u>LspReferences<CR>
nnoremap <Leader>rg :<C-u>LspDefinition<CR>
let g:which_key_map.r = { 'name': 'Reference',
    \ 'r': ['VagueToggleFocusQuickfix', 'Focus Reference'],
    \ 'i': ['VagueToggleOpenQuickfix', 'Open Reference'],
    \ 'h': ['VagueToggleOpenLspHover', 'Hover Reference'],
    \ 't': ['LspReferences', 'This Word → Reference'],
    \ 'g': ['LspDefinition', 'Go to Definition'],
\ }

"" Keymaps begin with F
nnoremap <silent> <Leader>ff :<C-u>BLines <C-r><C-w><CR>
nnoremap <silent> <Leader>fg :<C-u>Lines <C-r><C-w><CR>
nnoremap <silent> <Leader>fa :<C-u>Ag <C-r><C-w><CR>
nnoremap <silent> <Leader>fn :<C-u>GFiles<CR>
nnoremap <silent> <Leader>fN :<C-u>Files<CR>
nnoremap <silent> <Leader>fo :<C-u>GFiles?<CR>
nnoremap <silent> <Leader>fb :<C-u>Buffers<CR>
nnoremap <silent> <Leader>fc :<C-u>Colors<CR>
nnoremap <silent> <Leader>fh :<C-u>bprevious<CR>
nnoremap <silent> <Leader>fj :<C-u>bfirst<CR>
nnoremap <silent> <Leader>fk :<C-u>blast<CR>
nnoremap <silent> <Leader>fl :<C-u>bnext<CR>
let g:which_key_map.f = { 'name': 'Find & File',
    \ 'f': ['BLines', 'Find this word from current buffer'],
    \ 'g': ['Lines', 'Find this word from buffers'],
    \ 'a': ['Ag', 'Find this word from files'],
    \ 'n': ['GFiles', 'Find file (gitignore concerned)'],
    \ 'N': ['Files', 'Find file'],
    \ 'o': ['GFiles?', 'Find file (changed)'],
    \ 'b': ['Buffers', 'Find buffer'],
    \ 'c': ['Colors', 'Find color scheme'],
    \ 'h': ['bprevious', '← Buffer'],
    \ 'j': ['bfirst', 'First Buffer'],
    \ 'k': ['blast', 'Last Buffer'],
    \ 'l': ['bnext', '→ Buffer'],
\ }

"" Keymaps begin with G
nnoremap <Leader>gg gg
nnoremap <Leader>gG G
let g:which_key_map.g = { 'name': 'Go',
    \ 'g': ['gg', 'Go to Top'],
    \ 'G': ['G', 'Go to Bottom'],
\ }

"" Keymaps begin with Z
"" zz is defined at defaults.vim
let g:which_key_map.z = { 'name': 'Cancel',
    \ 'z': ['undo', 'Undo'],
\ }

"" Keymaps begin with C
"" cc is defined at defaults.vim
nnoremap <Leader>cf :<C-u>Colors<CR>
let g:which_key_map.c = { 'name': 'Clear & Color',
    \ 'c': ['noh', 'Clear Hilight Color'],
    \ 'f': ['Colors', 'Change Color Scheme'],
\ }

"" Keymaps begin with B
nnoremap <Leader>bb :<C-u>Buffers<CR>
nnoremap <Leader>bc :<C-u>bdelete<CR>
nnoremap <silent> <Leader>bh :<C-u>bprevious<CR>
nnoremap <silent> <Leader>bj :<C-u>bfirst<CR>
nnoremap <silent> <Leader>bk :<C-u>blast<CR>
nnoremap <silent> <Leader>bl :<C-u>bnext<CR>
let g:which_key_map.b = { 'name': 'Buffer',
    \ 'b': ['Buffers', 'Buffers'],
    \ 'c': ['bdelete', 'Close Buffer'],
    \ 'h': ['bprevious', '← Buffer'],
    \ 'j': ['bfirst', 'First Buffer'],
    \ 'k': ['blast', 'Last Buffer'],
    \ 'l': ['bnext', '→ Buffer'],
\ }

"" Keymaps begin with H
nnoremap <silent> <Leader>hh :<C-u>VagueMoveLeft<CR>
nnoremap <silent> <Leader>hw :<C-u>wincmd<Space>h<CR>
nnoremap <silent> <Leader>ht :<C-u>tabprevious<CR>
nnoremap <silent> <Leader>hb :<C-u>bprevious<CR>
let g:which_key_map.h = { 'name': '← Move',
    \ 'h': ['VagueMoveLeft', '← Move'],
    \ 'w': ['wincmd h', '← Window'],
    \ 't': ['tabprevious', '← Tab'],
    \ 'b': ['bprevious', '← Buffer'],
\ }

"" Keymaps begin with J
nnoremap <silent> <Leader>jj :<C-u>VagueMoveDown<CR>
nnoremap <silent> <Leader>jw :<C-u>wincmd<Space>j<CR>
nnoremap <silent> <Leader>jt :<C-u>tabfirst<CR>
nnoremap <silent> <Leader>jb :<C-u>bfirst<CR>
let g:which_key_map.j = { 'name': '↓ Move',
    \ 'j': ['VagueMoveDown', '↓ Move'],
    \ 'w': ['wincmd j', '↓ Window'],
    \ 't': ['tabfirst', 'First Tab'],
    \ 'b': ['bfirst', 'First Buffer'],
\ }

"" Keymaps begin with K
nnoremap <silent> <Leader>kk :<C-u>VagueMoveUp<CR>
nnoremap <silent> <Leader>kw :<C-u>wincmd<Space>k<CR>
nnoremap <silent> <Leader>kt :<C-u>tablast<CR>
nnoremap <silent> <Leader>kb :<C-u>blast<CR>
let g:which_key_map.k = { 'name': '↑ Move',
    \ 'k': ['VagueMoveUp', '↑ Move'],
    \ 'w': ['wincmd k', '↑ Window'],
    \ 't': ['tablast', 'Last Tab'],
    \ 'b': ['blast', 'Last Buffer'],
\ }

"" Keymaps begin with L
nnoremap <silent> <Leader>ll :<C-u>VagueMoveRight<CR>
nnoremap <silent> <Leader>lw :<C-u>wincmd<Space>l<CR>
nnoremap <silent> <Leader>lt :<C-u>tabnext<CR>
nnoremap <silent> <Leader>lb :<C-u>bnext<CR>
let g:which_key_map.l = { 'name': '→ Move',
    \ 'l': ['VagueMoveRight', '→ Move'],
    \ 'w': ['wincmd l', '→ Window'],
    \ 't': ['tabnext', '→ Tab'],
    \ 'b': ['bnext', '→ Buffer'],
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
