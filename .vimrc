filetype off
source ~/.config/vimplug
filetype plugin indent on

set nobackup
set nowritebackup

set nocompatible
set autoread
set backspace=indent,eol,start
let mapleader = ','
set noexpandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set clipboard=unnamedplus
set ttyfast
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=1
set ignorecase
set smartcase
set hlsearch
set incsearch
set nolazyredraw
set magic
set showmatch
set mat=2
syntax on
set encoding=utf8
let base16colorspace=256
set t_Co=256
set background=dark
colorscheme meta5

hi Normal ctermbg=NONE
hi StatusLine ctermbg=NONE
function! BgToggle()
	if(synIDattr(synIDtrans(hlID('Normal')),'bg')==233)
		hi StatusLine ctermbg=NONE
		hi Normal ctermbg=NONE
	else
		hi StatusLine ctermbg=233
		hi Normal ctermbg=233
	endif
endfunction
nnoremap <leader>t :call BgToggle()<cr>
set number
set autoindent
set smartindent
set laststatus=2
map <leader>ev :e! ~/.vimrc<cr> " edit ~/.vimrc
map <leader>wc :wincmd q<cr>
nnoremap <silent> j gj
nnoremap <silent> k gk
nmap \t :set ts=4 sts=4 sw=4 noet<cr>
nmap \s :set ts=4 sts=4 sw=4 et<cr>
map <C-h> :call WinMove('h')<cr>
map <C-j> :call WinMove('j')<cr>
map <C-k> :call WinMove('k')<cr>
map <C-l> :call WinMove('l')<cr>
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction
let g:NERDTreeQuitOnOpen=0
let NERDTreeShowHidden=1
nmap <silent> <leader>vq :VimuxCloseRunner<cr>
nmap <silent> <leader>vc :VimuxCloseRunner<cr>
nmap <silent> <leader>vo :VimuxPromptCommand<cr>
nmap <silent> <leader>k :NERDTreeToggle<cr>
nmap <silent> <leader>y :NERDTreeFind<cr>

nmap <silent> <leader>td :SearchTasks **/*<cr>

nmap <silent> <leader>gd :GoDoc<cr>
