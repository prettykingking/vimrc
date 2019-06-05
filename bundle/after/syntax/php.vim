" Vim syntax file
" Language: php PHP 3/4/5
" Maintainer: Peter Hodge <toomuchphp-vim@yahoo.com>
" Last Change:  June 9, 2006
" URL: http://www.vim.org/scripts/script.php?script_id=1571
"
" Former Maintainer:  Debian VIM Maintainers <pkg-vim-maintainers@lists.alioth.debian.org>
" Former URL: http://svn.debian.org/wsvn/pkg-vim/trunk/runtime/syntax/php.vim?op=file&rev=0&sc=0
"
" Note: If you are using a colour terminal with dark background, you will probably find
"       the 'elflord' colorscheme is much better for PHP's syntax than the default
"       colourscheme, because elflord's colours will better highlight the break-points
"       (Statements) in your code.
"
" Options:  php_sql_query = 1  for SQL syntax highlighting inside strings
"           php_htmlInStrings = 1  for HTML syntax highlighting inside strings
"           php_baselib = 1  for highlighting baselib functions
"           php_asp_tags = 1  for highlighting ASP-style short tags
"           php_parent_error_close = 1  for highlighting parent error ] or )
"           php_parent_error_open = 1  for skipping an php end tag, if there exists an open ( or [ without a closing one
"           php_oldStyle = 1  for using old colorstyle
"           php_noShortTags = 1  don't sync <? ?> as php
"           php_folding = 1  for folding classes and functions
"           php_folding = 2  for folding all { } regions
"           php_sync_method = x
"                             x=-1 to sync by search ( default )
"                             x>0 to sync at least x lines backwards
"                             x=0 to sync from start
"
"       Added by Peter Hodge On June 9, 2006:
"           php_special_functions = 1|0 to highlight functions with abnormal behaviour
"           php_alt_comparisons = 1|0 to highlight comparison operators in an alternate colour
"           php_alt_assignByReference = 1|0 to highlight '= &' in an alternate colour
"
"           Note: these all default to 1 (On), so you would set them to '0' to turn them off.
"                 E.g., in your .vimrc or _vimrc file:
"                   let php_special_functions = 0
"                   let php_alt_comparisons = 0
"                   let php_alt_assignByReference = 0
"                 Unletting these variables will revert back to their default (On).
"
"
" Note:
" Setting php_folding=1 will match a closing } by comparing the indent
" before the class or function keyword with the indent of a matching }.
" Setting php_folding=2 will match all of pairs of {,} ( see known
" bugs ii )

" Known Bugs:
"  - setting  php_parent_error_close  on  and  php_parent_error_open  off
"    has these two leaks:
"     i) A closing ) or ] inside a string match to the last open ( or [
"        before the string, when the the closing ) or ] is on the same line
"        where the string started. In this case a following ) or ] after
"        the string would be highlighted as an error, what is incorrect.
"    ii) Same problem if you are setting php_folding = 2 with a closing
"        } inside an string on the first line of this string.
"
"  - A double-quoted string like this:
"      "$foo->someVar->someOtherVar->bar"
"    will highight '->someOtherVar->bar' as though they will be parsed
"    as object member variables, but PHP only recognizes the first
"    object member variable ($foo->someVar).
"
"

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'php'
endif

if version < 600
  unlet! php_folding
  if exists("php_sync_method") && !php_sync_method
    let php_sync_method=-1
  endif
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

" accept old options
if !exists("php_sync_method")
  if exists("php_minlines")
    let php_sync_method=php_minlines
  else
    let php_sync_method=-1
  endif
endif

if exists("php_parentError") && !exists("php_parent_error_open") && !exists("php_parent_error_close")
  let php_parent_error_close=1
  let php_parent_error_open=1
endif

syn cluster htmlPreproc add=phpRegion,phpRegionAsp,phpRegionSc

if version < 600
  syn include @sqlTop <sfile>:p:h/sql.vim
else
  syn include @sqlTop syntax/sql.vim
endif
syn sync clear
unlet b:current_syntax
syn cluster sqlTop remove=sqlString,sqlComment
if exists( "php_sql_query")
  syn cluster phpAddStrings contains=@sqlTop
