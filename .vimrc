autocmd Filetype gitcommit setlocal textwidth=72

syntax enable           " enable syntax processing

"font is really good i like it
set guifont=Menlo:h14

"for showing the line number
set number

" very useful relative number mode where it shows the current line number and
" other lines are relative to it
set relativenumber

set cursorline          " highlight current line

"for searching we dont want to be case sensitive -- http://vim.wikia.com/wiki/Searching
set ignorecase
" set smartcase " thought will like smartCase but dont like it, want every
" search to be ignore case
set incsearch "Highlight dynamically as pattern is typed
set hlsearch " Highlight searches
set showmatch " highlight matching [{()}]

" dont remember why
set autoread

" for indentation when clicking on new line, it indents properly
set autoindent
set smartindent

" Disable error bells -- http://vim.wikia.com/wiki/Disable_beeping
set noerrorbells visualbell t_vb=

"for having the swp files in some tmp directory
" Centralize backups, swapfiles and undo history
" set backupdir=~/.vim/backups
" set directory=~/.vim/swaps
" if exists("&undodir")
	" set undodir=~/.vim/undo
" endif

"for using spaces as tab and tabstop as 2 by default, tabs are spaces
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

"used for enabling auto save when i click on escape button
let g:auto_save = 1

"for mapping refer : http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)

"inserting a new line without going to edit mode - two enter -- dont know difference between nmap and nnoremap
nmap <CR><CR> o<ESC>

"these are used for mapping all moving around split screen commands -- https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
nmap <D-j> <C-W><C-J>
nmap <D-k> <C-W><C-K>
nmap <D-l> <C-W><C-L>
nmap <D-h> <C-W><C-H>

" for removing the highlight after you have searched something
nmap <silent><Esc><Esc> :noh<CR>
" use of silent is for not showing the command on the command line -- the
" bottom line

" for auto completion
inoremap <C-Space> <C-n>

nmap <C-h><C-h> <C-w>K
nmap <C-v><C-v> <C-w>H

"strips white space when it is saved
autocmd BufWritePre * :%s/\s\+$//e

set rtp+=/usr/local/opt/fzf

filetype indent on      " load filetype-specific indent files
" set foldenable          " enable folding
" set foldlevelstart=10   " open most folds by default
" Allow saving of files as sudo when I forgot to start vim using sudo.
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

"""""EOF"""""
