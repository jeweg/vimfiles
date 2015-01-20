" Jens' vimrc.
"
set nocompatible

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \   (!executable('xdg-open') &&
      \     system('uname') =~? '^darwin'))

if s:is_windows
    " Exchange path separator.
    " Meh.. setting this also changes the behaviour of shellescape to use
    " single quotes which Windows cannot handle.
    set noshellslash
endif

" Set augroup.
augroup MyAutoCmd
    autocmd!
augroup END

let mapleader = ','
let g:mapleader = ','
let g:maplocalleader = 'm'

" ---------------------------------------------------------------------------- 
" Load plugins {

filetype off " Required for Vundle.

" set the runtime path to include Vundle and initialize
if s:is_windows
    set rtp+=$VIMRUNTIME/../bundle/Vundle.vim
    call vundle#begin("$VIMRUNTIME/../bundle") 
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin('~/.vim/bundle')
endif

" let Vundle manage Vundle. Required.
Plugin 'gmarik/Vundle.vim'

Plugin 'flazz/vim-colorschemes'
Plugin 'vim-scripts/twilight'
Plugin 'ciaranm/inkpot'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'haya14busa/incsearch.vim'
Plugin 'moll/vim-bbye'
Plugin 'itchyny/lightline.vim'
Plugin 'mbbill/undotree'
Plugin 'kien/ctrlp.vim.git'
Plugin 'sgur/ctrlp-extensions.vim'
Plugin 'ap/vim-css-color'
Plugin 'spolu/dwm.vim'
Plugin 'vim-scripts/sessionman.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/a.vim'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"

"Plugin 'godlygeek/tabular'
"Plugin 'tpope/vim-fugitive'
"Plugin 'Shougo/neocomplcache.vim'
"Plugin 'scrooloose/nerdcommenter'
"Plugin 'majutsushi/tagbar'
"Plugin 'scrooloose/syntastic'
"Plugin 'takac/vim-hardtime'

" Plugin 'blueyed/vim-diminactive' 
" Plugin 'scrooloose/nerdtree.git'
" Plugin 'Shougo/unite.vim'
" Plugin 'Shougo/vimfiler.vim'
" Plugin 'myusuf3/numbers.vim'
" Plugin 'scrooloose/nerdtree.git'
" Plugin 'troydm/easytree.vim'
" Plugin 'tomtom/shymenu_vim'
" Plugin 'kien/ctrlp.vim.git'

call vundle#end()           

if s:is_windows
    set rtp+=$VIMRUNTIME/../vim-ycm-733de48-windows-x64
endif

filetype plugin indent on    " required

" }
" ---------------------------------------------------------------------------- 
" Appearance and GUI {

set background=dark
if &t_Co >= 256 || has("gui_running")

    "colorscheme solarized
    "colorscheme jellybeans
    "colorscheme codeschool
    "colorscheme coffee
    "colorscheme peaksea
    "colorscheme molokai
    "colorscheme monokai
    "colorscheme inkpot
    "colorscheme railscasts
    "colorscheme gruvbox
    colorscheme solarized

endif
if &t_Co > 2 || has("gui_running")
    syntax on
endif

if has('gui_running')
    set guioptions-=T           " Remove the toolbar
    set guioptions-=r           " Remove the right-hand scrollbar
    set guioptions-=L           " Remove the left-hand scrollbar
    set guioptions-=e           " No gui tabs
    " set guioptions-=t           " No tearoff menus

    if s:is_mac
        set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
    elseif s:is_windows
        set guifont=Consolas:h10,Andale_Mono:h10,Menlo:h10,Courier_New:h10
    else
        set guifont=Inconsolata\ 12,Ubuntu\ Mono\ 11,Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
    endif
endif

" Set the language for gvim's menus and more.
set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set tabpagemax=99
set showmode
set cursorline

highlight clear SignColumn
highlight clear LineNr


" Window pos/size restoring {

" }
" ---------------------------------------------------------------------------- 
" Settings {

set encoding=utf-8
scriptencoding utf-8

set mousehide "Hide mouse pointer while typing.

"set autowrite                       " Automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=block
set history=1000                    " Store a ton of history (default is 20)
"set spell                           " Spell checking on
set hidden                          " Allow buffer switching without saving
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator

set backup
if has('persistent_undo')
    set undofile
    set undolevels=1000
    set undoreload=10000
endif        
if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
                                " Selected characters/lines in visual mode
endif

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor

set nofoldenable                  " Auto fold code
set foldcolumn=0

" Show whitespace?
set nolist
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

set wrap

set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent

set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current

set matchpairs+=<:>             " Match, to be used with %
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

" Use system clipboard for unnamed register.
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  set clipboard& clipboard+=unnamed
endif

" temp dirs.
if s:is_windows
    set backupdir=$VIM/tmp
    set viewdir=$VIM/tmp
    set directory=$VIM/tmp
    set undodir=$VIM/tmp