endif

if exists( "php_htmlInStrings")
  syn cluster phpAddStrings add=@htmlTop
endif

syn case match

syn case ignore

syn keyword phpConstant  __LINE__ __FILE__ __FUNCTION__ __METHOD__ __CLASS__  contained

" Conditional
syn keyword phpConditional  declare else enddeclare endswitch elseif endif if switch  contained

" Repeat
syn keyword phpRepeat as do endfor endforeach endwhile for foreach while  contained

" Repeat
syn keyword phpLabel  case default switch contained

" Statement
syn keyword phpStatement  return break continue exit  contained

" Keyword
syn keyword phpKeyword  const contained

" Type
syn keyword phpType bool[ean] int[eger] real double float string array NULL  contained

" Structure
syn keyword phpStructure  extends implements parent self contained

" Operator
syn keyword phpOperator  instanceof contained
syn match phpOperator "&&\|\<and\>" contained display
syn match phpOperator "||\|\<x\=or\>" contained display

" Identifier
syn match phpIdentifierSimply "${\h\w*}"  contains=phpOperator,phpParent  contained display
syn region  phpIdentifierComplex  matchgroup=phpParent start="{\$"rs=e-1 end="}"  contains=phpIdentifier,phpIdentifierComplexP contained extend
syn region  phpIdentifierComplexP matchgroup=phpParent start="\[" end="]" contains=@phpClInside contained

" Include
syn keyword phpInclude  namespace use include require include_once require_once contained

" Peter Hodge - added 'clone' keyword
" Define
syn keyword phpDefine new clone contained

" Boolean
syn keyword phpBoolean  true false  contained

" Number
syn match phpNumber "-\=\<\d\+\>" contained display
syn match phpNumber "\<0x\x\{1,8}\>"  contained display

" Float
syn match phpFloat  "\(-\=\<\d+\|-\=\)\.\d\+\>" contained display

" SpecialChar
syn match phpSpecialChar  "\\[abcfnrtyv\\]" contained display
syn match phpSpecialChar  "\\\d\{3}"  contained contains=phpOctalError display
syn match phpSpecialChar  "\\x\x\{2}" contained display

" Error
syn match phpOctalError "[89]"  contained display
if exists("php_parent_error_close")
  syn match phpParentError  "[)\]}]"  contained display
endif

" Todo
syn keyword phpTodo todo fixme xxx  contained

" Comment
if exists("php_parent_error_open")
  syn region  phpComment  start="/\*" end="\*/" contained contains=phpTodo
else
  syn region  phpComment  start="/\*" end="\*/" contained contains=phpTodo extend
endif
if version >= 600
  syn match phpComment  "#.\{-}\(?>\|$\)\@="  contained contains=phpTodo
  syn match phpComment  "//.\{-}\(?>\|$\)\@=" contained contains=phpTodo
else
  syn match phpComment  "#.\{-}$" contained contains=phpTodo
  syn match phpComment  "#.\{-}?>"me=e-2  contained contains=phpTodo
  syn match phpComment  "//.\{-}$"  contained contains=phpTodo
  syn match phpComment  "//.\{-}?>"me=e-2 contained contains=phpTodo
endif

" String
if exists("php_parent_error_open")
  syn region  phpStringDouble matchgroup=None start=+"+ skip=+\\\\\|\\"+ end=+"+  contains=@phpAddStrings,phpIdentifier,phpSpecialChar,phpIdentifierSimply,phpIdentifierComplex contained keepend
  syn region  phpBacktick matchgroup=None start=+`+ skip=+\\\\\|\\"+ end=+`+  contains=@phpAddStrings,phpIdentifier,phpSpecialChar,phpIdentifierSimply,phpIdentifierComplex contained keepend
  syn region  phpStringSingle matchgroup=None start=+'+ skip=+\\\\\|\\'+ end=+'+  contains=@phpAddStrings contained keepend
