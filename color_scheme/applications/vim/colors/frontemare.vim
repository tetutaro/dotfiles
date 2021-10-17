" vi:syntax=vim
"" frontemare scheme by tetutaro

"" setup theme
hi clear
if exists('syntac_on')
    syntax reset
endif
syntax reset
let g:colors_name = "frontemare"

"" GUI color definitions
let s:cgBG = "#000000"
let s:cgBg = "#11141a"
let s:cgBf = "#212733"
let s:cgBF = "#323b4d"
let s:cgFG = "#c3cad9"
let s:cgFg = "#959aa6"
let s:cgB1 = "#5a4266"
let s:cgB2 = "#665a42"
let s:cgB3 = "#42664e"
let s:cgB4 = "#424e66"
let s:cgB5 = "#424266"
let s:cgF1 = "#bf8dd8"
let s:cgF2 = "#cc9c84"
let s:cgF3 = "#bfbf7c"
let s:cgF4 = "#74b374"
let s:cgF5 = "#7cbfbf"
let s:cgF6 = "#95b0e6"
let s:cgF7 = "#9d9df2"

"" TERMINAL color definitions
let s:ctBG = "00"
let s:ctBg = "16"
let s:ctBf = "17"
let s:ctBF = "18"
let s:ctFG = "15"
let s:ctFg = "19"
let s:ctB1 = "20"
let s:ctB2 = "21"
let s:ctB3 = "22"
let s:ctB4 = "23"
let s:ctB5 = "24"
let s:ctF1 = "01"
let s:ctF2 = "25"
let s:ctF3 = "03"
let s:ctF4 = "02"
let s:ctF5 = "06"
let s:ctF6 = "04"
let s:ctF7 = "05"

" Neovim terminal colours
if has("nvim")
    let g:terminal_color_0 =  "#000000"
    let g:terminal_color_1 =  "#bf8dd8"
    let g:terminal_color_2 =  "#74b374"
    let g:terminal_color_3 =  "#bfbf7c"
    let g:terminal_color_4 =  "#95b0e6"
    let g:terminal_color_5 =  "#9d9df2"
    let g:terminal_color_6 =  "#7cbfbf"
    let g:terminal_color_7 =  "#c3cad9"
    let g:terminal_color_8 =  "#000000"
    let g:terminal_color_9 =  "#bf8dd8"
    let g:terminal_color_10 = "#74b374"
    let g:terminal_color_11 = "#bfbf7c"
    let g:terminal_color_12 = "#95b0e6"
    let g:terminal_color_13 = "#9d9df2"
    let g:terminal_color_14 = "#7cbfbf"
    let g:terminal_color_15 = "#c3cad9"
    let g:terminal_color_background = "#000000"
    let g:terminal_color_foreground = "#c3cad9"
elseif has('terminal')
    let g:terminal_ansi_colors = [
        \ "#000000",
        \ "#bf8dd8",
        \ "#74b374",
        \ "#bfbf7c",
        \ "#95b0e6",
        \ "#9d9df2",
        \ "#7cbfbf",
        \ "#c3cad9",
        \ "#000000",
        \ "#bf8dd8",
        \ "#74b374",
        \ "#bfbf7c",
        \ "#95b0e6",
        \ "#9d9df2",
        \ "#7cbfbf",
        \ "#c3cad9",
    \ ]
endif

"" highlighting function
function! s:fHi(grp, gfg, gbg, tfg, tbg, attr)
    let cmd = ""
    if a:gfg != ""
        let cmd = cmd . " guifg=" . a:gfg
    endif
    if a:gbg != ""
        let cmd = cmd . " guibg=" . a:gbg
    endif
    if a:tfg != ""
        let cmd = cmd . " ctermfg=" . a:tfg
    endif
    if a:gbg != ""
        let cmd = cmd . " ctermbg=" . a:tbg
    endif
    if a:attr != ""
        let cmd = cmd . " gui=" . a:attr
        let cmd = cmd . " cterm=" . a:attr
    endif
    if cmd != ""
        execute "hi " . a:grp . cmd
    endif
endfunction

