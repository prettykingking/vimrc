" PEP Vim Terminal Color Scheme
"
hi clear
if exists('syntax_on')
  syntax reset
endif

let colors_name = "pep"

"Appearence palette with 256 colors
let s:Annotation = '239'
let s:Cyan = '31'
let s:Red = '124'
let s:Green = '28'
let s:LGreen = '35'
let s:Yellow = '220'
let s:Blue = '27'
let s:Black = '16'
let s:DGrey = '241'
let s:LGrey = '255'
let s:Magenta = '166'
let s:White = '231'

" Colors for Syntax Highlighting.
exe 'hi String       ctermbg=NONE ctermfg='.s:Red.' cterm=NONE'
exe 'hi Character    ctermbg=NONE ctermfg='.s:Red.' cterm=NONE'
exe 'hi Conditional  ctermbg=NONE ctermfg='.s:Green.' cterm=bold'
exe 'hi Label        ctermbg=NONE ctermfg='.s:Green.' cterm=bold'
exe 'hi Repeat       ctermbg=NONE ctermfg='.s:Green.' cterm=bold'
exe 'hi Statement    ctermbg=NONE ctermfg='.s:Green.' cterm=bold'
exe 'hi Keyword      ctermbg=NONE ctermfg='.s:Green.' cterm=bold'
exe 'hi Exception    ctermbg=NONE ctermfg='.s:Green.' cterm=bold'

exe 'hi Normal       ctermbg=NONE ctermfg='.s:Black.' cterm=NONE'
exe 'hi Identifier   ctermbg=NONE ctermfg='.s:Black.' cterm=NONE'
exe 'hi Function     ctermbg=NONE ctermfg='.s:Black.' cterm=NONE'

exe 'hi Comment      ctermbg=NONE ctermfg='.s:Annotation.' cterm=NONE'
exe 'hi Typedef      ctermbg=NONE ctermfg='.s:Green.' cterm=bold'
exe 'hi PreProc      ctermbg=NONE ctermfg='.s:Green.' cterm=bold'
exe 'hi Include      ctermbg=NONE ctermfg='.s:Green.' cterm=bold'
exe 'hi Define       ctermbg=NONE ctermfg='.s:Green.' cterm=bold'
exe 'hi Macro        ctermbg=NONE ctermfg='.s:Green.' cterm=bold'
exe 'hi Precondit    ctermbg=NONE ctermfg='.s:Green.' cterm=bold'
exe 'hi SpecialComment ctermbg=NONE ctermfg='.s:Cyan.' cterm=NONE'

exe 'hi Special      ctermbg=NONE ctermfg='.s:Cyan.' cterm=NONE'
exe 'hi Delimiter    ctermbg=NONE ctermfg='.s:Black.' cterm=NONE'
exe 'hi Debug        ctermbg=NONE ctermfg='.s:Black.' cterm=NONE'
exe 'hi SpecialChar  ctermbg=NONE ctermfg='.s:Cyan.' cterm=NONE'
exe 'hi Title        ctermbg=NONE ctermfg='.s:Black.' cterm=NONE'

exe 'hi Constant     ctermbg=NONE ctermfg='.s:Cyan.' cterm=NONE'
exe 'hi Boolean      ctermbg=NONE ctermfg='.s:Magenta.' cterm=bold'
exe 'hi Number       ctermbg=NONE ctermfg='.s:LGreen.' cterm=NONE'
exe 'hi Float        ctermbg=NONE ctermfg='.s:LGreen.' cterm=NONE'
exe 'hi Operator     ctermbg=NONE ctermfg='.s:Green.' cterm=bold'
exe 'hi Tag          ctermbg=NONE ctermfg='.s:Blue.' cterm=NONE'
exe 'hi Ignore       ctermbg=NONE ctermfg='.s:DGrey.' cterm=NONE'
exe 'hi Underlined   ctermbg=NONE ctermfg='.s:Black.' cterm=NONE'

