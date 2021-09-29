"" KEYBOARD MAPPINGS
"" VIM Leader Map

inoremap jj <Esc>
nnoremap f @
nnoremap <silent> h :VagueSofttabLeft<CR>
nnoremap <silent> l :VagueSofttabRight<CR>
nnoremap <silent> x :VagueSofttabBS<CR>
nnoremap <silent> X :VagueSofttabDelete<CR>

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
" WRITE
nnoremap <Leader>wr :<C-u>source<Space>$HOME/.vim/vimrc<CR>:noh<CR>
" WINDOW
nnoremap <Leader>ws :<C-u>vsplit<CR>
nnoremap <Leader>wv :<C-u>split<CR>
nnoremap <Leader>wi :<C-u>vsplit<CR>
nnoremap <Leader>wn :<C-u>vnew<CR>:Files<CR>
nnoremap <Leader>wc :<C-u>close<CR>
nnoremap <Leader>w0 :<C-u>only<CR>
nnoremap <silent> <Leader>wh :<C-u>wincmd<Space>h<CR>
nnoremap <silent> <Leader>wj :<C-u>wincmd<Space>j<CR>
nnoremap <silent> <Leader>wl :<C-u>wincmd<Space>l<CR>
nnoremap <silent> <Leader>wk :<C-u>wincmd<Space>k<CR>
nnoremap <silent> <Leader>w= :<C-u>wincmd<Space>=<CR>
let g:which_key_map.w = { 'name': 'Write & Window',
    \ 'w': ['w', 'Write'],
    \ 'q': ['wq', 'Write & Quit VIM'],
    \ 'r': ['source $MYVIMRC', 'Reload VIMRC'],
    \ 's': ['vsplit', 'Split'],
    \ 'v': ['split', 'Vertically Split'],
    \ 'i': ['vnew', 'Split'],
    \ 'n': ['new', 'New & Open Split'],
    \ 'c': ['close', 'Close Splitted'],
    \ '0': ['only', 'Only Splitted'],
    \ 'h': ['wincmd h', '← Split'],
    \ 'j': ['wincmd j', '↓ Split'],
    \ 'l': ['wincmd l', '↑ Split'],
    \ 'k': ['wincmd k', '→ Split'],
    \ '=': ['wincmd =', 'Even Size Splits'],
\ }

"" Keymaps begin with E
nnoremap <Leader>ee :<C-u>VagueToggleFocusLoclist<CR>
nnoremap <Leader>ei :<C-u>VagueToggleOpenLoclist<CR>
nnoremap <Leader>et :<C-u>LspWorkspaceSymbol<CR>
nnoremap <Leader>ef :<C-u>ALEFix<CR>
nnoremap <Leader>ej <Plug>(ale_next_wrap)
nnoremap <Leader>ek <Plug>(ale_previous_wrap)
let g:which_key_map.e = { 'name': 'Error',
    \ 'e': ['VagueToggleFocusLoclist', 'Focus Error'],
    \ 'i': ['VagueToggleOpenLoclist', 'Open Error'],
    \ 'f': ['ALEFix', 'Fix Error'],
    \ 'j': ['ale_next_wrap', '↓ Error'],
    \ 'k': ['ale_previous_wrap', '↑ Error'],
\ }

"" Keymaps begin with R
nnoremap <Leader>rr :<C-u>VagueToggleFocusQuickfix<CR>
nnoremap <Leader>ri :<C-u>VagueToggleOpenQuickfix<CR>
nnoremap <Leader>rt :<C-u>LspReferences<CR>
nnoremap <Leader>rh :<C-u>VagueToggleOpenLspHover<CR>
let g:which_key_map.r = { 'name': 'Reference',
    \ 'r': ['VagueToggleFocusQuickfix', 'Focus Reference'],
    \ 'i': ['VagueToggleOpenQuickfix', 'Open Reference'],
    \ 't': ['LspReferences', 'This Word → Reference'],
    \ 'h': ['VagueToggleOpenLspHover', 'Hover Reference'],
\ }

