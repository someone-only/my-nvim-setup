local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end


local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  -- formatting
  if client.server_compabilities.documentFormattingProvider then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <Buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <Buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end

end

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.cssls.setup {
  capabilities = capabilities,
}

nvim_lsp.html.setup {
  capabilities = capabilities,
  filetype = { "html", "ejs" }
}

nvim_lsp.tailwindcss.setup{
  capabilities = capabilities,
}

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetype = { 'typescript', 'typescriptreact', 'typescript.tsx' },
  cmd = { 'typescript-language-server', '--stdio' },
}

nvim_lsp.lua_ls.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- get the language server to recognize 'vim' global
        globals = { 'vim' }
      },
      workspace = {
        -- make a server aware of neovim runtime file
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      }
    }
  },
}