else
  syn region  phpStringDouble matchgroup=None start=+"+ skip=+\\\\\|\\"+ end=+"+  contains=@phpAddStrings,phpIdentifier,phpSpecialChar,phpIdentifierSimply,phpIdentifierComplex contained extend keepend
  syn region  phpBacktick matchgroup=None start=+`+ skip=+\\\\\|\\"+ end=+`+  contains=@phpAddStrings,phpIdentifier,phpSpecialChar,phpIdentifierSimply,phpIdentifierComplex contained extend keepend
  syn region  phpStringSingle matchgroup=None start=+'+ skip=+\\\\\|\\'+ end=+'+  contains=@phpAddStrings contained keepend extend
endif

" HereDoc
if version >= 600
  syn case match
  syn region  phpHereDoc  matchgroup=Delimiter start="\(<<<\)\@<=\z(\I\i*\)$" end="^\z1\(;\=$\)\@=" contained contains=phpIdentifier,phpIdentifierSimply,phpIdentifierComplex,phpSpecialChar keepend extend
" including HTML,JavaScript,SQL even if not enabled via options
  syn region  phpHereDoc  matchgroup=Delimiter start="\(<<<\)\@<=\z(\(\I\i*\)\=\(html\)\c\(\i*\)\)$" end="^\z1\(;\=$\)\@="  contained contains=@htmlTop,phpIdentifier,phpIdentifierSimply,phpIdentifierComplex,phpSpecialChar keepend extend
  syn region  phpHereDoc  matchgroup=Delimiter start="\(<<<\)\@<=\z(\(\I\i*\)\=\(sql\)\c\(\i*\)\)$" end="^\z1\(;\=$\)\@=" contained contains=@sqlTop,phpIdentifier,phpIdentifierSimply,phpIdentifierComplex,phpSpecialChar keepend extend
  syn region  phpHereDoc  matchgroup=Delimiter start="\(<<<\)\@<=\z(\(\I\i*\)\=\(javascript\)\c\(\i*\)\)$" end="^\z1\(;\=$\)\@="  contained contains=@htmlJavascript,phpIdentifierSimply,phpIdentifier,phpIdentifierComplex,phpSpecialChar keepend extend
  syn case ignore
endif

" Parent
if exists("php_parent_error_close") || exists("php_parent_error_open")
  syn match phpParent "[{}]"  contained
  syn region  phpParent matchgroup=Delimiter start="(" end=")"  contained contains=@phpClInside transparent
  syn region  phpParent matchgroup=Delimiter start="\[" end="\]"  contained contains=@phpClInside transparent
  if !exists("php_parent_error_close")
    syn match phpParent "[\])]" contained
  endif
else
  syn match phpParent "[({[\]})]" contained
endif

syn cluster phpClConst  contains=phpIdentifier,phpConditional,phpRepeat,phpStatement,phpOperator,phpStringSingle,phpStringDouble,phpBacktick,phpNumber,phpFloat,phpKeyword,phpType,phpBoolean,phpStructure,phpConstant,phpException
syn cluster phpClInside contains=@phpClConst,phpComment,phpLabel,phpParent,phpParentError,phpInclude,phpHereDoc
syn cluster phpClFunction contains=@phpClInside,phpDefine,phpParentError,phpStorageClass
syn cluster phpClTop  contains=@phpClFunction,phpFoldFunction,phpFoldClass,phpFoldInterface,phpFoldTry,phpFoldCatch

" Php Region
if exists("php_parent_error_open")
  if exists("php_noShortTags")
    syn region   phpRegion  matchgroup=Delimiter start="<?php" end="?>" contains=@phpClTop
  else
    syn region   phpRegion  matchgroup=Delimiter start="<?\(php\)\=" end="?>" contains=@phpClTop
  endif
  syn region   phpRegionSc  matchgroup=Delimiter start=+<script language="php">+ end=+</script>+  contains=@phpClTop
  if exists("php_asp_tags")
    syn region   phpRegionAsp matchgroup=Delimiter start="<%\(=\)\=" end="%>" contains=@phpClTop
  endif
