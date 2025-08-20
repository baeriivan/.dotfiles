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


local lsp = require("lsp-zero")
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

local on_attach = function (_, bufnr)
  local opts = { noremap=true, silent=true, buffer = bufnr }

  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wd', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ac', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>=', function() vim.lsp.buf.format { async = true } end, opts)
  vim.keymap.set('v', '=', function()
    local start_pos = vim.api.nvim_buf_get_mark(0, "<")
    local end_pos = vim.api.nvim_buf_get_mark(0, ">")

    vim.lsp.buf.format({
      async = true,
      range = {
        ["start"] = { start_pos[1] - 1, start_pos[2] },
        ["end"] = { end_pos[1] - 1, end_pos[2] + 1 },
      },
    })
  end)
end

-- Helper: detect if current project is Angular
local function is_angular_project(root_dir)
  return util.root_pattern("angular.json", "nx.json")(root_dir) ~= nil
end

local function close_client(client)
  client.stop() -- deprecated
  -- client.shutdown()
  -- client.detach()
end

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "pyright",
    "vtsls",
    "angularls",
    "cssls",
    "jsonls",
    "pylsp",
    "vimls",
    "marksman",
  },
})

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  settings = {
    Lua = { diagnostics = { globals = { "vim" } } },
  },
})

lspconfig.angularls.setup({
  on_attach = function(client, bufnr)
    if not is_angular_project(client.config.root_dir) then
      close_client(client)
      return
    end
    on_attach(client, bufnr)
  end,
})

lspconfig.vtsls.setup({
  on_new_config = function(new_config, root_dir)
    if is_angular_project(root_dir) then
      new_config.enabled = false
    end
  end,
  on_attach = on_attach,
})

lspconfig.ts_ls.setup({
  on_attach = function(client)
    close_client(client)
  end,
})

lsp.preset("recommended")
lsp.setup()


local lspkind = require('lspkind')
lsp.set_sign_icons({
  error = " ",
  warn  = " ",
  hint  = " ",
  info  = " "
})


local cmp = require('cmp')
local cmp_config = lsp.defaults.cmp_config({})

local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<C-d>'] = cmp.mapping.scroll_docs(-4),
  ['<C-u>'] = cmp.mapping.scroll_docs(4),
  ['<CR>'] = cmp.mapping.confirm(),
})
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

cmp_config = {
  mapping = cmp_mappings,
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
    })
  },
  sources = {
    -- { name = 'supermaven' },
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
}

cmp.setup(cmp_config)

-- none-ls.nvim still uses 'null-ls'
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier, -- for TS, HTML, etc.
    null_ls.builtins.formatting.black,    -- for Python
    null_ls.builtins.formatting.stylua,   -- for Lua
    null_ls.builtins.formatting.shfmt,    -- for shell scripts
  },
})

local supermaven = require('supermaven-nvim')
supermaven.setup({})
