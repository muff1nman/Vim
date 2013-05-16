filetype plugin on

let g:username = "Andrew DeMaria (muff1nman)"
let g:email = "ademaria@mines.edu"
"let g:license = 'All Rights Reserved\r * No part of this code may be reproduced, copied, modified or adapted without the prior written consent of the author, however the source code may be reproduced for academic purposes within the confined environment of the Colorado School of Mines.'
let g:license = 'All Rights Reserved.'
"pathogen
execute pathogen#infect()

" For copying automatically the visual selection
set go+=a
set clipboard=unnamed
set ruler

set nocompatible
filetype indent on

syntax on
" Didnt work
"syntax include @TEX syntax/tex.vim
"syntax region texSnip matchgroup=Snip start="TEX" end="TEX" contains=@TEX
"hi link Snip SpecialComment

function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction

set smartindent
set nowrap
set history=50
set incsearch
set shiftwidth=4
set smartindent
set tabstop=4
set expandtab
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

" :W the same as :w
command W w
command Wq wq
command WQ wq