exe 'hi MatchParen   ctermbg='.s:Red.' ctermfg='.s:White.' cterm=NONE'
exe 'hi Error        ctermbg='.s:Red.' ctermfg='.s:White.' cterm=NONE'

exe 'hi Type         ctermbg=NONE ctermfg='.s:Magenta.' cterm=bold'
exe 'hi StorageClass ctermbg=NONE ctermfg='.s:Green.' cterm=bold'
exe 'hi Structure    ctermbg=NONE ctermfg='.s:Green.' cterm=bold'
exe 'hi Todo         ctermbg=NONE ctermfg='.s:Cyan.' cterm=bold'
exe 'hi WildMenu     ctermbg='.s:Yellow.' ctermfg='.s:White.' cterm=NONE'

exe 'hi DiffAdd      ctermbg=NONE ctermfg='.s:Green.' cterm=NONE'
exe 'hi DiffChange   ctermbg=NONE ctermfg='.s:Magenta.' cterm=NONE'
exe 'hi DiffDelete   ctermbg=NONE ctermfg='.s:Red.' cterm=NONE'
exe 'hi DiffText     ctermbg=NONE ctermfg='.s:Black.' cterm=NONE'


" Colors for the User Interface.
exe 'hi Cursor       ctermbg='.s:DGrey.' ctermfg='.s:Black.' cterm=bold'
exe 'hi Search       ctermbg='.s:Yellow.' ctermfg='.s:White.' cterm=NONE'
exe 'hi IncSearch    ctermbg='.s:Yellow.' ctermfg='.s:White.' cterm=NONE'
exe 'hi SignColumn   ctermbg='.s:LGrey.' ctermfg='.s:Magenta.' cterm=NONE'

exe 'hi WarningMsg   ctermbg=NONE ctermfg='.s:Red.' cterm=NONE'
exe 'hi ErrorMsg     ctermbg=NONE ctermfg='.s:Red.' cterm=NONE'
exe 'hi ModeMsg      ctermbg=NONE ctermfg='.s:Blue.' cterm=NONE'
exe 'hi MoreMsg      ctermbg=NONE ctermfg='.s:Blue.' cterm=NONE'
exe 'hi Question     ctermbg=NONE ctermfg='.s:Blue.' cterm=NONE'
exe 'hi Directory    ctermbg=NONE ctermfg='.s:Black.' cterm=NONE'
exe 'hi SpecialKey   ctermbg=NONE ctermfg='.s:Black.' cterm=NONE'
exe 'hi Titled       ctermbg=NONE ctermfg='.s:Black.' cterm=NONE'
exe 'hi NonText      ctermbg=NONE ctermfg='.s:DGrey.' cterm=NONE'
exe 'hi CursorLineNr ctermbg=NONE ctermfg='.s:DGrey.' cterm=NONE'

exe 'hi PmenuSel     ctermbg='.s:Blue .' ctermfg='.s:Black.' cterm=NONE'
exe 'hi PmenuSBar    ctermbg='.s:LGrey.' ctermfg='.s:Black.' cterm=NONE'
exe 'hi PmenuThumb   ctermbg='.s:Black.' ctermfg='.s:White.' cterm=NONE'

exe 'hi Visual       ctermbg='.s:LGrey.' ctermfg=NONE cterm=NONE'
exe 'hi Pmenu        ctermbg='.s:LGrey.' ctermfg='.s:Black.' cterm=NONE'
exe 'hi Linenr       ctermbg=NONE ctermfg='.s:DGrey.' cterm=NONE'
exe 'hi VertSplit    ctermbg=23 ctermfg='.s:White.' cterm=NONE'
exe 'hi StatusLine   ctermbg='.s:DGrey.' ctermfg='.s:LGrey.' cterm=NONE'
exe 'hi StatusLineNC ctermbg='.s:LGrey.' ctermfg='.s:DGrey.' cterm=NONE'
exe 'hi Folded       ctermbg='.s:LGrey.' ctermfg='.s:DGrey.' cterm=NONE'
exe 'hi FoldColumn   ctermbg=NONE ctermfg='.s:DGrey.' cterm=NONE'

