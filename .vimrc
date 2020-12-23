"################################################################################
"## VIMRC
"Author : Ofer Koren
"Revision History
"	Ofer	01-Mar-2015	Initial version

"================================================================================
" Plugins
let VundleInstalled=1
let vundle_readme=expand($HOME.'/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
	echo "Installing Vundle ..."
	echo ""
	silent !mkdir -p $HOME/.vim/bundle
	silent !git clone https://github.com/VundleVim/Vundle.vim $HOME/.vim/bundle/Vundle.vim
	let VundleInstalled=0
endif

if filereadable(vundle_readme)
	set nocompatible              " required
	filetype off                  " required
	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()

	" alternatively, pass a path where Vundle should install plugins
	"call vundle#begin('~/some/path/here')

	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" let Vundle manage Vundle, required
	Plugin 'gmarik/Vundle.vim'
	" Python
	Plugin 'vim-python/python-syntax'
	Plugin 'davidhalter/jedi-vim'
	" NerdTree
	"Plugin 'Xuyuanp/nerdtree-git-plugin'
	Plugin 'scrooloose/nerdtree'
	Plugin 'tpope/vim-fugitive'
	" Status line
	Plugin 'vim-airline/vim-airline'
	Plugin 'vim-airline/vim-airline-themes'
	" Buffer explorer
	Plugin 'fholgado/minibufexpl.vim'
	""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" add all your plugins here (note older versions of Vundle
	" used Bundle instead of Plugin)
	map <F2> :NERDTreeToggle<CR>
	" Open NERDTree in the directory of the current file (or /home if no file is open)
	nmap <F3> :call NERDTreeToggleInCurDir()<cr>
	function! NERDTreeToggleInCurDir()
		" If NERDTree is open in the current buffer
		if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
			exe ":NERDTreeClose"
		else
			exe ":NERDTreeFind"
		endif
	endfunction
	let NERDTreeQuitOnOpen = 1
	let g:jedi#completions_command = "<C-Space>"
	let g:jedi#show_call_signatures= 2
	" ...
	"let g:airline#extensions#tabline#enabled = 1
	"let g:airline#extensions#tabline#left_sep = ' '
	"let g:airline#extensions#tabline#left_alt_sep = '>'
	"let g:airline_left_sep='>'
	"let g:airline_right_sep='<'
	"let g:airline_theme='dark'

	if VundleInstalled == 0
		echo "Installing Plugins, please ignore key map error messages"
		echo ""
		:PluginInstall
	endif
	" All of your Plugins must be added before the following line
	call vundle#end()            " required
	filetype plugin indent on    " required

	" Configuration for python-syntax
	let g:python_highlight_all = 1
endif


"================================================================================
" General
silent! E227

if filereadable("/etc/vim/vimrc")
	source /etc/vim/vimrc
endif

"================================================================================
" load syntax files
if filereadable("/usr/share/vim/vim73/syntax/valgrind.vim")
	source /usr/share/vim/vim73/syntax/valgrind.vim
endif
au BufReadPost *.valgrind set syntax=valgrind
au FileType gradle set filetype=groovy
au BufNewFile,BufRead,BufEnter,TabEnter *.gradle set filetype=groovy
au BufNewFile,BufRead,BufEnter,TabEnter  gradle.* set filetype=groovy

function! s:Log(eventName) abort
	  silent execute '!echo '.a:eventName.' >> log'
endfunction

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
"inoremap {      {}<Left>
"inoremap {<CR>  {<CR>}<Esc>O
"inoremap {{     {
"inoremap {}     {}

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
autocmd FileType c      set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType cpp    set tabstop=4|set shiftwidth=4|set expandtab
"autocmd FileType yaml   set tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType yaml   setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml   setlocal re=1
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
autocmd BufNewFile,BufRead FileType python
	\ set tabstop=4
	\ set softtabstop=4
	\ set shiftwidth=4
	\ set textwidth=79
	\ set expandtab
	\ set autoindent
	\ set fileformat=unix
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
highlight User2 ctermfg=darkred  ctermbg=grey
highlight User3 ctermfg=darkblue ctermbg=grey
set laststatus=2
set statusline=
set statusline+=%1*\ %n\ %*		"buffer number
set statusline+=%1*\ %<%F%*		"full file name
set statusline+=%3*%=%y%*		"file type
set statusline+=%3*%=%5{&ff}%*	"file format
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
" cscope
"if filereadable("cscope.out")
"	cs add cscope.out
"elseif $CSCOPE_DB != ""
"	cs add $CSCOPE_DB
"endif						"
"================================================================================

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

