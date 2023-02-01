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

local lsp = require("lsp-zero")
lsp.preset('recommended')

local lspkind = require('lspkind')
local cmp = require('cmp')

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4)),
    ['<C-m>'] = cmp.mapping(cmp.mapping.complete()),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
})

lsp.set_preferences({
  sign_icons = {}
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.on_attach = on_attach()

lsp.setup()
-- cmp.setup({
--   formatting = {
--     format = lspkind.cmp_format({
--       mode = 'symbol',
--       maxwidth = 50,
--     })
--   },
--   snippet = {
--     expand = function(args)
--       vim.fn["vsnip#anonymous"](args.body)
--     end,
--   },
--   mapping = {
--   },
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'vsnip' },
--     { name = 'path' },
--     { name = 'buffer' },
--   })
-- })
