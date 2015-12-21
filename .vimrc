"##############################################################################
"## VIMRC
"Author : Ofer Koren
"Revision History
"	Ofer	01-Mar-2015	Initial version


if filereadable("/etc/vim/vimrc")
	source /etc/vim/vimrc
endif


" Valgrind syntax
if filereadable("/usr/share/vim/vim73/syntax/valgrind.vim")
	source /usr/share/vim/vim73/syntax/valgrind.vim
endif
au BufReadPost *.valgrind set syntax=valgrind


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


" Closing brace
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

" Buffer Switch : <Tab>
set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
nnoremap <Tab> :b <C-Z>

" Tabs to space in python
autocmd FileType * set noexpandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab

" Search
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
"Clear serach by space
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Status line
hi User1 ctermfg=black    ctermbg=grey
hi User2 ctermfg=black    ctermbg=grey
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

" Colors
hi Comment ctermfg=DarkGreen

