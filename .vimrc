"######################## Start vundle and load plugins #########################

" Reqs for Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

" Start vundle and load plugins
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
" Bottom titlebar
Plugin 'itchyny/lightline.vim'
" Color Theme
Plugin 'sickill/vim-monokai'
" NerdTree Filebrowser
Plugin 'scrooloose/nerdtree.git'
" FuzzyFinder file browsing
Plugin 'vim-scripts/L9'
Plugin 'vim-scripts/FuzzyFinder'
Plugin 'Valloric/YouCompleteMe'
" Ultisnip snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" Surround tags
Plugin 'tpope/vim-surround'
" Sublime like multiple cursor selection
Plugin 'terryma/vim-multiple-cursors'
"Right side minimap
Plugin 'severin-lemaignan/vim-minimap'
" Improved PHP syntax highlighting
Plugin 'StanAngeloff/php.vim'
" Dockerfile syntax highlighting
Plugin 'ekalinin/Dockerfile.vim'
" Faster navigation by keyboard
Plugin 'Lokaltog/vim-easymotion'
" Highlight closing HTML tags
Plugin 'Valloric/MatchTagAlways'
" Vim Sessions plugin for dealing with multiple tabs
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-misc'
" Autoclose brackets
Plugin 'cohama/lexima.vim'
call vundle#end()

"############################### Default config #################################

" Load indentation files from indent folder
filetype plugin indent on

" Autoload and save Views for folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" Use the OS clipboard
set clipboard=unnamedplus

" Enhance command-line completion
set wildmenu

" Optimize for fast terminal connections
set ttyfast

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

" Don’t show the intro message when starting Vim
set shortmess=atI

" Disable error bells
set noerrorbells

" Auto reload .vimrc when changes have been made
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Move cursor to last known position when opening file
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\	exe "normal! g`\"" |
\ endif
" Remember info about open buffers on close
set viminfo^=%

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure

" Enable autoindentation
set autoindent

if has("autocmd")
   " Enable file type detection
    filetype on
   " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
   " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" Make sure files uses real tabs, not spaces
set noexpandtab
" Round indent to multiple of 'shiftwidth'
set shiftround
" Smart indent new lines
set smartindent
" Copy indent from current line to new line
set autoindent

" Set the tab width
set shiftwidth=1
let s:tabwidth=4
exec 'set tabstop='    .s:tabwidth
exec 'set softtabstop='.s:tabwidth

" Enable reading of modelines from opened files
set modeline
set modelines=4

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Enable sql syntax highlighting inside strings
let php_sql_query = 1

" Set default foldmethod and allow manual folds when method is something else
set foldmethod=syntax
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

"########################## Movement / Keybindings  #############################

" Allow cursor keys in insert mode
set esckeys

" Allow backspace in insert mode
set backspace=indent,eol,start

" Enable mouse in all modes
set mouse=a

" Bind leader key
let mapleader=","

" Fix for treating long lines as linebreaks (Makes moving around easier)
map <Up> gk
map <Down> gj

" Fast tab creation and movement
map <leader>tn :tabnew<CR>
map <leader>to :tabonly<CR>
map <leader>tc :tabclose<CR>
map <leader><Right> :tabnext<CR>
map <leader><Left> :tabprev<CR>
map <leader><Up> :tabnext<CR>
map <leader><Down> :tabprev<CR>

" Toggle NerdTree plugin
map <C-n> :NERDTreeToggle<CR>

" Toggle FuzzyFinder plugin
map <C-p> :FufFile<CR>

" Toggle easymotion plugin single letter search
nmap s <Plug>(easymotion-s)

" Toggle easymotion plugin double letter search
nmap ss <Plug>(easymotion-s2)

" Faster fold creation
vnoremap <Space><Space> zf

" Faster fold toggling
nnoremap <space> za

" Custom defined Line numbering function
nnoremap <leader>ln :call NumberToggle()<cr>

" Custom defined strip whitespace function
noremap <leader>ss :call StripWhitespace()<CR>

" Save file as root
noremap <leader>W :w !sudo tee % > /dev/null<CR>

nnoremap <CR> G

"################################# Appearance ###################################

" Enable powerline fonts
let g:airline_powerline_fonts = 1

" Enable monokai theme
colorscheme monokai

" Enable syntax highlighting
syntax on

" Show the cursor position
set ruler

" Always show status line
set laststatus=2

" Enable line numbers
set number

" Highlight current line and column
set cursorline
set cursorcolumn

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title

" Show the (partial) command as it’s being typed
set showcmd

" Configuration for ligtline bottom bar
let g:lightline = {
\	'component': {
\		'readonly': '%{&readonly?"":""}',
\	},
\	'separator': { 'left': '', 'right': '' },
\	'subseparator': { 'left': '', 'right': '' }
\}
set guifont=Menlo\ For\ Powerline

"############################### Search Config  #################################

" Highlight searches
set hlsearch

" Case insensitive searches
set ignorecase

" Highlight dynamically as pattern is typed
set incsearch

" Add the g flag to search/replace by default
set gdefault

"############################### Plugin Config  #################################

" Enable NerdTree file browser and auto close window if its the only one left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Easymotion plugin config
" Disable default key mappings
let g:EasyMotion_do_mapping = 0
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" Ultisnips plugin config
let g:UltiSnipsExpandTrigger="<leader><leader>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><tab>"

" Session plugin config
" Save vim sessions periodicly
let g:session_autosave_periodic = 1
" Auto save sessions when vim is closed
let g:session_autosave = 'yes'

" Multiple cursors plugin config
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<C-d>'

" MatchTagAlways plugin config
" Highlight closing tag in certain filetypes
let g:mta_filetypes = {
\ 'html' : 1,
\ 'xhtml' : 1,
\ 'xml' : 1,
\ 'php' : 1,
\}
" Disable usage of vims colorscheme for matching
let g:mta_use_matchparen_group = 0

"############################## Custom functions  ###############################

" Strip all trailing whitespace
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction

" Toggle between relative and absolute line numbering
function! NumberToggle()
	if(&relativenumber == 1)
		set norelativenumber
		set number
		highlight LineNr ctermfg=yellow
	else
		set relativenumber
		highlight LineNr ctermfg=green
	endif
endfunc
