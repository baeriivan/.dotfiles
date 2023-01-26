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
Plug 'simeji/winresizer'
Plug 'tpope/vim-sleuth'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-angular'
Plug 'numToStr/Comment.nvim'

Plug 'airblade/vim-gitgutter'     " Show git diff of lines edited
Plug 'tpope/vim-fugitive'         " :Gblame
Plug 'tpope/vim-rhubarb'          " :GBrowse

Plug 'christoomey/vim-tmux-navigator'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'KabbAmine/vCoolor.vim'
Plug 'godlygeek/tabular'
Plug 'mattn/emmet-vim'

Plug 'morhetz/gruvbox'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'shime/vim-livedown' "needs : npm install -g livedown
"Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'onsails/lspkind-nvim'
Plug 'baeriivan/ng-file-alternate-vim'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'

Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'mfussenegger/nvim-dap-python'

" Plug 'github/copilot.vim'

call plug#end() " ------------------------------------------------------------

" Plugin for matching HTML tags using % already built in vim, just need to
" activate
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

sign define LspDiagnosticsSignError text=🔴
sign define LspDiagnosticsSignWarning text=🟠
sign define LspDiagnosticsSignInformation text=🔵
sign define LspDiagnosticsSignHint text=🟢

" Mardown Live Preview
nmap gM :LivedownToggle<CR>

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
nnoremap <leader>lS :LspInstallInfo<CR>

" vim-latex-live-preview " ----------------------------------------------------

"let g:livepreview_previewer = 'okular'
"let g:livepreview_engine = 'pdflatex' . ' -pdf' "xelatex
"let g:livepreview_cursorhold_recompile = 0

"nnoremap <leader>lx :LLPStartPreview

" ============================================================================
lua << EOF

-- Easily toggle the LSP diagnostics
vim.g.diagnostics_active = true
_G.toggle_diagnostics = function()
  if vim.g.diagnostics_active then
    vim.diagnostic.hide()
    vim.g.diagnostics_active = false
  else
    vim.diagnostic.show()
    vim.g.diagnostics_active = true
  end
end

local opts = { noremap=true, silent=true }
local on_attach = function () 
  vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>lua toggle_diagnostics()<CR>', opts)
  vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<leader>wd', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<leader>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

require('telescope').load_extension('fzf')

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

local lspkind = require('lspkind')

local cmp = require'cmp'

-- cmp.setup {
--   completion = {
--     autocomplete = false, -- disable auto-completion.
--   },
-- }
--
-- _G.vimrc = _G.vimrc or {}
-- _G.vimrc.cmp = _G.vimrc.cmp or {}
-- _G.vimrc.cmp.lsp = function()
--   cmp.complete({
--     config = {
--       sources = {
--         { name = 'nvim_lsp' }
--       }
--     }
--   })
-- end
-- _G.vimrc.cmp.snippet = function()
--   cmp.complete({
--     config = {
--       sources = {
--         { name = 'vsnip' }
--       }
--     }
--   })
-- end
--
-- vim.cmd([[
--   inoremap <C-x><C-o> <Cmd>lua vimrc.cmp.lsp()<CR>
--   inoremap <C-x><C-s> <Cmd>lua vimrc.cmp.snippet()<CR>
-- ]])

cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      -- before = function (entry, vim_item)
      --   ...
      --   return vim_item
      -- end
    })
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-m>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--   }, {
--     { name = 'buffer' },
--   })
-- })

-- cmp.setup.cmdline('/', {
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'cmdline' }
--   })
-- })

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach()
    }
  server:setup(opts) 
end)

require('Comment').setup()

local ok, dap = pcall(require, "dap")
if not ok then return end
require("dapui").setup()
require("nvim-dap-virtual-text").setup()
require('dap-python').setup("/home/bai/envs/debugpy/bin/python")

local dap = require('dap')
-- dap.adapters.python = {
--   type = 'executable';
--   command = '/home/bai/envs/debugpy/bin/python';
--   args = { '-m', 'debugpy.adapter' };
-- }
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.configurations.typescript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    outFiles = {"${workspaceFolder}/build/**/*.js"},
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}

vim.keymap.set("n", "<F4>", ":lua require'dapui'.open()<CR>")
vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F6>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F7>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F8>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))()<CR>")

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

EOF
" ============================================================================