else
  if exists("php_noShortTags")
    syn region   phpRegion  matchgroup=Delimiter start="<?php" end="?>" contains=@phpClTop keepend
  else
    syn region   phpRegion  matchgroup=Delimiter start="<?\(php\)\=" end="?>" contains=@phpClTop keepend
  endif
  syn region   phpRegionSc  matchgroup=Delimiter start=+<script language="php">+ end=+</script>+  contains=@phpClTop keepend
  if exists("php_asp_tags")
    syn region   phpRegionAsp matchgroup=Delimiter start="<%\(=\)\=" end="%>" contains=@phpClTop keepend
  endif
endif

" Fold
if exists("php_folding") && php_folding==1
" match one line constructs here and skip them at folding
  syn keyword phpSCKeyword  abstract final private protected public static  contained
  syn keyword phpFCKeyword  function  contained
  syn keyword phpStorageClass global  contained
  syn match phpDefine "\(\s\|^\)\(abstract\s\+\|final\s\+\|private\s\+\|protected\s\+\|public\s\+\|static\s\+\)*function\(\s\+.*[;}]\)\@="  contained contains=phpSCKeyword
  syn match phpStructure  "\(\s\|^\)\(abstract\s\+\|final\s\+\)*class\(\s\+.*}\)\@="  contained
  syn match phpStructure  "\(\s\|^\)interface\(\s\+.*}\)\@="  contained
  syn match phpException  "\(\s\|^\)try\(\s\+.*}\)\@="  contained
  syn match phpException  "\(\s\|^\)catch\(\s\+.*}\)\@="  contained

  set foldmethod=syntax
  syn region  phpFoldHtmlInside matchgroup=Delimiter start="?>" end="<?\(php\)\=" contained transparent contains=@htmlTop
  syn region  phpFoldFunction matchgroup=Storageclass start="^\z(\s*\)\(abstract\s\+\|final\s\+\|private\s\+\|protected\s\+\|public\s\+\|static\s\+\)*function\s\([^};]*$\)\@="rs=e-9 matchgroup=Delimiter end="^\z1}" contains=@phpClFunction,phpFoldHtmlInside,phpFCKeyword contained transparent fold extend
  syn region  phpFoldFunction matchgroup=Define start="^function\s\([^};]*$\)\@=" matchgroup=Delimiter end="^}" contains=@phpClFunction,phpFoldHtmlInside contained transparent fold extend
  syn region  phpFoldClass  matchgroup=Structure start="^\z(\s*\)\(abstract\s\+\|final\s\+\)*class\s\+\([^}]*$\)\@=" matchgroup=Delimiter end="^\z1}" contains=@phpClFunction,phpFoldFunction,phpSCKeyword contained transparent fold extend
  syn region  phpFoldInterface  matchgroup=Structure start="^\z(\s*\)interface\s\+\([^}]*$\)\@=" matchgroup=Delimiter end="^\z1}" contains=@phpClFunction,phpFoldFunction contained transparent fold extend
  syn region  phpFoldCatch  matchgroup=Exception start="^\z(\s*\)catch\s\+\([^}]*$\)\@=" matchgroup=Delimiter end="^\z1}" contains=@phpClFunction,phpFoldFunction contained transparent fold extend
  syn region  phpFoldTry  matchgroup=Exception start="^\z(\s*\)try\s\+\([^}]*$\)\@=" matchgroup=Delimiter end="^\z1}" contains=@phpClFunction,phpFoldFunction contained transparent fold extend
elseif exists("php_folding") && php_folding==2
  syn keyword phpDefine function  contained
  syn keyword phpStructure  trait abstract class interface  contained
  syn keyword phpException  catch throw try contained
  syn keyword phpStorageClass final global private protected public static  contained

  set foldmethod=syntax
  syn region  phpFoldHtmlInside matchgroup=Delimiter start="?>" end="<?\(php\)\=" contained transparent contains=@htmlTop
  syn region  phpParent matchgroup=Delimiter start="{" end="}"  contained contains=@phpClFunction,phpFoldHtmlInside transparent fold
else
  syn keyword phpDefine function  contained
  syn keyword phpStructure  trait abstract class interface  contained
  syn keyword phpException  catch throw try contained
  syn keyword phpStorageClass final global private protected public static  contained
endif

