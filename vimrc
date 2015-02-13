" My vimrc. Jens Weggemann <jensweh@gmail.com>
" ---------------------------------------------------------------------------- 
" General setup {{{

set nocompatible

" Platform detection
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \   (!executable('xdg-open') &&
      \     system('uname') =~? '^darwin'))

" Normally we would set shellshash on Windows to have unified
" path separators.
" However, this has the side effect of also changing the behaviour
" of shellescape to use single quotes which Windows cannot handle.
set noshellslash

if s:is_windows
    let s:vimfiles_dir = '$VIMRUNTIME/../vimfiles'
    let s:vundle_plugins_dir = '$VIMRUNTIME/../bundle'
    let s:temp_dir = '$VIMRUNTIME/../tmp'
else
    let s:vimfiles_dir = '~/.vim'
    let s:vundle_plugins_dir = '~/.vim/unversioned/bundle'
    let s:temp_dir = '~/.vim/unversioned/tmp'
endif
let s:manual_plugins_dir = s:vimfiles_dir . '/plugins'

" Set augroup.
augroup MyAutoCmd
    autocmd!
augroup END

let mapleader = ','
let g:mapleader = ','
let g:maplocalleader = 'm'

"}}}
" ---------------------------------------------------------------------------- 
" Plugins (Managed) {{{

filetype off " Required for Vundle.

" set the runtime path to include Vundle and initialize
if s:is_windows
    set rtp+=$VIMRUNTIME/../bundle/Vundle.vim
    call vundle#begin("$VIMRUNTIME/../bundle") 
else
    set rtp+=~/.vim/unversioned/bundle/Vundle.vim
    call vundle#begin('~/.vim/unversioned/bundle')
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
Plugin 'ap/vim-css-color'
Plugin 'vim-scripts/sessionman.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/a.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'EinfachToll/DidYouMean'
Plugin 'nielsmadan/harlequin'
Plugin 'szw/seoul256.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Shougo/vimproc.vim'
Plugin 'LeafCage/yankround.vim'
Plugin 'kshenoy/vim-sol'
Plugin 'freeo/vim-kalisi'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'mhinz/vim-startify'
Plugin 'terryma/vim-expand-region'

"Plugin 'honza/vim-snippets'
Plugin 'SirVer/ultisnips'

"Plugin 'zhaocai/GoldenView.Vim'
Plugin 'spolu/dwm.vim'


Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neomru.vim'
"Plugin 'kien/ctrlp.vim.git'
"Plugin 'sgur/ctrlp-extensions.vim'

if !s:is_windows
    Plugin 'Valloric/YouCompleteMe'
    
    " Couldn't get this to work on Windows
    " even after it compiled successfully:
    "Plugin 'JazzCore/ctrlp-cmatcher'
else
    " So let's use this one on Windows instead:
    " Update: this always had problems, too.
    "Plugin 'FelikZ/ctrlp-py-matcher' 

    Plugin 'lorry-lee/visual_studio.vim'
endif


" Tried at one time, not used atm for various reasons:
" Plugin 'garbas/vim-snipmate'  < Liked UltiSnips more.
" Plugin 'godlygeek/tabular'
" Plugin 'Shougo/neocomplcache.vim'
" Plugin 'majutsushi/tagbar'
" Plugin 'scrooloose/syntastic'
" Plugin 'takac/vim-hardtime'
" Plugin 'blueyed/vim-diminactive' 
" Plugin 'scrooloose/nerdtree.git'
" Plugin 'Shougo/vimfiler.vim'
" Plugin 'myusuf3/numbers.vim'
" Plugin 'scrooloose/nerdtree.git'
" Plugin 'troydm/easytree.vim'
" Plugin 'tomtom/shymenu_vim'

call vundle#end()           

" Add my customizations to the rtp.
if s:is_windows
    set rtp+=$VIMRUNTIME/../vim-ycm-733de48-windows-x64
    set rtp+=$VIMRUNTIME/../vimfiles/rtp
else
    set rtp+=$HOME/.vim/rtp
endif

filetype plugin indent on    " required

" }}}
" ---------------------------------------------------------------------------- 
" Plugins (Manual) {{{


" }}}
" ---------------------------------------------------------------------------- 
" Appearance and GUI {{{

