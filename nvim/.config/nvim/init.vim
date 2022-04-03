syntax on
filetype plugin indent on
set nocompatible

set encoding=utf-8
setglobal fileencoding=utf-8

"Download plug.vim and put it in the "autoload" directory.
"https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin()

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'simeji/winresizer'
Plug 'tpope/vim-sleuth'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'airblade/vim-gitgutter'     " Show git diff of lines edited
Plug 'tpope/vim-fugitive'         " :Gblame
Plug 'tpope/vim-rhubarb'          " :GBrowse

Plug 'christoomey/vim-tmux-navigator'
Plug 'lilydjwg/colorizer'
Plug 'godlygeek/tabular'
Plug 'mattn/emmet-vim'

Plug 'morhetz/gruvbox'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'shime/vim-livedown' "needs : npm install -g livedown

" LSP ------------------------------------------------------------------------
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'


call plug#end() " ------------------------------------------------------------

" Plugin for matching HTML tags using %
" already built in vim, just need to activate
packadd! matchit


set tabstop=2
set shiftwidth=0 "follow tabstop
set softtabstop=-1 "follow shiftwidth

set nu  "line number
set rnu "relative line number
set expandtab
set autoindent
set smartindent
set scrolloff=4 "start scrolling `n` lines before the top/bottom
set incsearch "show search result on the fly
set nohlsearch "set noh "to toggle off current highlight
" set clipboard=unnamedplus
set splitbelow splitright "open on right and bottom as default
" set thesaurus+=/home/bbaga/Documents/mthesaur.txt "set thresaurus <C-X><C-T>
set omnifunc=syntaxcomplete#Complete
set hidden
" set nowrap "does not unwrap if line are too long
" set noswapfile
" set nobackup
set backspace=indent,eol,start
set cc=80
set path+=**
set wildmenu              "similar autocomplete menu to zsh
set wildmode=longest,full " ''

" ignore some folders when using finders
set wildignore+=**/dist*/*
set wildignore+=**/target/*
set wildignore+=**/builds/*
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*
set wildignore+=*.pyc
set wildignore+=*_build/*

let mapleader = ","

" SETUP FOR NETRW plugin
let g:netrw_banner=0
let g:netrw_list_hide='.*\.swp$'
" autocmd FileType netrw nnoremap ? :help netrw-quickmap<CR> 

" Delete empty space from the end of lines on every save
" autocmd BufWritePre * :%s/\s\+$//e

" This hack allows the use of <c-l> inside of netrw !!
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  nnoremap <buffer> <c-l> :wincmd l<cr>
endfunction

" Bind C-movement to move accross windows
" map <c-j> <c-w>j
" map <c-k> <c-w>k
" map <c-h> <c-w>h
" map <c-l> <c-w>l
" if has("terminal")
" 	tmap <c-j> <c-w>j
" 	tmap <c-k> <c-w>k
" 	tmap <c-h> <c-w>h
" 	tmap <c-l> <c-w>l
" endif

" following remapping highly inspired by tpope/vim-unimpaired
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

nnoremap <silent> [a :previous<CR>
nnoremap <silent> ]a :next<CR>
nnoremap <silent> [A :first<CR>
nnoremap <silent> ]A :last<CR>

nnoremap <silent> [c :cprevious<CR>
nnoremap <silent> ]c :cnext<CR>
nnoremap <silent> [C :cfirst<CR>
nnoremap <silent> ]C :clast<CR>

nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [L :lfirst<CR>
nnoremap <silent> ]L :llast<CR>

nnoremap <silent> [t :tprevious<CR>
nnoremap <silent> ]t :tnext<CR>
nnoremap <silent> [T :tfirst<CR>
nnoremap <silent> ]T :tlast<CR>

" select last pasted content
nnoremap gp `[v`]

" Highlight current line
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine guibg=#303000 ctermbg=234

" let g:lightline = {
	"\ 'colorscheme': 'onedark',
	"\ }
set laststatus=2

" Set colorscheme
" colorscheme onedark
colorscheme gruvbox

" Mardown Live Preview
nmap gM :LivedownToggle<CR>

" FZF parameters
"
let $FZF_DEFAULT_COMMAND='rg --files --hidden'
let $FZ_DEFAULT_OPTS="--height 40% --layout=reverse --preview
			\'(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"

" nnoremap <leader>ff :Files<CR>
" nnoremap <leader>fi :Ag<CR>
" nnoremap <leader>fa :Ag<CR>
" nnoremap <leader>fr :Rg<CR>
" nnoremap <leader>fz :FZF<CR>
" nnoremap <leader>fh :History<CR>
" nnoremap <leader>fb :Buffers<CR>
" nnoremap <leader>fg :GFiles<CR>

nnoremap <leader>fg <cmd>Telescope git_files<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fi <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


nnoremap <leader>json :%!python3 -m json.tool<CR>
nnoremap J mzJ`z

xnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap <leader>Y "+y

nnoremap <leader>d "_d
vnoremap <leader>d "_d



" Snippet templates shortcuts
" nnoremap <leader>html :-1read ~/.vim/template/html/skeleton.html<CR>3jcit
" nnoremap <leader>main :-1read ~/.vim/template/python/main.py<CR>2j$
" nnoremap <leader>props "zdaw:-1read 
" 			\ ~/.vim/template/python/props.py<CR>:%s/_{}_/<c-r>z/g<CR>

cmap w!! !sudo tee %

nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gD :LspDeclaration<CR>
nnoremap <silent> gi :LspImplementation<CR>
nnoremap <silent> gr :LspReferences<CR>

nnoremap <leader>l1 :LspInstallServer<CR>
nnoremap <leader>lS :LspSettingsStatus<CR>
nnoremap <leader>ac :LspCodeAction<CR>
nnoremap <leader>ls :LspDocumentDiagnostics<CR>
nnoremap <leader>ld :LspDefinition<CR>
nnoremap <leader>lD :LspDeclaration<CR>
nnoremap <leader>lr :LspRename<CR>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" let g:lsp_diagnostics_enabled = 1
let g:asyncomplete_auto_popup = 1
inoremap <silent><expr> <Tab>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
imap <c-Tab> <Plug>(asyncomplete_force_refresh)

" inoremap <silent><expr> <C-p>
"   \ asyncomplete#force_refresh()"

" TMUX VIM movements --------------------------------------------------------
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
" nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",

  -- ignore_install = { "javascript" },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF
