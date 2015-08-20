filetype plugin on

runtime! archlinux.vim
let g:username = "Andrew DeMaria (muff1nman)"
let g:email = "lostonamountain@gmail.com"
"let g:license = 'All Rights Reserved\r * No part of this code may be reproduced, copied, modified or adapted without the prior written consent of the author, however the source code may be reproduced for academic purposes within the confined environment of the Colorado School of Mines.'
let g:license = 'All Rights Reserved.'
"pathogen
execute pathogen#infect()

" Relative line numbering
set relativenumber
set number

 "Vim has seemed to changed the behavior of when both relative and number are
 "set
" Toggle relative numbering
function! NumberToggle()
	if(&relativenumber == 1 || &number == 1)
		set nonumber
		set norelativenumber
	else
		set number
		set relativenumber
	endif
endfunc

" For copying automatically the visual selection
set go+=a
set clipboard=unnamed
set ruler

set nocompatible
filetype indent on

syntax on

" colorscheme molokai
" colorscheme railscat
" colorscheme transparent
colorscheme ir_black

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
set shiftwidth=2
set tabstop=2
set softtabstop=2
set noexpandtab
set smartindent
set tw=80
set fo=cqt
set wm=0
set foldmethod=indent
set foldlevel=99
set foldlevelstart=99
" Delete faster!!!
" set backspace=indent,eol,start
" set autoindent

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
"au BufWinLeave * silent! mkview
"au BufWinEnter * silent! loadview

" Markdown compile
map cp :!Markdown.pl % > index.html <CR>

set nocp

" Added to hightlight text that goes over 80

"augroup vimrc_autocmds
  "autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  "autocmd BufEnter * match OverLength /\%82v.*/
"augroup END

"""" Mapings for half screen up and half screen down.
nmap J <C-D>
nmap K <C-U>
nnoremap <C-D> J
nnoremap <C-U> K

""select only word
" set selection=exclusive

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

" :W the same as :w
command W w
command Wq wq
command WQ wq

" To run processing with F5 within vim
let g:use_processing_java=1

" To enable folding for processing
let g:processing_fold=1

" Some tab awesomeness (only works in gvim)
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <S-Left> :tabmove -1<CR>
nnoremap <S-Right> :tabmove 1<CR>


" gvim fonts:
if has("gui_running")
  if has("gui_gtk2")
    set guifont=DejaVu\ Sans\ Mono\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

""""""""""""""""""""
" ECLIM extra stuff
""""""""""""""""""""

" Autocomplete
set omnifunc=syntaxcomplete#Complete

" Remove the silly scratch preview thing on autocomplete
set completeopt-=preview

" 256 colors
set t_Co=256

" BEGIN override the default behavior for pasteing"
" Found at http://stackoverflow.com/questions/290465/vim-how-to-paste-over-without-overwriting-register
"""""""""""""""""""""""""""""""""""""""""""""""""""
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

" NB: this supports "rp that replaces the selection by the contents of @r
vnoremap <silent> <expr> p <sid>Repl()
"""""""""""""""""""""""""""""""""""""""""""""""""""
" END

" Switch the keymappings for command t so that <C-T> opens in the same tab and
" Enter opens in a new tab
let g:CommandTAcceptSelectionMap = '<C-t>'
let g:CommandTAcceptSelectionTabMap = '<CR>'

" Let there be syntax highlighting inside markdown code blocks for the following
" languages
let g:markdown_fenced_languages = ["ruby", "html"]

" Rspec.vim mappings
map <Leader>rf :call RunCurrentSpecFile()<CR>
map <Leader>rs :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>

" Keep tmp files in the tmp folder
set dir=/tmp//,.
set backupdir=/tmp//,.

" Recognize cmake files
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt setf cmake 

let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = "debug"

let g:CommandTWildIgnore=&wildignore . ",**target/*,**vendor/*"

let g:EclimCompletionMethod = 'omnifunc'

let g:EasyClipEnableBlackHoleRedirectForDeleteOperator = 0

let g:ycm_key_list_select_completion = [ '<Down>' ]
let g:ycm_key_list_previous_completion = [ '<Up>' ]

vmap <Enter> <Plug>(EasyAlign)