"" Keymaps begin with T
" TAG
nnoremap <Leader>tt :<C-u>VagueToggleFocusTagbar<CR>
nnoremap <Leader>tg :<C-u>VagueToggleFocusTagbar<CR>
nnoremap <Leader>ti :<C-u>TagbarToggle<CR>
nnoremap <Leader>tag :<C-u>TagbarToggle<CR>
" TAB
nnoremap <Leader>tb :<C-u>tabnew<CR>:Files<CR>
nnoremap <Leader>tn :<C-u>tabnew<CR>:Files<CR>
nnoremap <Leader>tc :<C-u>tabclose<CR>
nnoremap <Leader>t0 :<C-u>tabonly<CR>
nnoremap <silent> <Leader>th :<C-u>tabprevious<CR>
nnoremap <silent> <Leader>tj :<C-u>tabfirst<CR>
nnoremap <silent> <Leader>tk :<C-u>tablast<CR>
nnoremap <silent> <Leader>tl :<C-u>tabnext<CR>
nnoremap <Leader>tab :<C-u>tabnew<CR>:Files<CR>
let g:which_key_map.t = { 'name': 'Tag & Tab',
    \ 't': ['VagueToggleFocusTagbar', 'Focus Tag'],
    \ 'g': ['VagueToggleFocusTagbar', 'Focus Tag'],
    \ 'i': ['TagbarToggle', 'Open Tag'],
    \ 'b': ['tabnew', 'Open Tab'],
    \ 'n': ['tabnew', 'Open Tab'],
    \ 'c': ['tabclose', 'Close Tabbed'],
    \ '0': ['tabonly', 'Only Tabbed'],
    \ 'h': ['tabprevious', '← Tab'],
    \ 'j': ['tabfirst', 'First Tab'],
    \ 'k': ['tablast', 'Last Tab'],
    \ 'l': ['tabnext', '→ Tab'],
\ }
let g:which_key_map.t.a={'name': 'Tab / Tag',
    \ 'g': ['TagbarToggle', 'Open Tag'],
    \ 'b': ['tabnew', 'Open Tab'],
\ }

"" Keymaps begin with A
nnoremap <Leader>aa :<C-u>Ag<CR>
nnoremap <Leader>ag :<C-u>Ag<CR>
nnoremap <Leader>at :<C-u>Ag<CR><C-r><C-w><CR>
let g:which_key_map.a = { 'name': 'Ag',
    \ 'a': ['Ag', 'Ag'],
    \ 'g': ['Ag', 'Ag'],
    \ 't': ['Ag<C-r><C-w>', 'This Word → Ag'],
\ }

"" Keymaps begin with S
nnoremap <Leader>sh :<C-u>terminal<CR>
nnoremap <Leader>ss :<C-u>terminal<CR>
nnoremap <Leader>si :<C-u>terminal<CR>
nnoremap <Leader>sv :<C-u>vertical terminal<CR>
let g:which_key_map.s={ 'name': 'Shell',
    \ 's': ['terminal', 'Shell'],
    \ 'h': ['terminal', 'Shell'],
    \ 'v': ['vertival terminal', 'Vertical Shell'],
\ }

"" Keymaps begin with D
nnoremap <Leader>dd :<C-u>NERDTreeFocusToggle<CR>
nnoremap <Leader>di :<C-u>NERDTreeTabsToggle<CR>
nnoremap <Leader>do :<C-u>w<CR>:VagueToggleOpenQuickRun<CR>
let g:which_key_map.d = { 'name': 'Dir & Do',
    \ 'd': ['NERDTreeFocusToggle', 'Focus Dir'],
    \ 'i': ['NERDTreeFocusToggle', 'Open Dir'],
    \ 'o': ['VagueToggleOpenQuickRun', 'Do'],
\ }

"" Keymaps begin with F
nnoremap <Leader>ff :<C-u>BLines<CR>
nnoremap <Leader>ft :<C-u>BLines <C-r><C-w><CR>
nnoremap <Leader>fr :<C-u>BTags<CR>
nnoremap <Leader>fn :<C-u>Files<CR>
nnoremap <Leader>fg :<C-u>GFiles?<CR>
nnoremap <Leader>fb :<C-u>Buffers<CR>
nnoremap <Leader>fc :<C-u>Colors<CR>
nnoremap <Leader>fw :<C-u>Windows<CR>
let g:which_key_map.f = { 'name': 'Find',
    \ 'f': ['BLines', 'File'],
    \ 't': ['BLines', 'This Word → File'],
    \ 'r': ['BTags', 'Reference'],
    \ 'n': ['Files', 'Name → File'],
    \ 'g': ['GFiles?', 'Git Status → File'],
    \ 'b': ['Buffers', 'Buffer'],
    \ 'c': ['Colors', 'Color'],
    \ 'w': ['Windows', 'Window'],
\ }

"" Keymaps begin with G
nnoremap <Leader>gg gg
nnoremap <Leader>gG G
"nnoremap <silent> <Leader>gi :<C-u>vertical<Space>G<CR>:vertical<Space>resize<Space>40<CR>
nnoremap <silent> <Leader>gi :<C-u>G<CR>
nnoremap <Leader>gd :<C-u>Gdiff<CR>
nnoremap <Leader>gj :<C-u>Gpull<CR>
nnoremap <Leader>gp :<C-u>Gpush<CR>
nnoremap <Leader>go :<C-u>LspDefinition<CR>
let g:which_key_map.g = { 'name': 'Git & Go',
    \ 'g': ['', 'Go Top'],
    \ 'G': ['', 'Go Bottom'],
    \ 'i': ['G', 'Git'],
    \ 'o': ['QuickRun', 'Go Definition'],
    \ 'd': ['Gdiff', 'Diff Git'],
    \ 'j': ['Gpull', 'Pull ↓ Git'],
    \ 'p': ['Gpush', 'Push Git'],
\ }

