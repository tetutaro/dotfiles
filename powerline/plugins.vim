"" Plugins
call plug#begin(expand('~/.vim/plugged'))
" Interface
Plug 'airblade/vim-rooter'
"Plug 'hecal3/vim-leader-guide'
Plug 'liuchengxu/vim-which-key'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Visualize
Plug 'elzr/vim-json'
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
Plug '~/.vim/plugged/powerline.vim'
call plug#end()