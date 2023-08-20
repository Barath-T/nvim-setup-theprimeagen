local lsp = require('lsp-zero').preset({
	manage_nvim_cmp = {
		set_sources = 'recommended'
	}
})

lsp.ensure_installed({
	'tsserver',
	'eslint',
	'lua_ls',
})

require'lspconfig'.lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space'] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})


lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts);
	vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end, opts);
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts);
	vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts);
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts);
end)

lsp.setup()