"" Keymaps begin with Z
"" zz is defined at defaults.vim
let g:which_key_map.z = { 'name': 'Cancel',
    \ 'z': ['undo', 'Undo'],
\ }

"" Keymaps begin with C
"" cc is defined at defaults.vim
nnoremap <Leader>co <Plug>CommentaryLine
let g:which_key_map.c = { 'name': 'Clear & Comment',
    \ 'c': ['noh', 'Clear Hilight'],
    \ 'o': ['CommentaryLine', 'Comment'],
\ }

"" Keymaps begin with V
nnoremap <Leader>va :<C-u>VirtualEnvActivate<Space>python3<CR>
nnoremap <Leader>vd :<C-u>VirtualEnvDeactivate<CR>
nnoremap <Leader>vi :<C-u>ColorSwatchGenerate<CR>
nnoremap <Leader>vt :<C-u>PgmntDevInspect<CR>
let g:which_key_map.v = { 'name': 'Visual & Virtual',
    \ 'a': ['VirtualEnvActivate', 'Activate'],
    \ 'd': ['VirtualEnvDeactivate', 'Deactive'],
    \ 'i': ['ColorSwatchGenerate', 'Open Color'],
    \ 't': ['PgmntDevInspect', 'This Word → Syntax'],
\ }


"" Keymaps begin with B
nnoremap <Leader>bb :<C-u>Buffers<CR>
nnoremap <Leader>bc :<C-u>bdelete<CR>
nnoremap <silent> <Leader>bh :<C-u>bprevious<CR>
nnoremap <silent> <Leader>bj :<C-u>bfirst<CR>
nnoremap <silent> <Leader>bk :<C-u>blast<CR>
nnoremap <silent> <Leader>bl :<C-u>bnext<CR>
let g:which_key_map.b = { 'name': 'Buffer',
    \ 'b': ['buffers', 'Buffers'],
    \ 'c': ['bdelete', 'Close Buffer'],
    \ 'h': ['bprevious', '← Buffer'],
    \ 'j': ['bfirst', 'First Buffer'],
    \ 'k': ['blast', 'Last Buffer'],
    \ 'l': ['bnext', '→ Buffer'],
\ }

"" Keymaps begin with H
nnoremap <silent> <Leader>hh :<C-u>VagueMoveLeft<CR>
nnoremap <silent> <Leader>hs :<C-u>wincmd<Space>h<CR>
nnoremap <silent> <Leader>ht :<C-u>tabprevious<CR>
nnoremap <silent> <Leader>hb :<C-u>bprevious<CR>
let g:which_key_map.h = { 'name': '← Move',
    \ 'h': ['VagueMoveLeft', '← Move'],
    \ 't': ['tabprevious', '← Tab'],
    \ 's': ['wincmd h', '← Split'],
    \ 'b': ['bprevious', '← Buffer'],
\ }

"" Keymaps begin with J
nnoremap <silent> <Leader>jj :<C-u>VagueMoveDown<CR>
nnoremap <silent> <Leader>js :<C-u>wincmd<Space>j<CR>
nnoremap <silent> <Leader>jt :<C-u>tabfirst<CR>
nnoremap <silent> <Leader>jb :<C-u>bfirst<CR>
let g:which_key_map.j = { 'name': '↓ Move',
    \ 'j': ['VagueMoveDown', '↓ Move'],
    \ 't': ['tabfirst', 'First Tab'],
    \ 's': ['wincmd j', '↓ Split'],
    \ 'b': ['bfirst', 'First Buffer'],
\ }

"" Keymaps begin with K
nnoremap <silent> <Leader>kk :<C-u>VagueMoveUp<CR>
nnoremap <silent> <Leader>ks :<C-u>wincmd<Space>k<CR>
nnoremap <silent> <Leader>kt :<C-u>tablast<CR>
nnoremap <silent> <Leader>kb :<C-u>blast<CR>
let g:which_key_map.k = { 'name': '↑ Move',
    \ 'k': ['VagueMoveUp', '↑ Move'],
    \ 't': ['tablast', 'Last Tab'],
    \ 's': ['wincmd k', '↑ Split'],
    \ 'b': ['blast', 'Last Buffer'],
\ }

"" Keymaps begin with L
nnoremap <silent> <Leader>ll :<C-u>VagueMoveRight<CR>
nnoremap <silent> <Leader>ls :<C-u>wincmd<Space>l<CR>
nnoremap <silent> <Leader>lt :<C-u>tabnext<CR>
nnoremap <silent> <Leader>lb :<C-u>bnext<CR>
let g:which_key_map.l = { 'name': '→ Move',
    \ 'l': ['VagueMoveRight', '→ Move'],
    \ 't': ['tabnext', '→ Tab'],
    \ 's': ['wincmd l', '→ Split'],
    \ 'b': ['bnext', '→ Buffer'],
\ }

"" Keymaps begin with M
nnoremap <silent> <Leader>mm :<C-u>!open -a "Google Chrome" %<CR>
let g:which_key_map.m = { 'name': 'Markdown',
    \ 'm': ['!open', 'Preview'],
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
