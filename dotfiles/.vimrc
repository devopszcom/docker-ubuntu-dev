"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: amix the lucky stiff
"             http://amix.dk - amix@amix.dk
"
" Version: 3.6 - 25/08/10 14:40:30
"
" Blog_post:
"       http://amix.dk/blog/post/19486#The-ultimate-vim-configuration-vimrc
"
"
" Modified: Cuong Tran
" Change:
"   - Remove unnecessary module
"   - Change some setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set autochdir              " change directory automatically

set confirm                 " ask what to do about unsaved/read-only files

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugin
filetype on
filetype plugin on
filetype indent on


" Pathogen load
filetype off

call pathogen#infect()
call pathogen#helptags()


" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
map <leader>w :w!<cr>

" Fast quit
map <leader>q :q<cr>

" fast escapse
inoremap jj <ESC>

"map <leader>e :e! ~/.vimrc<cr> " Fast editing of the .vimrc
autocmd! bufwritepost .vimrc source ~/.vimrc " When .vimrc is edited, reload

" Copy and Paste
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<cr><cr>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<cr>p

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set so=7            " Set 7 lines to the curors - when moving vertical..
set hid             " Change buffer - without saving
set wildmenu        " Turn on WiLd menu
set showcmd         " Hien thi lenh dang go
set cmdheight=1     " The commandbar height

set ruler           " Always show current position
set number          " Print the line number in front of each line

map <leader>nu :set number<cr>
map <leader>no :set nonumber<cr>

if has("gui_running")
    "set cursorcolumn   " Hightlight the curent column
    set cursorline      " Hightlight the current line
    set background=light
else
    set background=dark
endif

" leader+leader to toggle highlight.
let hlstate=0
map <leader><leader> :if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<cr>


" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set smartcase
set ignorecase      " Ignore case when searching
set hlsearch        " Highlight search things
set incsearch       " Make search act like search in modern browsers
set nolazyredraw    " Don't redraw while executing macros
set hidden          " Hide buffers when they are abandoned

set magic           "Set magic on, for regular expressions

set showmatch       " Show matching bracets when text indicator is over them
set mat=2           " How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
"set tm=500

" set height and width of gVim window
"set lines=24
"set columns=80

" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable       " Enable syntax hl

"set guifont=Source\ Code\ Pro\ for\ Powerline\ 13  " Set font
"set shell=/bin/zsh

" Load color scheme from ~/.vim/colors
" http://www.vim.org/scripts/script.php?script_id=985
colorscheme tango2
"colorscheme github

"colorscheme solarized

" GUI
set guioptions-=r
set guioptions-=l
set guioptions-=m
set guioptions-=T

set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backup                  " make backup file
set backupdir=~/.vim/tmp    " backup (*.~)

set directory=~/.vim/tmp    " swap files


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set wrap            " Wrap lines
set autoindent      " Auto indent
set smartindent     " Smart indent

"paste mode
map <leader>paste :set paste<cr>
map <leader>nopaste :set nopaste<cr>


set lbr
"set tw=80


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Useful when moving accross long lines
map j gj
map k gk

" Map space to / (search) and c-space to ? (backgwards search)
"map <space> /
"map <c-space> ?
map <leader><leader> :noh<cr>

" Smart way to move btw. windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

map <leader>bd :Bclose<cr>      " Close the current buffer
map <leader>ba :1,300 bd!<cr>   " Close all the buffers

" Use the arrows to something usefull
map <right> :bn<cr>
map <left>  :bp<cr>
"map <C-up>  :NERDTreeToggle<cr>
map <leader>e :NERDTreeToggle<cr>

" Tab configuration
map <leader>tn :tabnew! %<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>
map <leader>h :tabp<cr>
map <leader>l :tabn<cr>

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Specify the behavior when switching between buffers
try
  set switchbuf=usetab
  set stal=2
catch
endtry

" Return to last edit position (You want this!) *N*
"autocmd BufReadPost *
"     \ if line("'\"") > 0 && line("'\"") <= line("$") |
"     \   exe "normal! g`\"" |
"     \ endif


"Remeber open buffers on close
"set viminfo^=%


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2    " Always show the statusline
"set laststatus=0   " Always hide the statusline

"setting vim-powerline
"let g:Powerline_symbols = 'fancy'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using ALT+[jk]
"nmap <M-j> mz:m+<cr>`z
"nmap <M-k> mz:m-2<cr>`z
"vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
"vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

