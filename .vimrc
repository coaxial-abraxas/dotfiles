if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" git gutters!
Plug 'airblade/vim-gitgutter'

" A dark color theme
Plug 'morhetz/gruvbox'
Plug 'rafalbromirski/vim-aurora'

" Comments!
Plug 'tpope/vim-commentary'

" Fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" git status in airline
Plug 'tpope/vim-fugitive'

" Improve JSON highlighting
Plug 'leshill/vim-json'

" Autoimport statements for JS
Plug 'galooshi/vim-import-js'

" Emmet
Plug 'mattn/emmet-vim'
let g:user_emmet_settings = {
      \  'javascript.jsx' : {
      \    'extends' : 'jsx',
      \  },
      \}
let g:user_emmet_mode='a'

" Close buffer without closing vim
Plug 'qpkorr/vim-bufkill'
noremap <leader>w :BD<CR>

" All in one syntax highlighting
Plug 'sheerun/vim-polyglot'
let g:javascript_plugin_flow = 1
" Uncomment for autofolding JS files
" augroup javascript_folding
"   au!
"   au FileType javascript setlocal foldmethod=syntax
" augroup END

" Per project editor config
Plug 'editorconfig/editorconfig-vim'

" Autoclose quotes etc
Plug 'tpope/vim-endwise'
Plug 'rstacruz/vim-closer'

" Logstash files syntax highlighting
Plug 'robbles/logstash.vim'

" Better Postgres syntax highlighting
Plug 'exu/pgsql.vim'
" Consider all .sql files as Postgres files
let g:sql_type_default = 'pgsql'

Plug 'tpope/vim-unimpaired'

Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
" Edit UltiSnips in a vertical split
let g:UltiSnipsEditSplit="vertical"
" Store snippets where I can find them
let g:UltiSnipsSnippetDirectories=["~/.vim/UltiSnips", "UltiSnips"]
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<leader-tab>""

" Preview substitutions
Plug 'osyo-manga/vim-over'

" Support PostCSS
Plug 'stephenway/postcss.vim'

Plug 'ngmy/vim-rubocop'

" Show line indents
Plug 'Yggdroot/indentLine'
" each indent level has a different character
let g:indentLine_char_list = ['▏', '|', '¦', '┆', '┊']

" Autocompletion
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --all'  }
nnoremap <buffer> <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <buffer> <silent> <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <buffer> <silent> <leader>rr :YcmCompleter RefactorRename<space>

" Prettier formatting
Plug 'prettier/vim-prettier', { 'do': 'npm install'  }
" Only format automatically when a prettier config file exists
let g:prettier#autoformat_config_present = 1

call plug#end()

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Highlight comments in JSON files
autocmd FileType json syntax match Comment +\/\/.\+$+

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup undofile swapfile
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

" Count lines
set nu

" Turn relative numbering on/off with Ctrl-t
function! TRelative()
  set relativenumber!
endfunc

noremap <c-t> :call TRelative()<cr>

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
set wildignore+=*/tmp/*,*/node_modules/*,*/coverage/*
" Dont crawl parent directories
let g:ctrlp_working_path_mode = 'ra'

colorscheme aurora
" Fix colors with tmux
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

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

" write with sudo using :w!!
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" always have cursor in the middle of the window
set scrolloff=9999

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None "
