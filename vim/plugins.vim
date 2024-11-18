"" Plugins
call plug#begin(expand('~/.vim/plugged'))
" Interface
Plug 'airblade/vim-rooter'
"Plug 'hecal3/vim-leader-guide'
Plug 'liuchengxu/vim-which-key'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ConradIrwin/vim-bracketed-paste'
" Visualize
Plug 'elzr/vim-json'
Plug 'Yggdroot/indentLine'
Plug 'ntpeters/vim-better-whitespace'
Plug 'luochen1990/rainbow'
Plug 'airblade/vim-gitgutter'
Plug 'rbtnn/vim-ambiwidth'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'tpope/vim-fugitive'
" Zen Mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
" Python
Plug 'Vimjas/vim-python-pep8-indent'
" Language Server
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'dense-analysis/ale'
" Original Plugins
Plug 'tetutaro/vague-move.vim'
Plug 'tetutaro/vague-input-python.vim'
Plug 'tetutaro/vague-input-markdown.vim'
" Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Copilot
Plug 'github/copilot.vim'
call plug#end()

"" setting fotStatus Line
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline_detect_crypt = 0
let g:airline_detect_spell = 0
let g:airline_detect_spelllang = 0
let g:airline_detect_iminsert = 0
let g:airline_inactive_collapse = 0
let g:airline_inactive_alt_sep = 0
let g:airline_theme = 'base16'
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
    if g:airline_theme == 'badwolf'
        for colors in values(a:palette.inactive)
            let colors[3] = 245
        endfor
    endif
endfunction
function! s:update_highlights()
    hi CursorLine ctermbg=none guibg=NONE
    hi VertSplit ctermbg=none guibg=NONE
endfunction
autocmd User AirlineAfterTheme call s:update_highlights()
let g:airline_powerline_fonts = 1
let g:airline_symbols_ascii = 0
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
let g:airline_exclude_filenames = []
let g:airline_exclude_filetypes = []
let g:airline_exclude_preview = 1
let w:airline_disable_statusline = 0
let g:airline_skip_empty_sections = 1
let g:airline_highlighting_cache = 0
let g:airline_focuslost_inactive = 1
"let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_statusline_ontop = 0
let g:airline_stl_path_style = 'short'
let g:airline_section_c_only_filename = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.colnr = ''
let g:airline_symbols.crypt = '[C]'
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.dirty = '+'
let g:airline_symbols.paste = '[P]'
let g:airline_symbols.spell = '[S]'
let g:airline_symbols.notexists = '!!'
let g:airline_symbols.whitespace = '[W]'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#error_symbol = 'E:'
let g:airline#extensions#ale#warning_symbol = 'W:'
let g:airline#extensions#ale#show_line_numbers = 0
let g:airline#extensions#ale#open_lnum_symbol = '(L:'
let g:airline#extensions#ale#close_lnum_symbol = ')'
let g:airline#extensions#battery#enabled = 0
let g:airline#extensions#bookmark#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = '[OPEN]'
let g:airline#extensions#branch#vcs_priority = ['git']
let g:airline#extensions#branch#use_vcscommand = 0
let g:airline#extensions#branch#displayed_head_limit = 7
let g:airline#extensions#branch#format = 0
let g:airline#extensions#branch#sha1_len = 7
let g:airline#extensions#branch#vcs_checks = ['untracked', 'dirty']
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#capslock#enabled = 0
let g:airline#extensions#coc#enabled = 0
let g:airline#extensions#codeium#enabled = 0
let g:airline#extensions#csv#enabled = 1
let g:airline#extensions#csv#column_display = 'Number'
let g:airline#extensions#ctrlspace#enabled = 0
let g:airline#extensions#cursormode#enabled = 0
let g:airline#extensions#denite#enabled = 0
let g:airline#extensions#dirvish#enabled = 0
let g:airline#extensions#eclim#enabled = 0
let g:airline#extensions#fern#enabled = 0
let g:airline#extensions#fugitiveline#enabled = 0
let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#gina#enabled = 0
let g:airline#extensions#grepper#enabled = 0
let g:airline#extensions#gutentags#enabled = 0
let g:airline#extensions#gen_tags#enabled = 0
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 0
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
let g:airline#extensions#hunks#coc_git = 0
let g:airline#extensions#keymap#enabled = 0
let g:airline#extensions#languageclient#enabled = 0
let g:airline#extensions#localsearch#enabled = 0
let g:airline#extensions#lsp#enabled = 0
let g:airline#extensions#neomake#enabled = 0
let g:airline#extensions#nerdtree_statusline = 0
let g:airline#extensions#nrrwrgn#enabled = 0
let g:airline#extensions#nvimlsp#enabled = 0
let g:airline#extensions#obsession#enabled = 0
let g:airline#extensions#omnisharp#enabled = 0
let g:airline#extensions#po#enabled = 0
let g:airline#extensions#poetv#enabled = 0
let g:airline#extensions#promptline#enabled = 0
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#quickfix#location_text = 'Location'
let g:airline#extensions#rufo#enabled = 0
let g:airline#extensions#searchcount#enabled = 1
let g:airline#extensions#searchcount#show_search_term = 1
let g:airline#extensions#searchcount#search_term_limit = 8
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#excludes = []
let g:airline#extensions#tabline#exclude_preview = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#tabnr_formatter = 'tabnr'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#ctrlspace_show_tab_nr = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#buf_label_first = 0
let g:airline#extensions#tabline#buffers_label = 'Buffers'
let g:airline#extensions#tabline#tabs_label = 'Tabs'
let g:airline#extensions#tabline#overflow_marker = '…'
let g:airline#extensions#tabline#current_first = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#keymap_ignored_filetypes =
    \ ['vimfiler', 'nerdtree']
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#buffer_nr_format = '%s:'
let g:airline#extensions#tabline#fnamemod = ':p:.'
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#fnametruncate = 0
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#close_symbol = '[x]'
let g:airline#extensions#tabline#ignore_bufadd_pat =
    \ '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree|'
