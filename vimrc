filetype plugin on

"pathogen
execute pathogen#infect()

" For copying automatically the visual selection
set go+=a
set clipboard=unnamed
set ruler

set nocompatible
filetype indent on

syntax on

set smartindent
set nowrap
set history=50
set incsearch
set shiftwidth=4
set smartindent
set tabstop=4
set expandtab
set number
set tw=80
set fo=cqt
set wm=0
set foldmethod=indent
set foldlevel=99
set foldlevelstart=99

if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif " has("autocmd")


"
"-------------------------------------------------------------------
" taglist.vim : toggle the taglist window
" taglist.vim : define the title texts for make
" taglist.vim : define the title texts for qmake
"-------------------------------------------------------------------
noremap <silent> <F11>  <Esc><Esc>:Tlist<CR>
inoremap <silent> <F11>  <Esc><Esc>:Tlist<CR>

let tlist_make_settings  = 'make;m:makros;t:targets;i:includes'
let tlist_qmake_settings = 'qmake;t:SystemVariables'

if has("autocmd")
	" ----------  qmake : set file type for *.pro  ----------
	autocmd BufNewFile,BufRead *.pro  set filetype=qmake
endif " has("autocmd")

" Auto save folds
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" Markdown compile
map cp :!Markdown.pl % > index.html <CR>

set nocp

map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

map - :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

set tags+=$HOME/cppTags/tags
set tags+=/usr/local/share/tags/boost/tags

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
let OmniCpp_SelectFirstItem = 2

set completeopt=menu

" Added to hightlight text that goes over 80

augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  autocmd BufEnter * match OverLength /\%82v.*/
augroup END

"""" Mapings for half screen up and half screen down.
nmap J <C-D>
nmap K <C-U>
nnoremap <C-D> J
nnoremap <C-U> K

""select only word
set selection=exclusive

"Nasty tab 
nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>
inoremap <Tab> <Esc>`^
inoremap <Leader><Tab> <Tab>

" Allow backspace in insert mode
set backspace=indent,eol,start

"" Begin attempt for autosave
"au BufRead,BufNewFile * let b:start_time=localtime()
"
"au CursorMovedI * call UpdateFile()
"au InsertLeave * call UpdateFile()
"
"" only write if needed and update the start time after the save
"function! UpdateFile()
"    if ((localtime() - b:start_time) >= 1)
"        update
"        let b:start_time=localtime()
"    else
"        echo "Only " . (localtime() - b:start_time) . " seconds have elapsed so far."
"    endif
"endfunction
"
"au BufWritePre * let b:start_time=localtime()
"
"" End attempt for autosave

" Yaml
au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/yaml.vim