" This is a tip from
" https://github.com/itchyny/lightline.vim/blob/master/doc/lightline.txt.
" It seems to require
" export TERM=xterm-256color
" in .bashrc, though.
if !has('gui_running')
    set t_Co=256
endif

if &t_Co > 2 || has("gui_running")
    syntax on
endif

set background=dark
if &t_Co >= 256 || has("gui_running")

    " Candidates I choose not to use right now.
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
    " Solarized is fine, but there are some details I don't like.
    " It is designed so nothing stands out too much, but in practice, I'd like some
    " things to stand out, like the diff changes and folded regions.

    " No underlines and brighter fg color (See http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim).
    hi Folded term=bold ctermfg=11 ctermbg=8 gui=bold guifg=#d7d7af guibg=#073642 guisp=#002b36

    " Or the way it highlights diffs. In a diff, changes need to stand out more,
    " so I'm overwriting these styles with those of the jellybeans theme which does a better
    " job in my eyes.
    hi DiffAdd        term=bold ctermfg=193 ctermbg=22 guifg=#D2EBBE guibg=#437019
    hi DiffChange     term=bold ctermbg=24 guibg=#2B5B77
    hi DiffDelete     term=bold ctermfg=16 ctermbg=52 guifg=#40000A guibg=#700009
    hi DiffText       term=reverse cterm=reverse ctermfg=81 ctermbg=16 gui=reverse guifg=#8fbfdc guibg=#000000
    
endif
    
" We need a way to tell if we have access to patched fonts.
" Unfortunately, there doesn't seem to be a way to find the actually used
" font. We use a variable here and heuristics. If we figure out better ways,
" we set the variable accordingly. All respective logic uses the variable.
let s:has_patched_font = 0
if has('gui_running') && !s:is_windows
    " At the moment the patched fonts just don't look nice enough on Windows.
    let s:has_patched_font = 1
endif
let hostname = substitute(system('hostname'), '\n', '', '')
if hostname == "bravuntu"
    let s:has_patched_font = 1
endif

" We make whether we use normal (unpatched) unicode font features depend on
" this variable. 
let s:has_unicode_font = 1

if has('gui_running')
    set guioptions-=T           " Remove the toolbar
    set guioptions-=r           " Remove the right-hand scrollbar
    set guioptions-=L           " Remove the left-hand scrollbar
    set guioptions-=e           " No gui tabs
    " set guioptions-=t           " No tearoff menus

    " The "for Powerline" fonts come from https://github.com/powerline/fonts
    if s:is_mac
        set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
    elseif s:is_windows
        "set guifont=Inconsolata-g\ for\ Powerline\ 10,Consolas:h10,Andale_Mono:h10,Menlo:h10,Courier_New:h10
        set guifont=Consolas:h10,Andale_Mono:h10,Menlo:h10,Courier_New:h10
    else
        " Linux
        set guifont=Inconsolata-g\ for\ Powerline\ 10,Inconsolata-g\ 10,Inconsolata\ 11,Ubuntu\ Mono\ 11,Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
    endif
endif

set guitablabel=\[%N\]\ %t\ %M 

" Set the language for gvim's menus and more.
set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set tabpagemax=99
set noshowmode

" Highlight current line only in the current window.
set nocursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

highlight clear SignColumn
"highlight clear LineNr

" }}}
" ---------------------------------------------------------------------------- 
" Settings {{{

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

" Unbroken vertical split lines and neater folding look, plx.
set fillchars=vert:\│,fold:·
set foldmethod=marker
set foldmarker={{{,}}}
set foldcolumn=0
set nofoldenable                  " Auto fold code
" From http://dhruvasagar.com/2013/03/28/vim-better-foldtext:
function! NeatFoldText()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()


" Show whitespace?
set nolist
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

set wrap
set modelines=1

" Indentation Settings
set autoindent                  " Indent at the same level of the previous line
set expandtab                   " Tabs are spaces, not tabs
set nosmartindent               " smartindent sucks for anything but C-like languages.
autocmd FileType c,cpp,cs,objc setlocal smartindent
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set shiftwidth=4                " Use indents of 4 spaces

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
    let s:tmp_dir = expand('$VIM/tmp')