"" default highlighting groups
call <SID>fHi("ColorColumn",  "",     s:cgBf, "",     s:ctBf, "")
call <SID>fHi("Conceal",      s:cgF6, s:cgBG, s:ctF6, s:ctBG, "")
call <SID>fHi("CusorColumn",  "",     s:cgBF, "",     s:ctBF, "NONE")
call <SID>fHi("CursorLine",   "",     s:cgBF, "",     s:ctBF, "NONE")
call <SID>fHi("Directory",    s:cgF6, "",     s:ctF6, "",     "bold")
call <SID>fHi("DiffAdd",      s:cgFG, s:cgB2, s:ctFG, s:ctB2, "NONE")
call <SID>fHi("DiffChange",   s:cgFG, s:cgB3, s:ctFG, s:ctB3, "NONE")
call <SID>fHi("DiffDelete",   s:cgFG, s:cgB1, s:ctFG, s:ctB1, "NONE")
call <SID>fHi("DiffText",     s:cgF1, s:cgB5, s:ctF1, s:ctB5, "bold")
call <SID>fHi("EndOfBuffer",  s:cgFG, s:cgBG, s:ctFG, s:ctBG, "")
call <SID>fHi("ErrorMsg",     s:cgFG, s:cgB1, s:ctFG, s:ctB1, "")
call <SID>fHi("VertSplit",    s:cgBf, s:cgBf, s:ctBf, s:ctBf, "NONE")
call <SID>fHi("Folded",       s:cgFG, s:cgB4, s:ctFG, s:ctB4, "")
call <SID>fHi("FoldColumn",   s:cgFG, s:cgB4, s:ctFG, s:ctB4, "")
call <SID>fHi("SignColumn",   s:cgFG, s:cgB4, s:ctFG, s:ctB4, "")
call <SID>fHi("IncSearch",    s:cgFG, s:cgB5, s:ctFG, s:ctB5, "NONE")
call <SID>fHi("LineNr",       s:cgFg, s:cgBg, s:ctFg, s:ctBg, "NONE")
call <SID>fHi("CursorLineNr", s:cgF6, s:cgBg, s:ctF6, s:ctBg, "NONE")
call <SID>fHi("MatchParen",   "",     s:cgB5, "",     s:ctB5, "NONE")
call <SID>fHi("ModeMsg",      s:cgF6, "",     s:ctF6, "",     "NONE")
call <SID>fHi("MoreMsg",      s:cgF6, "",     s:ctF6, "",     "NONE")
call <SID>fHi("NonText",      s:cgFg, "",     s:ctFg, "",     "NONE")
call <SID>fHi("Normal",       s:cgFG, s:cgBG, s:ctFG, s:ctBG, "")
call <SID>fHi("Pmenu",        s:cgFG, s:cgBg, s:ctFG, s:ctBg, "")
call <SID>fHi("PmenuSel",     s:cgFG, s:cgBF, s:ctFG, s:ctBF, "")
call <SID>fHi("PmenuSbar",    "",     s:cgBf, "",     s:ctBf, "")
call <SID>fHi("PmenuThumb",   "",     s:cgB5, "",     s:ctB5, "")
call <SID>fHi("Question",     s:cgF4, "",     s:ctF4, "",     "")
call <SID>fHi("QuickFixLine", "",     s:cgB5, "",     s:ctB5, "NONE")
call <SID>fHi("Search",       s:cgFG, s:cgB5, s:ctFG, s:ctB5, "NONE")
call <SID>fHi("SpecialKey",   s:cgF6, "",     s:ctF6, "",     "")
call <SID>fHi("SpellBad",     "",     s:cgB1, "",     s:ctB1, "NONE")
call <SID>fHi("SpellCap",     "",     s:cgB3, "",     s:ctB3, "NONE")
call <SID>fHi("SpellLocal",   "",     s:cgB5, "",     s:ctB5, "NONE")
call <SID>fHi("SpellRare",    "",     s:cgB2, "",     s:ctB2, "NONE")
call <SID>fHi("StatusLine",   s:cgFG, s:cgBF, s:ctFG, s:ctBF, "NONE")
call <SID>fHi("StatusLineNC", s:cgFG, s:cgBg, s:ctFG, s:ctBg, "NONE")
call <SID>fHi("StatusLineTerm", s:cgFG, s:cgBF, s:ctFG, s:ctBF, "NONE")
call <SID>fHi("StatusLineTermNC", s:cgFG, s:cgBg, s:ctFG, s:ctBg, "NONE")
call <SID>fHi("TabLine",      s:cgFG, s:cgBG, s:ctFG, s:ctBG, "NONE")
call <SID>fHi("TabLineFill",  s:cgFG, s:cgBG, s:ctFG, s:ctBG, "NONE")
call <SID>fHi("TabLineSel",   s:cgFG, s:cgBF, s:ctFG, s:ctBF, "NONE")
call <SID>fHi("Terminal",     s:cgFG, s:cgBG, s:ctFG, s:ctBG, "NONE")
call <SID>fHi("Title",        s:cgF6, "",     s:ctF6, "",     "")
call <SID>fHi("Visual",       "",     s:cgBF, "",     s:ctBF, "")
call <SID>fHi("VisualNOS",    "",     s:cgBF, "",     s:ctBF, "NONE")
call <SID>fHi("WarningMsg",   s:cgFG, s:cgB3, s:ctFG, s:ctB3, "")
call <SID>fHi("WildMenu",     s:cgFG, s:cgB5, s:ctFG, s:ctB5, "")

