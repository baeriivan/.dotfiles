"Download plug.vim and put it in the "autoload" directory.
"https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin() " -----------------------------------------------------------


Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'simeji/winresizer'
Plug 'tpope/vim-sleuth'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'numToStr/Comment.nvim'

Plug 'airblade/vim-gitgutter'     " Show git diff of lines edited
Plug 'tpope/vim-fugitive'         " :Gblame

Plug 'christoomey/vim-tmux-navigator'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'KabbAmine/vCoolor.vim'
Plug 'godlygeek/tabular'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'

Plug 'morhetz/gruvbox'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Plug 'shime/vim-livedown' "needs : npm install -g livedown
" Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'onsails/lspkind-nvim' "pretty symbols
Plug 'baeriivan/ng-file-alternate-vim'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Plug 'Jezda1337/nvim-html-css'

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v1.x'}

" Plug 'mfussenegger/nvim-dap'
" Plug 'nvim-neotest/nvim-nio'
" Plug 'rcarriga/nvim-dap-ui'
" Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'mortepau/codicons.nvim'

Plug 'supermaven-inc/supermaven-nvim'
" Plug 'github/copilot.vim'

call plug#end() " ------------------------------------------------------------

packadd! cfilter

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
set termguicolors
set splitbelow splitright "open on right and bottom as default
set omnifunc=syntaxcomplete#Complete
set completeopt=menu,menuone,noinsert "noselect, preview
set hidden

set formatoptions=tcqr

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

let mapleader = " "

let g:ng_file_alternate_stylefiletype = ".scss"

nnoremap <silent> <leader>hh :NgFileAltenativeGoToHTML<cr>
nnoremap <silent> <leader>jj :NgFileAltenativeGoToScript<cr>
nnoremap <silent> <leader>kk :NgFileAltenativeGoToTest<cr>
nnoremap <silent> <leader>ll :NgFileAltenativeGoToStyle<cr>

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

nnoremap <silent> <leader>c] :cclose<cr>
nnoremap <silent> <leader>c[ :copen<cr>
nnoremap <silent> <leader>l] :lclose<cr>
nnoremap <silent> <leader>l[ :lopen<cr>

" select last pasted content
nnoremap gp `[v`]

" Highlight current line
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine guibg=#303000 ctermbg=234

set laststatus=2

colorscheme gruvbox

" HEXOKINASE <Alt-C>
let g:Hexokinase_highlighters = ['virtual']
let g:vcoolor_lowercase = 1

" Markdown Live Preview
nmap gM <Plug>MarkdownPreviewToggle
" nmap gM :LivedownToggle<CR>

" FZF parameters
"
let $FZF_DEFAULT_COMMAND='rg --files --hidden'
let $FZ_DEFAULT_OPTS="--height 40% --layout=reverse --preview
			\'(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"

nnoremap <leader>fg <cmd>Telescope git_files<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fa <cmd>Telescope find_files no_ignore=true<cr>
nnoremap <leader>fi <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <C-p> :Ex<cr>

nnoremap <leader>SO :windo source $MYVIMRC<cr>
nnoremap J mzJ`z

xnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap     <leader>Y "+y

nnoremap <leader>d "_d
vnoremap <leader>d "_d

cmap w!! !sudo tee %

augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
augroup END

" vim-vsnip -----------------------------------------------------------------

let g:vsnip_snippet_dir = expand('~/.config/nvim/vsnip')
let g:vsnip_snippet_dirs = [
      \ expand('~/.config/nvim/vsnip'),
      \ expand('~/.config/nvim/vsnip/javascript'),
      \ expand('~/.config/nvim/vsnip/latex'),
      \ expand('~/.config/nvim/vsnip/python'),
      \ expand('~/.config/nvim/vsnip/frameworks')
      \ ]
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.scss = ['css']
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']
let g:vsnip_filetypes.ruby = ['rails']
let g:vsnip_filetypes.markdown = ['jekyll']

nnoremap <silent> <leader>sn :VsnipOpen<cr>

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'    : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'    : '<C-j>'

" Expand or jump
imap <expr> <C-l> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
imap <expr> <C-j> vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<C-j>'
imap <expr> <C-l> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <C-n> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'    : '<C-n>'
smap <expr> <C-n> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'    : '<C-n>'
imap <expr> <C-p> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'    : '<C-p>'
smap <expr> <C-p> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'    : '<C-p>'

" TMUX VIM movements --------------------------------------------------------

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

nnoremap <leader>l1 :LspInstall<CR>
nnoremap <leader>l2 :LspUninstall<CR>
nnoremap <leader>ls :LspInfo<CR>
nnoremap <leader>lS :Mason<CR>

" vim-latex-live-preview " ----------------------------------------------------

"let g:livepreview_previewer = 'okular'
"let g:livepreview_engine = 'pdflatex' . ' -pdf' "xelatex
"let g:livepreview_cursorhold_recompile = 0

"nnoremap <leader>lx :LLPStartPreview

" -----------------------------------------------------------------------------

" nnoremap <silent> <leader>TT :!tree -d -I node_modules<cr>
" nnoremap <silent> <leader>TA :!tree -I node_modules<cr>

" nnoremap <leader>T :NERDTree<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>TT :NERDTreeToggle<CR>

lua require("baeriivan")
