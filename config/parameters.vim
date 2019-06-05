" Third-party parameters


"
" Load pathogen paths
"
call pathogen#infect('~/.vim_runtime/bundle/{}')
call pathogen#helptags()


"
" bufExplorer plugin
"
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>


"
" YankRing
"
if has("win16") || has("win32")
    " Don't do anything
else
    let g:yankring_history_dir = '~/.vim_runtime/tmp'
endif


"
" Nerd Tree
"
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>


"
" vim-multiple-cursors
"
let g:multi_cursor_next_key="\<C-s>"


"
" surround.vim config
" Annotate strings with gettext http://amix.dk/blog/post/19678
"
vmap Si S(i_<esc>f)


"
" vim-airline config (force color)
"
let g:airline_theme="luna"
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1


"
" Color Scheme
"
colorscheme pep
