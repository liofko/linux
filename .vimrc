"################################################################################
"## VIMRC
"Author : Ofer Koren
"Revision History
"	Ofer	01-Mar-2015	Initial version

" Vundle - plugin manager
if filereadable("~/.vim/bundle/Vundle.vim")
	"before adding it need to download Vundle:
	"	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	set nocompatible              " required
	filetype off                  " required
	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()

	" alternatively, pass a path where Vundle should install plugins
	"call vundle#begin('~/some/path/here')

	" let Vundle manage Vundle, required
	Plugin 'gmarik/Vundle.vim'
	Plugin 'vim-python/python-syntax'
	" add all your plugins here (note older versions of Vundle
	" used Bundle instead of Plugin)

" ...

	" All of your Plugins must be added before the following line
	call vundle#end()            " required
	filetype plugin indent on    " required

	let g:python_highlight_all = 1
endif


if filereadable("/etc/vim/vimrc")
	source /etc/vim/vimrc
endif

"================================================================================
" load syntax files
if filereadable("/usr/share/vim/vim73/syntax/valgrind.vim")
	source /usr/share/vim/vim73/syntax/valgrind.vim
endif
au BufReadPost *.valgrind set syntax=valgrind

"================================================================================
" General
syntax on
set history=1000
set undolevels=1000
set nu
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set ruler
set number
set title
set cmdheight=2

" Use system clipboard
set clipboard=unnamedplus

" Moving between Windows with Alt+<arrow key>
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

"================================================================================
" Closing brace
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

"================================================================================
" Buffer Switch : <Tab>
set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
nnoremap <Tab> :b <C-Z>

"================================================================================
" File type specific settings
filetype on " enable file type detection
filetype plugin on " load the plugins for specific file types
filetype indent on " automatically indent code
autocmd FileType * set noexpandtab
" Tabs to space in specific languages
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType c      set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType cpp    set tabstop=4|set shiftwidth=4|set expandtab

"================================================================================
" Search
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
"Clear serach by space
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

"================================================================================
" Status line

highlight User1 ctermfg=black    ctermbg=grey
highlight User2 ctermfg=black    ctermbg=grey
set laststatus=2
set statusline=
set statusline+=%1*\ %n\ %*		"buffer number
set statusline+=%1*\ %<%F%*		"full file name
set statusline+=%1*%=%y%*		"file type
set statusline+=%1*%=%5{&ff}%*	"file format
set statusline+=%2*%=%5l%*		"current line
set statusline+=%2*/%L%*		"total lines
set statusline+=%2*%4v\ %*		"current column
set statusline+=%2*\ \ %m%r%w\ %P\ \ "modified readonly? Top/Bot "Top/Bot/Modified

"================================================================================
" Colors

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes work
  " properly within 256-color terminals
  set t_ut=
endif

if has('gui_running')
    set background=dark
	colorscheme koehler
else
    set background=dark
endif


highlight Comment ctermfg=DarkGreen

" Completion menu
highlight Pmenu    ctermfg=white ctermbg=black
highlight PmenuSel ctermfg=red ctermbg=Black

" Highlight specific characters
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd   BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd   InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd   InsertLeave * match ExtraWhitespace /\s\+$/


"================================================================================
" commands
" Grep - grep files and open a results list
command -nargs=* Grep execute "lvim" '<args>' "| lw"

"================================================================================
" Functions (To launch type - :call <func name>)
" ShowAll - Show all characters
function! ShowAll()
	set listchars=eol:$,tab:>-,trail:.,nbsp:_,extends:+,precedes:+
	set list
endfunction

" ShowNone - Do not show all characters
function! ShowNone()
	set nolist
endfunction