else
    let s:tmp_dir = expand('$HOME/.vim/unversioned/tmp')
endif
let &backupdir=s:tmp_dir
let &viewdir=s:tmp_dir
let &directory=s:tmp_dir
let &undodir=s:tmp_dir
let g:yankring_history_dir = s:tmp_dir

set noautochdir

set linebreak
if s:has_patched_font
    set showbreak=
elseif s:has_unicode_font
    set showbreak=►►
else
    set showbreak=>>
endif

set textwidth=0
set wrapmargin=0
set showmatch

" Disable visual and audio flash.
" See http://vim.wikia.com/wiki/Disable_beeping#Disable_beep_and_flash_with_an_autocmd
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set hlsearch
set smartcase
set ignorecase
set incsearch
  
set formatoptions+=l

set ruler
set showtabline=2
 
set undolevels=1000
set backspace=indent,eol,start

autocmd FileType vim setlocal nonumber

" }}}
" ---------------------------------------------------------------------------- 
" Restore cursor when re-entering window {{{

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

" }}}
" ---------------------------------------------------------------------------- 
" Diff mode {{{

set diffopt=filler,vertical
if &diff
    
    " Faster navigation between differences.
    map <C-Up> [c
    map <C-Down> ]c
    
    autocmd VimResized * wincmd =
        
    " Also see the diff-mode modification in ScreenRestore() below.
endif

" }}}
" ---------------------------------------------------------------------------- 
" Window pos/size restoring {{{
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
          
          if &diff
              " In diff mode, we want to start with equal sized windows.
              wincmd =
          endif
          
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

" }}}
" ---------------------------------------------------------------------------- 
" easymotion {{{
" https://github.com/Lokaltog/vim-easymotion
" http://net.tutsplus.com/tutorials/other/vim-essential-plugin-easymotion/

let g:EasyMotion_do_mapping = 0 " Disable default mappings

map <SPACE> <Plug>(easymotion-s2)

" }}}
" ---------------------------------------------------------------------------- 
" incsearch {{{
" https://github.com/haya14busa/incsearch.vim

if 1
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
endif

" }}}
" ---------------------------------------------------------------------------- 
" CtrlP {{{
" https://github.com/kien/ctrlp.vim

" Okay, I officially don't like the default matching.
" neither full path nor filename mode work intuitively enough.
" I cannot even get to the vimrc by typing "vimrc", that's just silly.
" And I'm not alone: https://github.com/kien/ctrlp.vim/issues/110
" Let's try this: https://github.com/JazzCore/ctrlp-cmatcher/
" or this: https://github.com/burke/matcher