set guitablabel=%t



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => bufExplorer plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Minibuffer plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 10
let g:miniBufExplModSelTarget = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplVSplit = 15
let g:miniBufExplSplitBelow=1

autocmd BufRead,BufNew :call UMiniBufExplorer

map <leader>u :TMiniBufExplorer<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
" This offers intelligent C++ completion when typing '.' '->' or <C-o>
" Load standard tag files
"set tags+=~/.vim/tags/xapian
"set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt4


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Python section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => XML section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:xml_syntax_folding=1
"au FileType xml setlocal foldmethod=syntax


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MRU plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command-T
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:CommandTMaxHeight = 15
set wildignore+=*.o,*.obj,.git,*.pyc
noremap <leader>y :CommandTFlush<cr>
"noremap! <leader>j :PeepOpen<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Automatic commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufEnter *    set cindent comments=""
    autocmd FileType make set noexpandtab shiftwidth=8

    autocmd FileType c    map <F8> : call CompileGcc()<CR>
    autocmd FileType c    map <F9> :call CompileRunGcc()<CR>
    autocmd FileType c    map <F5> :!./%< <CR>

    func! CompileGcc()
    exec "w"
    exec "!gcc % -o %<"
    endfunc

    func! CompileRunGcc()
    exec "w"
    exec "!gcc % -o %<"
    exec "! ./%<"
    endfunc


    autocmd FileType cpp    map <F9> :w<cr>:!g++ %  -Wall<cr>
    autocmd FileType cpp    map <F5> :!./a.out<cr>

    autocmd FileType python     map <F5> :w<cr>:!python %<cr>
    autocmd FileType python     set noignorecase
    let g:pydiction_location = '~/.vim/ftplugin/pydiction/complete-dict'

endif


"let g:indent_guides_auto_colors = 0
"let g:indent_guides_guide_size=1
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4


" Go to last file(s) if invoked without arguments.
"autocmd VimLeave * nested if (!isdirectory($HOME . "/.vim")) |
"    \ call mkdir($HOME . "/.vim") |
"    \ endif |
"    \ execute "mksession! " . $HOME . "/.vim/Session.vim"

"autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.vim/Session.vim") |
"    \ execute "source " . $HOME . "/.vim/Session.vim"


" Enhanced keyboard mappings
"
" map F3 and SHIFT-F3 to toggle spell checking
nmap <F3> :setlocal spell spelllang=en<CR>
imap <F3> <ESC>:setlocal spell spelllang=en<CR>i
nmap <S-F3> :setlocal spell spelllang=<CR>
imap <S-F3> <ESC>:setlocal spell spelllang=<CR>i
" switch between header/source with F4 C++
"map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" switch between header/source with F4 C
map <F4> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>

" recreate tags file with F6
map <F6> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" create doxygen comment
map <F7> :Dox<CR>

" build using makeprg with <Fx>
"nmap <Fx> :make<CR>
" build using makeprg with <Fx>, in insert mode exit to command mode, save and compile
"imap <Fx> <ESC>:w<CR>:make<CR>
" build using makeprg with <S-Fx>
"map <S-Fx> :make clean all<CR>

" in diff mode we use the spell check keys for merging
if &diff
  " diff settings
  map <M-Down> ]c
  map <M-Up> [c
  map <M-Left> do
  map <M-Right> dp
  map <Fxx> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
else
  " spell settings
"  :setlocal spell spelllang=en
  " set the spellfile - folders must exist
  map <M-Down> ]s
  map <M-Up> [s
endif



augroup filetypedetect
  au BufNewFile,BufRead *.pig set filetype=pig syntax=pig
augroup END


" Strip the newline from the end of a string
function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction

" Find a file and pass it to cmd
function! DmenuOpen(cmd)
  let fname = Chomp(system("git ls-files | dmenu -i -l 20 -p " . a:cmd))
  if empty(fname)
    return
  endif
  execute a:cmd . " " . fname
endfunction


map <c-t> :call DmenuOpen("tabe")<cr>
map <c-f> :call DmenuOpen("e")<cr>


" add new filetype extension
au BufNewFile,BufRead *.ftl set filetype=ftl


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

"" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'

"" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

"" Multiple Plug commands can be written in a single line using | separators
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

"" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

"" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

"" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }

"" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

"" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

"" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'


" Solidity
Plug 'tomlion/vim-solidity'
Plug 'ntpeters/vim-better-whitespace'
Plug 'jiangmiao/auto-pairs'


" Initialize plugin system
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Javascript
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