endif

set noautochdir
set number

set linebreak
set showbreak=+++
set textwidth=0
set wrapmargin=0
set showmatch

" See http://vim.wikia.com/wiki/Disable_beeping#Disable_beep_and_flash_with_an_autocmd
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set hlsearch
set smartcase
set ignorecase
set incsearch
 
set autoindent
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
 
set formatoptions+=l

set ruler
set showtabline=2
 
set undolevels=1000
set backspace=indent,eol,start

autocmd FileType vim setlocal nonumber

" }
" ---------------------------------------------------------------------------- 
" Restore cursor when re-entering window {

function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction
augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" }
" ---------------------------------------------------------------------------- 
" Window pos/size restoring {
" From http://vim.wikia.com/wiki/Restore_screen_size_and_position

" To enable the saving and restoring of screen positions.
let g:screen_size_restore_pos = 1

" To save and restore screen for each Vim instance.
" This is useful if you routinely run more than one Vim instance.
" For all Vim to use the same settings, change this to 0.
let g:screen_size_by_vim_instance = 0

if has("gui_running")
  function! ScreenFilename()
    if has('amiga')
      return "s:.vimsize"
    elseif has('win32')
      return $HOME.'\_vimsize'
    else
      return $HOME.'/.vimsize'
    endif
  endfunction

  function! ScreenRestore()
    " Restore window size (columns and lines) and position
    " from values stored in vimsize file.
    " Must set font first so columns and lines are based on font size.
    let f = ScreenFilename()
    if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      for line in readfile(f)
        let sizepos = split(line)
        if len(sizepos) == 5 && sizepos[0] == vim_instance
          silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
          silent! execute "winpos ".sizepos[3]." ".sizepos[4]
          return
        endif
      endfor
    endif
  endfunction

  function! ScreenSave()
    " Save window size and position.
    if has("gui_running") && g:screen_size_restore_pos
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
            \ (getwinposx()<0?0:getwinposx()) . ' ' .
            \ (getwinposy()<0?0:getwinposy())
      let f = ScreenFilename()
      if filereadable(f)
        let lines = readfile(f)
        call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
        call add(lines, data)
      else
        let lines = [data]
      endif
      call writefile(lines, f)
    endif
  endfunction

  if !exists('g:screen_size_restore_pos')
    let g:screen_size_restore_pos = 1
  endif
  if !exists('g:screen_size_by_vim_instance')
    let g:screen_size_by_vim_instance = 1
  endif
  autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
  autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
endif

" }
" ---------------------------------------------------------------------------- 
" easymotion {
" https://github.com/Lokaltog/vim-easymotion
" http://net.tutsplus.com/tutorials/other/vim-essential-plugin-easymotion/

let g:EasyMotion_do_mapping = 0 " Disable default mappings

map <SPACE> <Plug>(easymotion-s2)

" }
" ---------------------------------------------------------------------------- 
" incsearch {
" https://github.com/haya14busa/incsearch.vim

if 1
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
endif

" }
" ---------------------------------------------------------------------------- 
" CtrlP {
" https://github.com/kien/ctrlp.vim

if 1
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn|CVS)$',
      \ 'file': '\v\.(exe|so|dll|pyc)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }
  
    " On Windows use "dir" as fallback command.
    if s:is_windows
        let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
    elseif executable('ag')
        let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
    elseif executable('ack-grep')
        let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
    elseif executable('ack')
        let s:ctrlp_fallback = 'ack %s --nocolor -f'
    else
        let s:ctrlp_fallback = 'find %s -type f'
    endif
    let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
        \ 'fallback': s:ctrlp_fallback
    \ }  

    map <C-O> :CtrlPMixed<CR>
    map <C-P> :CtrlPMenu<CR>
    
endif

" }
" ---------------------------------------------------------------------------- 
" lightline {

set laststatus=2

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! MyModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction



let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0


" }
" ---------------------------------------------------------------------------- 
" UndoTree {

if 1
    nnoremap <Leader>u :UndotreeToggle<CR>
    " If undotree is opened, it is likely one wants to interact with it.
    let g:undotree_SetFocusWhenToggle=1
endif

" }
" ---------------------------------------------------------------------------- 
" Syntastic {
" https://github.com/scrooloose/syntastic/blob/master/doc/syntastic.txt

if 0
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_aggregate_errors = 1
    " let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_stl_format = '%E{E %fe #%e}%B{, }%W{W %fw #%w}'

    augroup AutoSyntastic
      autocmd!
      autocmd BufWritePost *.c,*.cpp,*.py call s:syntastic()
    augroup END
    function! s:syntastic()
      SyntasticCheck
      call lightline#update()
    endfunction
endif