" ================================================================
" Peter Hodge - June 9, 2006
" Some of these changes (highlighting isset/unset/echo etc) are not so
" critical, but they make things more colourful. :-)

" corrected highlighting for an escaped '\$' inside a double-quoted string
syn match phpSpecialChar  "\\\$"  contained display

" highlight constant E_STRICT
syntax case match
syntax case ignore

" different syntax highlighting for 'echo', 'print', 'switch', 'die' and 'list' keywords
" to better indicate what they are.
syntax keyword phpDefine echo print contained
syntax keyword phpStructure list contained
syntax keyword phpConditional switch contained
syntax keyword phpStatement die contained

" Highlighting for PHP5's built-in interfaces
" - built-in classes harvested from get_declared_interfaces() in 5.1.4
syntax keyword phpInterfaces containedin=ALLBUT,phpComment,phpStringDouble,phpStringSingle,phpIdentifier
  \ Iterator IteratorAggregate RecursiveIterator OuterIterator SeekableIterator
  \ Traversable ArrayAccess Serializable Countable SplObserver SplSubject Reflector
highlight link phpInterfaces phpConstant

" option defaults:
if ! exists('php_special_functions')
    let php_special_functions = 1
endif
if ! exists('php_alt_comparisons')
    let php_alt_comparisons = 1
endif
if ! exists('php_alt_assignByReference')
    let php_alt_assignByReference = 1
endif

if php_alt_assignByReference
    " special highlighting for '=&' operator
    syntax match phpAssignByRef /=\s*&/ containedin=ALLBUT,phpComment,phpStringDouble,phpStringSingle
    highlight link phpAssignByRef Type
endif

" ================================================================

" Sync
if php_sync_method==-1
  if exists("php_noShortTags")
    syn sync match phpRegionSync grouphere phpRegion "^\s*<?php\s*$"
  else
    syn sync match phpRegionSync grouphere phpRegion "^\s*<?\(php\)\=\s*$"
  endif
  syn sync match phpRegionSync grouphere phpRegionSc +^\s*<script language="php">\s*$+
  if exists("php_asp_tags")
    syn sync match phpRegionSync grouphere phpRegionAsp "^\s*<%\(=\)\=\s*$"
  endif
  syn sync match phpRegionSync grouphere NONE "^\s*?>\s*$"
  syn sync match phpRegionSync grouphere NONE "^\s*%>\s*$"
  syn sync match phpRegionSync grouphere phpRegion "function\s.*(.*\$"
  "syn sync match phpRegionSync grouphere NONE "/\i*>\s*$"
elseif php_sync_method>0
  exec "syn sync minlines=" . php_sync_method
else
  exec "syn sync fromstart"
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_php_syn_inits")
  if version < 508
    let did_php_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink   phpConstant  Constant
  HiLink   phpComment Comment
  HiLink   phpException Exception
  HiLink   phpBoolean Boolean
  HiLink   phpStorageClass  StorageClass
  HiLink   phpSCKeyword StorageClass
  HiLink   phpFCKeyword Define
  HiLink   phpStructure Structure
  HiLink   phpStringSingle  String
  HiLink   phpStringDouble  String
  HiLink   phpBacktick  String
  HiLink   phpNumber  Number
  HiLink   phpFloat Float
  HiLink   phpRepeat  Repeat
  HiLink   phpConditional Conditional
  HiLink   phpLabel Label
  HiLink   phpStatement Statement
  HiLink   phpKeyword Statement
  HiLink   phpType  Type
  HiLink   phpInclude Include
  HiLink   phpDefine  Define
  HiLink   phpSpecialChar SpecialChar
  HiLink   phpParent  Delimiter
  HiLink   phpIdentifierConst Delimiter
  HiLink   phpParentError Error
  HiLink   phpOctalError  Error
  HiLink   phpTodo  Todo
  HiLink  phpOperator Operator
  HiLink  phpIdentifier Identifier
  HiLink  phpIdentifierSimply Identifier

  delcommand HiLink
endif

let b:current_syntax = "php"

if main_syntax == 'php'
  unlet main_syntax
endif

" vim: ts=8 sts=2 sw=2 expandtab
