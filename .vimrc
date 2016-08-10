"################################################################################
"## VIMRC
"Author : Ofer Koren
"Revision History
"	Ofer	01-Mar-2015	Initial version

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

"use system clipboard
set clipboard=unnamed

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
set background=dark
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

