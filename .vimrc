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

" Comments!
Plug 'tpope/vim-commentary'

" Fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" git status in airline
Plug 'tpope/vim-fugitive'

" GitHub sugar
Plug 'tpope/vim-rhubarb'

" Improve JSON highlighting
Plug 'leshill/vim-json'

" Interface with OS X Dash
Plug 'rizzatti/dash.vim'

" Session management
Plug 'thaerkh/vim-workspace'
let g:workspace_persist_undo_history = 0
" toggle workspace with leader-s
noremap <leader>s :ToggleWorkspace<CR>

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

" unix commands to vim commands
Plug 'tpope/vim-eunuch'

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
Plug 'raimondi/delimitmate'
let delimitMate_expand_space = 1
let delimitMate_expand_inside_quotes = 1
let delimitMate_expand_cr = 1

" Logstash files syntax highlighting
Plug 'robbles/logstash.vim'

" Better Postgres syntax highlighting
Plug 'exu/pgsql.vim'
" Consider all .sql files as Postgres files
let g:sql_type_default = 'pgsql'

Plug 'tpope/vim-unimpaired'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" Store snippets where I can find them
let g:UltiSnipsSnippetDirectories=["~/.vim/UltiSnips", "UltiSnips"]

" Note taking
Plug 'vimwiki/vimwiki'
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdow': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]
" Instant markdown previews
Plug 'suan/vim-instant-markdown'
" Autopreview might be annoying, uncomment to disable
" let g:instant_markdown_autostart = 0
" Preview with \md
map <leader>md :InstantMarkdownPreview<CR>

Plug 'osyo-manga/vim-over'

Plug 'stephenway/postcss.vim'

Plug 'ngmy/vim-rubocop'

" Install these CoC extensions if not present
let g:coc_global_extensions = ['coc-json', 'coc-solargraph']

Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install() }}
" Manually run prettier with :Prettier
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
" typescript support with `:CocInstall coc-tsserver`

call plug#end()

" Highlight comments in JSON files
autocmd FileType json syntax match Comment +\/\/.\+$+

" Start CoC configuration
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other
" plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current
" paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature
" of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p :<C-u>CocListResume<CR>
" End CoC configuration

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
set wildignore+=*/tmp/*,*/node_modules/*,*/coverage/*
" Dont crawl parent directories
let g:ctrlp_working_path_mode = 'ra'

" Save files with sudo when I forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

" Dark colors are easier on the eyes
colorscheme gruvbox

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