let g:airline#extensions#tabline#disable_refresh = 0
let g:airline#extensions#tabline#middle_click_preserves_windows = 1
let g:airline#extensions#scrollbar#enabled = 0
let g:airline#extensions#taboo#enabled = 0
let g:airline#extensions#term#enabled = 0
let g:airline#extensions#tabws#enabled = 0
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#taglist#enabled = 0
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#unite#enabled = 0
let g:airline#extensions#vim9lsp#enabled = 0
let g:airline#extensions#vimagit#enabled = 0
let g:airline#extensions#vimcmake#enabled = 0
let g:airline#extensions#vimtex#enabled = 0
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#virtualenv#ft = ['python']
let g:airline#extensions#vista#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#windowswap#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#xkblayout#enabled = 0
let g:airline#extensions#ycm#enabled = 0
" airline theme
let g:airline#themes#base16#constant = 0
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'x', 'y', 'z', 'warning', 'error' ]
\ ]
function! AirlineSectionInit()
    let g:airline_section_a = airline#section#create([
        \ 'mode',
        \ 'paste'
    \ ])
    let g:airline_section_b = airline#section#create_left([
        \ 'hunks',
        \ 'branch'
    \ ])
    let g:airline_section_c = airline#section#create([
        \ 'file',
        \ ' ',
        \ 'readonly'
    \ ])
    let g:airline_section_x = airline#section#create([
        \ 'ffenc'
    \ ])
    let g:airline_section_y = airline#section#create([
        \ 'filetype'
    \ ])
    let g:airline_section_z = airline#section#create([
        \ '%3p%%',
        \ 'linenr',
        \ ':%2v'
    \ ])
endfunction
autocmd User AirlineAfterInit call AirlineSectionInit()