if 0
    let g:ctrlp_working_path_mode = 'ra'

    if s:is_windows
        let g:ctrlp_match_func = {'match': 'pymatcher#PyMatch'}
    else
        let g:ctrlp_match_func = {'match' : 'matcher#cmatch'} 
    endif
    

    " Cache settings
    let g:ctrlp_use_caching = 1
    let g:ctrlp_clear_cache_on_exit = 0
    if s:is_windows
        set backupdir=$HOME/.vim/unversioned/tmp
        let g:ctrlp_cache_dir = expand("$HOME/.vim/unversioned/tmp")
    else
        let g:ctrlp_cache_dir = expand("$VIM/tmp")
    endif

    " Set delay to prevent extra search
    let g:ctrlp_lazy_update = 350
    
    let g:ctrlp_show_hidden = 1
    let g:ctrlp_default_input = 1    
    let g:ctrlp_max_files = 0
    let g:ctrlp_max_depth = 40
    let g:ctrlp_by_filename = 0 " Match in full path or just filename. Ctrl-d toggles.

    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn|CVS)$',
      \ 'file': '\v\.(exe|so|dll|pyc)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }
  
    if executable('ag')
        set grepprg=ag\ --nogroup\ --nocolor
    
        " Previously:
        " let s:ctrlp_fallback = 'ag -l --nocolor -g "" %s'
        " From http://blog.patspam.com/2014/super-fast-ctrlp, slightly modified.
        let s:ctrlp_fallback = 'ag -i --nocolor --nogroup --hidden
          \ --ignore .git
          \ --ignore .svn
          \ --ignore .hg
          \ --ignore CVS
          \ --ignore .DS_Store
          \ --ignore "**/*.exe"
          \ --ignore "**/*.so"
          \ --ignore "**/*.dll"
          \ --ignore "**/*.pyc"
          \ --ignore "**/*~"
          \ -g "" %s'
    elseif executable('ack-grep')
        let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
    elseif executable('ack')
        let s:ctrlp_fallback = 'ack %s --nocolor -f'
    elseif s:is_windows
        let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
    else
        let s:ctrlp_fallback = 'find %s -type f'
    endif
    
    " Delay this output: if we used echo(msg) here, a gui dialog would pop up.
    " This is because at startup the tty is not yet initialized.
    " autocmd VimEnter * echom "ctrl-p fallback:" s:ctrlp_fallback
        
    let g:ctrlp_user_command = {
        \ 'types': {
        \ },
        \ 'fallback': s:ctrlp_fallback
    \ }  

    " This is the original:
    " The git special case didn't work well for me. When using submodules, file in there
    " never end up in the candidate list I think. The same goes for files not
    " yet added to git.
    " let g:ctrlp_user_command = {
    "     \ 'types': {
    "         \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
    "         \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    "     \ },
    "     \ 'fallback': s:ctrlp_fallback
    " \ }  
    
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'

    map <C-O> :CtrlPMixed<CR>
    map <C-P> :CtrlPMenu<CR>

    let g:ctrlp_yankring_disable = 1

    let g:ctrlp_prompt_mappings = {
        \ 'PrtBS()':              ['<bs>', '<c-]>'],
        \ 'PrtDelete()':          ['<del>'],
        \ 'PrtDeleteWord()':      ['<c-w>'],
        \ 'PrtClear()':           ['<c-u>'],
        \ 'PrtSelectMove("j")':   ['<c-j>', '<down>'],
        \ 'PrtSelectMove("k")':   ['<c-k>', '<up>'],
        \ 'PrtSelectMove("t")':   ['<Home>', '<kHome>'],
        \ 'PrtSelectMove("b")':   ['<End>', '<kEnd>'],
        \ 'PrtSelectMove("u")':   ['<PageUp>', '<kPageUp>'],
        \ 'PrtSelectMove("d")':   ['<PageDown>', '<kPageDown>'],
        \ 'PrtHistory(-1)':       ['<c-n>'],
        \ 'PrtHistory(1)':        ['<c-p>'],
        \ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
        \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-s>'],
        \ 'AcceptSelection("t")': ['<c-t>'],
        \ 'AcceptSelection("v")': ['<c-v>', '<RightMouse>'],
        \ 'ToggleFocus()':        ['<s-tab>'],
        \ 'ToggleRegex()':        ['<c-r>'],
        \ 'ToggleByFname()':      ['<c-d>'],
        \ 'ToggleType(1)':        ['<c-f>', '<c-up>', '<c-h>'],
        \ 'ToggleType(-1)':       ['<c-b>', '<c-down>', '<c-l>'],
        \ 'PrtExpandDir()':       ['<tab>'],
        \ 'PrtInsert("c")':       ['<MiddleMouse>', '<insert>'],
        \ 'PrtInsert()':          ['<c-\>'],
        \ 'PrtCurStart()':        ['<c-a>'],
        \ 'PrtCurEnd()':          ['<c-e>'],
        \ 'PrtCurLeft()':         ['<left>', '<c-^>'],
        \ 'PrtCurRight()':        ['<right>'],
        \ 'PrtClearCache()':      ['<F5>'],
        \ 'PrtDeleteEnt()':       ['<F7>'],
        \ 'CreateNewFile()':      ['<c-y>'],
        \ 'MarkToOpen()':         ['<c-z>'],
        \ 'OpenMulti()':          ['<c-o>'],
        \ 'PrtExit()':            ['<esc>', '<c-c>', '<c-g>'],
        \ }

endif

" }}}
" ---------------------------------------------------------------------------- 
" Unite {{{
if 1

let g:unite_data_directory = s:tmp_dir
let g:unite_source_history_yank_enable = 1
if s:has_unicode_font
    let g:unite_prompt = '► '
else
    let g:unite_prompt = '>> '
endif

