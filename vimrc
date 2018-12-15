"{{{ Vundle usages
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"
"
"
"syntax checker
Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_checkers = [ 'phpcs']

"disabled Syntastic by default
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>
"A pretty status bar for Vim
Plugin 'itchyny/lightline.vim'
"
"
" quick search for files
Plugin 'kien/ctrlp.vim'
"
" code-completion engine
Plugin 'Valloric/YouCompleteMe'
" ultimate solution for snippets engine
Plugin 'SirVer/ultisnips'
" YouCompleteMe and UltiSnips compatibility, with the helper of supertab
" (via http://stackoverflow.com/a/22253548/1626737)
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']
" Trigger configuration for snippit usage
"
"
"buffer as tabs
Plugin 'jlanzarotta/bufexplorer'
"
"

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

"}}}

"{{{ misc settings

" Folding Stuffs
set foldmethod=marker

" Who doesn't like autoindent?
set autoindent

" Use english for spellchecking, but don't spellcheck by default
if version >= 700
   set spl=en spell
   set nospell
endif

" Highlight things that we find with the search
set hlsearch

" When I close a tab, remove the buffer
set hidden

" Set off the other paren
highlight MatchParen ctermbg=4

" Ignoring case is a fun trick in search
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" Enable mouse support in console
set mouse=a

" Got backspace?
set backspace=2

" Cool tab completion stuff in the cmd line when : pressed
set wildmenu
set wildmode=list:longest,full

" switch on line number
set number

" moving line(s) up/down by selecting in visual mode
xnoremap <S-Up> :m-2<CR>gv=gv
xnoremap <S-Down> :m'>+<CR>gv=gv

"move a line up/down normal mode
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>

" syntax highlighting
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*


" sane text files
set fileformat=unix
set encoding=utf-8

"windows fullscreen size
if has("gui_running")
  " GUI is running or is about to start.
  set lines=999 columns=999
else
  " This is console Vim.
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=100
  endif
endif

" sane editing
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" mksession to open files that were not closed last time
set sessionoptions=buffers

" changing between splits easier
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"copying filename to genome register (foo.txt)
nnoremap <leader>cf :let @+=expand("%:t")<CR>

" We have VCS -- we don't need this stuff.
set nobackup " We have vcs, we don't need backups.
set nowritebackup " We have vcs, we don't need backups.
set noswapfile " They're just annoying. Who likes them?

" Clear match highlighting
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

set cursorline          " highlight current line

" block visual selection
nnoremap <leader>v <c-v>

" map cut & paste to what they bloody should be
vnoremap <C-c> "+y
vnoremap <C-x> "+x
map <C-v> "+gp

" to save files opened on read only mode
cnoremap w!! w !sudo tee %
"}}}

"{{{ Look and Feel

" Favorite Color Scheme
if has("gui_running")
   colorscheme vrunchbang-dark
   " Remove Toolbar
   set guioptions-=T
   "Terminus is AWESOME
   set guifont=Courier\ New\ 11
endif

"Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

"}}}


"{{{ auto commands

"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"open a NERDTree automatically when vim starts up
autocmd vimenter * NERDTree

" nerdtree auto open on starting vim with ditectory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" remaping esc to capslock
au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 9 = Caps_Lock'
au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 9 = Escape'
au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'
"}}}