"" highlighting groups that are common for many languages
" Comment group
call <SID>fHi("Comment",      s:cgFg, "",     s:ctFg, "",     "")
" Constant group
call <SID>fHi("Constant",     s:cgF5, "",     s:ctF5, "",     "")
call <SID>fHi("String",       s:cgF5, "",     s:ctF5, "",     "")
call <SID>fHi("Character",    s:cgF5, "",     s:ctF5, "",     "")
call <SID>fHi("Number",       s:cgF5, "",     s:ctF5, "",     "")
call <SID>fHi("Boolean",      s:cgF5, "",     s:ctF5, "",     "")
call <SID>fHi("Float",        s:cgF5, "",     s:ctF5, "",     "")
" Identifier group
call <SID>fHi("Identifier",   s:cgF6, "",     s:ctF6, "",     "NONE")
call <SID>fHi("Function",     s:cgF6, "",     s:ctF6, "",     "NONE")
" Statement group
call <SID>fHi("Statement",    s:cgF4, "",     s:ctF4, "",     "")
call <SID>fHi("Conditional",  s:cgF4, "",     s:ctF4, "",     "")
call <SID>fHi("Repeat",       s:cgF4, "",     s:ctF4, "",     "")
call <SID>fHi("Label",        s:cgF4, "",     s:ctF4, "",     "")
call <SID>fHi("Operator",     s:cgF4, "",     s:ctF4, "",     "")
call <SID>fHi("Keyword",      s:cgF4, "",     s:ctF4, "",     "")
call <SID>fHi("Exception",    s:cgF4, "",     s:ctF4, "",     "")
" Preprocessor group
call <SID>fHi("PreProc",      s:cgF6, "",     s:ctF6, "",     "")
call <SID>fHi("Include",      s:cgF6, "",     s:ctF6, "",     "")
call <SID>fHi("Define",       s:cgF6, "",     s:ctF6, "",     "")
call <SID>fHi("Macro",        s:cgF6, "",     s:ctF6, "",     "")
call <SID>fHi("PreCondit",    s:cgF6, "",     s:ctF6, "",     "")
" Type group
call <SID>fHi("Type",         s:cgF4, "",     s:ctF4, "",     "")
call <SID>fHi("StorageClass", s:cgF4, "",     s:ctF4, "",     "")
call <SID>fHi("Structure",    s:cgF4, "",     s:ctF4, "",     "")
call <SID>fHi("Typedef",      s:cgF4, "",     s:ctF4, "",     "")
" Special group
call <SID>fHi("Special",      s:cgF2, "",     s:ctF2, "",     "")
call <SID>fHi("SpecialChar",  s:cgF2, "",     s:ctF2, "",     "")
call <SID>fHi("Tag",          s:cgF2, "",     s:ctF2, "",     "")
call <SID>fHi("Delimiter",    s:cgF2, "",     s:ctF2, "",     "")
call <SID>fHi("SpecialComment", s:cgF2, "",   s:ctF2, "",     "")
call <SID>fHi("Debug",        s:cgF2,  "",    s:ctF2, "",     "")
" Underlined group
call <SID>fHi("Underlined",   s:cgF7, "",     s:ctF7, "",     "")
" Ignore group
call <SID>fHi("Ignore",       s:cgFg, "",     s:ctFg, "",     "")
" Error group
call <SID>fHi("Error",        s:cgF1, s:cgBG, s:ctF1, s:ctBG, "")
" Todo group
call <SID>fHi("Todo",         s:cgF2, s:cgBG, s:ctF2, s:ctBG, "")

"" Highlight groups for plugins
call <SID>fHi("IndentGuidesOdd", "",  s:cgBf, "",     s:ctBf, "")
call <SID>fHi("IndentGuidesEven", "", s:cgBg, "",     s:ctBg, "")
call <SID>fHi("GitGutterAdd", s:cgF4, s:cgBg, s:ctF4, s:ctBg, "")
call <SID>fHi("GitGutterChange", s:cgF2, s:cgBg, s:ctF2, s:ctBg, "")
call <SID>fHi("GitGutterDelete", s:cgF1, s:cgBg, s:ctF1, s:ctBg, "")
call <SID>fHi("GitGutterChangeDelete", s:cgF2, s:cgBg, s:ctF2, s:ctBg, "")
call <SID>fHi("ExtraWhitespace", "",  s:cgB1, "",     s:ctB1, "")
call <SID>fHi("lspReference", s:cgFG, s:cgB4, s:ctFG, s:ctB4, "")

let g:rainbow_conf = {
    \ 'guifgs': [s:cgF1, s:cgF2, s:cgF3, s:cgF4, s:cgF5, s:cgF6, s:cgF7],
    \ 'ctermfgs': [s:ctF1, s:ctF2, s:ctF3, s:ctF4, s:ctF5, s:ctF6, s:ctF7],
\ }

"" Remove functions
delf <SID>fHi

"" Remove color variables
unlet s:cgBG s:cgBg s:cgBf s:cgBF s:cgFG s:cgFg s:cgB1 s:cgB2 s:cgB3 s:cgB4 s:cgB5 s:cgF1 s:cgF2 s:cgF3 s:cgF4 s:cgF5 s:cgF6 s:cgF7
unlet s:ctBG s:ctBg s:ctBf s:ctBF s:ctFG s:ctFg s:ctB1 s:ctB2 s:ctB3 s:ctB4 s:ctB5 s:ctF1 s:ctF2 s:ctF3 s:ctF4 s:ctF5 s:ctF6 s:ctF7