call unite#custom#profile('default', 'context', {
\   'start_insert': 1,
\   'winheight': 10,
\   'direction': 'botright',
\ })

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <silent> <c-i> :Unite -auto-resize buffer source bookmark register history/yank<cr>
nnoremap <silent> <c-o> :Unite -auto-resize buffer file_mru file file_rec/async -default-action=split<cr>
nnoremap <silent> <c-p> :Unite -auto-resize file_rec/async -default-action=split<cr>

autocmd FileType unite call s:my_unite_settings()
function! s:my_unite_settings()

    nmap <buffer> <C-j>   <Plug>(unite_select_next_line)
    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    nmap <buffer> <C-k>   <Plug>(unite_select_previous_line)
    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
    nmap <buffer> a <Plug>(unite_choose_action)
    
    " Shorten path one part
    imap <buffer> <C-h> <Plug>(unite_delete_backward_path)
    
    nmap <buffer><silent> <C-i> :UniteClose<Cr>
    nmap <buffer><silent> <C-o> :UniteClose<Cr>
    nmap <buffer><silent> <C-p> :UniteClose<Cr>
    imap <buffer><silent> <C-i> <Esc>:UniteClose<Cr>
    imap <buffer><silent> <C-o> <Esc>:UniteClose<Cr>
    imap <buffer><silent> <C-p> <Esc>:UniteClose<Cr>
endfunction

if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_recursive_opt = ''    
    let g:unite_source_grep_default_opts = '-i --nocolor --nogroup --hidden -S -C4
          \ --ignore .git
          \ --ignore .svn
          \ --ignore .hg
          \ --ignore CVS
          \ --ignore .DS_Store
          \ --ignore "**/*.exe"
          \ --ignore "**/*.so"
          \ --ignore "**/*.dll"
          \ --ignore "**/*.pyc"
          \ --ignore "**/*~"
          \ -g ""'
    let g:unite_source_rec_async_command = 'ag '.g:unite_source_grep_default_opts
endif



if 0

" From the top comment at http://bling.github.io/blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/
"
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
"
"nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
"nnoremap <leader>ff :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
"nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
"nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
"nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
"nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

"nnoremap <leader>ft :Unite file_rec/async -default-action=tabopen
"nnoremap <leader>fs :Unite file_rec/async -default-action=split
"nnoremap <leader>fv :Unite file_rec/async -default-action=vsplit
"nnoremap <leader>fc :Unite file_rec/async

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction
if executable('jvgrep')
    let g:unite_source_grep_command = 'jvgrep'
    let g:unite_source_grep_default_opts = '-i --exclude ''\.(git|svn|hg|bzr)'''
    let g:unite_source_grep_recursive_opt = '-R'
endif
if executable('ack-grep')
    let g:unite_source_grep_command = 'ack-grep'
    let g:unite_source_grep_default_opts = '-i --no-heading --no-color -k -H'
    let g:unite_source_grep_recursive_opt = ''
endif
endif

endif

" }}}
" ---------------------------------------------------------------------------- 
" lightline {{{

set laststatus=2

let g:lightline = {
    \ 'colorscheme': 'jw',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'filename' ], ['ctrlpmark'] ],
    \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ], [ 'fugitive' ] ]
    \ },
    \ 'inactive': {
    \   'left': [ ['filename'] ],
    \   'right': [ [ 'lineinfo' ], ['percent'] ],
    \ },
    \ 'tabline': {
    \   'left': [ [ 'tabs' ] ],
    \   'right': [ [ 'close' ] ],
    \ },
    \ 'tab': {
    \   'active': ['tabnum', 'fullfilename'],
    \   'inactive': ['tabnum', 'filename'],
    \ },
    \ 'tab_component_function': {
    \   'filename': 'MyTabFilename',
    \   'fullfilename': 'MyTabFullFilename'
    \ },
    \ 'component_function': {
    \   'fugitive': 'MyFugitive',
    \   'filename': 'MyFilename',
    \   'fullfilename': 'MyFullFilename',
    \   'fileformat': 'MyFileformat',
    \   'filetype': 'MyFiletype',
    \   'fileencoding': 'MyFileencoding',
    \   'mode': 'MyMode',
    \   'ctrlpmark': 'CtrlPMark',
    \ },
    \ }

