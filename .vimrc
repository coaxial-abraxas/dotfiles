" Enable Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" git gutters!
Plugin 'airblade/vim-gitgutter'

" A dark color theme
Plugin 'sjl/badwolf'

" Comments!
Plugin 'tpope/vim-commentary'

" Fuzzy file finder
Plugin 'ctrlpvim/ctrlp.vim'

" Status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" git status in airline
Plugin 'tpope/vim-fugitive'

" GitHub sugar
Plugin 'tpope/vim-rhubarb'

" Improve JSON highlighting
Plugin 'leshill/vim-json'

" Asynchronous linting
Plugin 'w0rp/ale'

" Interface with OS X Dash
Plugin 'rizzatti/dash.vim'

" Session management
Plugin 'thaerkh/vim-workspace'
let g:workspace_persist_undo_history = 0
let g:workspace_autosave_always = 1
" toggle workspace with leader-s
noremap <leader>s :ToggleWorkspace<CR>

" Autoimport statements for JS
Plugin 'galooshi/vim-import-js'

" Emmet
Plugin 'mattn/emmet-vim'
let g:user_emmet_settings = {
      \  'javascript.jsx' : {
      \    'extends' : 'jsx',
      \  },
      \}
let g:user_emmet_mode='a'

" Close buffer without closing vim
Plugin 'qpkorr/vim-bufkill'
noremap <leader>w :BD<CR>

" unix commands to vim commands
Plugin 'tpope/vim-eunuch'

" All in one syntax highlighting
Plugin 'sheerun/vim-polyglot'

" Per project editor config
Plugin 'editorconfig/editorconfig-vim'

" Autoclose quotes etc
Plugin 'raimondi/delimitmate'

" Logstash files syntax highlighting
Plugin 'robbles/logstash.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2014 Feb 05
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

" Count lines
set nu

" Turn relative numbering on/off with Ctrl-t
function! TRelative()
  set relativenumber!
endfunc

noremap <c-t> :call TRelative()<cr>

" Show delimiter for text being edited
set cpoptions+=$

" Clear search highlight with Ctrl-l
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Show suggestions above the command line when hitting <Tab>
set wildmenu

" Set tabs to 2 spaces
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab

" Close current buffer and switch to the previous one
nnoremap <C-c> :bd\|bp #<CR>

" Mark the line limit
set cc=80

" Enable visual bell and disable audible bell
set vb
set noeb

" Disable auto-folding in markdown files
let g:vim_markdown_folding_disabled=1

" Use dark background color schemes
set bg=dark

" Crontab workaround as per http://drawohara.com/post/6344279/crontab-temp-file-must-be-edited-in-place
if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

" This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Open CtrlP with <c-p>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" Ignore directories
" let g:ctrlp_custom_ignore = '\v[\/](tmp\|node_modules)$'
set wildignore+=*/tmp/*,*/node_modules/*
" Dont crawl parent directories
let g:ctrlp_working_path_mode = 'ra'

" Save files with sudo when I forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

" Dark colors are easier on the eyes
colorscheme badwolf

" Indent chain method calls (for leafgarland/typescript-vim)
setlocal indentkeys+=0.

" Always show vim-airline
set laststatus=2

" CtrlP to show hidden files
let g:ctrlp_show_hidden = 1

" Enable 256 colors in vim
set t_Co=256

" Move entire lines up and down
" (with help from https://stackoverflow.com/a/15399297/2774883)
" Because OS X is a special snowflake, it doesn't have a readily accessible
" Alt key so instead we map these commands to the resulting character from
" pressing ⌥  + j/k
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv
" Linux is more reasonable and has Alt keys
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