" }
" ---------------------------------------------------------------------------- 
" Window management {
" From http://agillo.net/simple-vim-window-management/

if 0
    function! WinMove(key) 
      let t:curwin = winnr()
      exec "wincmd ".a:key
      if (t:curwin == winnr()) "we havent moved
        if (match(a:key,'[jk]')) "were we going up/down
          wincmd v
        else 
          wincmd s
        endif
        exec "wincmd ".a:key
      endif
    endfunction
     
    map <leader>h              :call WinMove('h')<cr>
    map <leader>k              :call WinMove('k')<cr>
    map <leader>l              :call WinMove('l')<cr>
    map <leader>j              :call WinMove('j')<cr>

    map <leader>wc :wincmd q<cr>
    map <leader>wr <C-W>r

    map <leader>H              :wincmd H<cr>
    map <leader>K              :wincmd K<cr>
    map <leader>L              :wincmd L<cr>
    map <leader>J              :wincmd J<cr>

    nmap <left>  :3wincmd <<cr>
    nmap <right> :3wincmd ><cr>
    nmap <up>    :3wincmd +<cr>
    nmap <down>  :3wincmd -<cr>
endif
  
" }
" ---------------------------------------------------------------------------- 
" bbye {
" https://github.com/moll/vim-bbye

" map <C-W> :Bdelete<CR>
" map! <C-W> <Esc>:Bdelete<CR>
" map <S-C-W> :bufdo :Bdelete<CR> " Close all buffers

" }
" ---------------------------------------------------------------------------- 
" dwm {
" https://github.com/spolu/dwm.vim

if 1
    let g:dwm_map_keys = 0
    let g:dwm_master_pane_width=110

    noremap <C-J> <C-W>w
    noremap! <C-J> <Esc><C-W>w<CR>i
    noremap <C-K> <C-W>W
    noremap! <C-K> <Esc><C-W>W<CR>i

    map <C-N> <Plug>DWMNew
    map <C-C> <Plug>DWMClose
    map <C-Space> <Plug>DWMFocus

    " map <C-L> <Plug>DWMGrowMaster
    " map <C-H> <Plug>DWMShrinkMaster
endif

" }
" ---------------------------------------------------------------------------- 
" YouCompleteMe {
" https://github.com/Valloric/YouCompleteMe
" http://stackoverflow.com/a/24520161 

let g:ycm_register_as_syntastic_checker = 1 "default 1
let g:Show_diagnostics_ui = 1 "default 1

"will put icons in Vim's gutter on lines that have a diagnostic set.
"Turning this off will also turn off the YcmErrorLine and YcmWarningLine
"highlighting
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_always_populate_location_list = 1 "default 0
let g:ycm_open_loclist_on_ycm_diags = 1 "default 1

"Console Vim (not Gvim or MacVim) passes '<Nul>' to Vim when the user types
"'<C-Space>' so YCM will make sure that '<Nul>' is used in the map command when
"you're editing in console Vim, and '<C-Space>' in GUI Vim. This means that you
"can just press '<C-Space>' in both console and GUI Vim and YCM will do the
"right thing.

let g:ycm_key_invoke_completion = '<C-Space>'

nnoremap <F11> :YcmForceCompileAndDiagnostics<CR>
nnoremap <F10> :YcmCompleter GoTo<CR>

" }
" ---------------------------------------------------------------------------- 
" SnipMate {
" https://github.com/msanders/snipmate.vim/blob/master/doc/snipMate.txt

if 1
    imap <C-h> <Plug>snipMateNextOrTrigger
    smap <C-h> <Plug>snipMateNextOrTrigger
endif

" }
" ---------------------------------------------------------------------------- 
" General key mappings {

nmap <silent> <leader>/ :set invhlsearch<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection.
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

noremap <C-S> <Esc>:w<CR>
inoremap <C-S> <Esc>:w<CR>
" inoremap <C-S> <Esc>:w<CR>i

" nnoremap <Tab> <C-j>
" nnoremap <S-Tab> <C-k>
" nnoremap <C-Tab> <C-j>

" noremap <C-L> :windo set invnumber<CR>
" noremap! <C-L> <Esc>:windo set invnumber<CR>
" noremap <Shift-C-L> :set invnumber<CR>
" noremap! <Shift-C-L> <Esc>:set invnumber<CR>


" From http://stackoverflow.com/a/25887606:
:autocmd CursorMoved * exe exists("HlUnderCursor")?HlUnderCursor?printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\')):'match none':""
let HlUnderCursor=0
noremap <silent> <F3> :exe "let HlUnderCursor=exists(\"HlUnderCursor\")?HlUnderCursor*-1+1:1"<CR>
" TODO: see this http://www.vim.org/scripts/script.php?script_id=4306


autocmd FileType python nnoremap <buffer> <F8> :exec '!python' shellescape(@%, 1)<cr>

" }