function! MyModified()
    let mark = '+'
    if s:has_unicode_font
        let mark = '★'
    endif
    return &ft =~ 'help' ? '' : &modified ? mark : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    let mark = 'RO'
    if s:has_patched_font
       let mark = ''
    elseif s:has_unicode_font
       let mark = '☒'
    endif
    return &ft !~? 'help' && &readonly ? mark : ''
endfunction

function! MyTabFullFilename(tabindex)
    "echo getbufvar(1, "&modfied")
    "echo getbufvar(1, "&readonly")
    " gettabva
    return "bar"
endfunction

function! MyTabFilename(tabindex)
    return "foo"
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
        \ ('' != fname ? ( winwidth(0) > 50 ? expand('%:p') : fname ) : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
            let mark = ''
            if s:has_patched_font
                let mark = ' '
            endif
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

if s:has_patched_font
	let g:lightline.separator = { 'left': '', 'right': '' }
    let g:lightline.subseparator = { 'left': '', 'right': '' }
else
    let g:lightline.separator = { 'left': '', 'right': '' }
    let g:lightline.subseparator = { 'left': '|', 'right': '|' }
endif

" }}}
" ---------------------------------------------------------------------------- 
" UndoTree {{{

if 1
    nnoremap <Leader>u :UndotreeToggle<CR>
    " If undotree is opened, it is likely one wants to interact with it.
    let g:undotree_SetFocusWhenToggle=1
endif

" }}}
" ---------------------------------------------------------------------------- 
" Syntastic {{{
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

" }}}
" ---------------------------------------------------------------------------- 
" bbye {{{
" https://github.com/moll/vim-bbye

if 1
    if !&diff
        " Only do this in non-diff mode for now.
        map <silent> <C-W> :Bdelete<CR>
        map! <silent> <C-W> <Esc>:Bdelete<CR>
    endif
endif

" }}}
" ---------------------------------------------------------------------------- 
" dwm {{{
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
    map <C-L> <Plug>DWMFocus

    " map <C-L> <Plug>DWMGrowMaster
    " map <C-H> <Plug>DWMShrinkMaster
endif

" }}}
" ---------------------------------------------------------------------------- 
" GoldenView {{{
" http://zhaocai.github.io/GoldenView.Vim/

if 0
    let g:goldenview__enable_default_mapping = 0
  
    "nmap <silent> <C-N> :wincmd n<Cr>
    " 1. split to tiled windows
    "nmap <silent> <C-N>  <Plug>GoldenViewSplit

    " 2. quickly switch current window with the main pane
    " and toggle back
    "nmap <silent> <C-l>  <Plug>GoldenViewSwitchMain

    " 3. jump to next and previous window
    "nmap <silent> <C-k>  <Plug>GoldenViewNext
    "nmap <silent> <C-j>  <Plug>GoldenViewPrevious
    "
endif

" }}}
" ---------------------------------------------------------------------------- 
" YouCompleteMe {{{
" https://github.com/Valloric/YouCompleteMe
" http://stackoverflow.com/a/24520161 

if 1
    " Auto-close scratch window.
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1

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

    if s:is_windows
        let g:ycm_filetype_blacklist = {
        \ 'tagbar' : 1,
        \ 'qf' : 1,
        \ 'notes' : 1,
        \ 'markdown' : 1,
        \ 'unite' : 1,
        \ 'text' : 1,
        \ 'vimwiki' : 1,
        \ 'pandoc' : 1,
        \ 'infolog' : 1,
        \ 'mail' : 1
        \}
        let g:ycm_filetype_blacklist.c = 1
        let g:ycm_filetype_blacklist.cpp = 1
    endif

    if 0
        let g:ycm_server_use_vim_stdout = 1
        let g:ycm_server_log_level = 'debug'
    endif
endif

" }}}
" ---------------------------------------------------------------------------- 
" SnipMate {{{
" https://github.com/msanders/snipmate.vim/blob/master/doc/snipMate.txt

if 0
    imap <C-h> <Plug>snipMateNextOrTrigger
    smap <C-h> <Plug>snipMateNextOrTrigger
endif
" }}}
" ---------------------------------------------------------------------------- 
" UltiSnips {{{
" https://github.com/SirVer/ultisnips

if 1
    let g:UltiSnipsExpandTrigger="<C-h>"
    
    " Unfortunately, using the same mapping for both functions
    " seems to break completion with default values.
    "let g:UltiSnipsJumpForwardTrigger="<C-h>"
    let g:UltiSnipsJumpForwardTrigger="<C-j>"
    let g:UltiSnipsJumpBackwardTrigger="<C-k>"    

    let g:UltiSnipsEditSplit="normal"

    if s:is_windows
        let g:UltiSnipsSnippetsDir = expand('$VIM/vimfiles/UltiSnips')
    else
        let g:UltiSnipsSnippetsDir = expand('$HOME/.vim/UltiSnips')
    endif    
endif
" }}}
" ---------------------------------------------------------------------------- 
" fugitive {{{
" TODO: See http://www.reddit.com/r/vim/comments/21f4gm/best_workflow_when_using_fugitive/
" and http://mislav.uniqpath.com/2014/02/hidden-documentation/

" No customizations here yet.

" }}}
" ---------------------------------------------------------------------------- 
" Yankround {{{

if 0
    nmap p <Plug>(yankround-p)
    nmap P <Plug>(yankround-P)
    "nmap <C-p> <Plug>(yankround-prev)
    "nmap <C-n> <Plug>(yankround-next)
endif

" }}}
" ---------------------------------------------------------------------------- 
" Rainbow parentheses {{{
" https://github.com/kien/rainbow_parentheses.vim

if 1
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
    nmap <leader>r :RainbowParenthesesToggle<Cr>
endif

" }}}
" ---------------------------------------------------------------------------- 
" Startify {{{
" https://github.com/mhinz/vim-startify

if 1
    "TODO: doesn't work yet. Figure it out.
    "autocmd BufNew "" Startify
endif

" }}}
" ---------------------------------------------------------------------------- 
" Expand-Region {{{
" https://github.com/terryma/vim-expand-region

if 1
endif

" }}}
" ---------------------------------------------------------------------------- 
" visual_studio.vim {{{
" https://github.com/lorry-lee/visual_studio.vim

if 1
    nnoremap <F5> :call DTEBuildStartupProject()<Cr>
endif

" }}}
" ---------------------------------------------------------------------------- 
" Better Python syntax highlighting {{{
" https://github.com/hdima/python-syntax

let python_highlight_all = 1

" }}}
" ---------------------------------------------------------------------------- 
" General key mappings {{{

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

" Ctrl-S saves. This might not work in a terminal Vim.
noremap <C-S> <Esc>:update<CR>
inoremap <C-S> <Esc>:update<CR>

" nnoremap <Tab> <C-j>
" nnoremap <S-Tab> <C-k>
" nnoremap <C-Tab> <C-j>

" noremap <C-L> :windo set invnumber<CR>
" noremap! <C-L> <Esc>:windo set invnumber<CR>
" noremap <Shift-C-L> :set invnumber<CR>
" noremap! <Shift-C-L> <Esc>:set invnumber<CR>

nnoremap <silent> <F1> :set nu!<Cr>


" From http://stackoverflow.com/a/25887606:
:autocmd CursorMoved * exe exists("HlUnderCursor")?HlUnderCursor?printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\')):'match none':""
let HlUnderCursor=0
noremap <silent> <F3> :exe "let HlUnderCursor=exists(\"HlUnderCursor\")?HlUnderCursor*-1+1:1"<CR>
" TODO: see this http://www.vim.org/scripts/script.php?script_id=4306

autocmd FileType python nnoremap <buffer> <F8> :exec '!python' shellescape(@%, 1)<cr>

" }}}
" ---------------------------------------------------------------------------- 
" Demo mode {{{
" Enable to get a look better suited to presentations/projectors:

if 0
    " Make stuff bigger and spacier.
    if 1
        set guifont=Consolas:h14,Andale_Mono:h14,Menlo:h14,Courier_New:h14
        let g:dwm_master_pane_width="80%"
    endif

    " Light colorscheme? Here you are.
    if 1
        set background=light
        colorscheme sol
        "colorscheme github
    endif
endif

" }}}
" ---------------------------------------------------------------------------- 

" vim:fen:fdm=marker:fmr={{{,}}}:fdl=0:fdc=1
