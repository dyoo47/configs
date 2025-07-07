highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none

set title
set tabstop=4       " Number of spaces that a tab character occupies
set shiftwidth=4    " Number of spaces to use for indentation
set expandtab       " Use spaces instead of actual tab characters

lua << EOF

require'lspconfig'.clangd.setup{
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  settings = {
    clangd = {
      -- Add extra arguments if you need
    }
  },
}

vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = {
          prefix = '●',  -- Customize the symbol for inline diagnostics
          spacing = 4,    -- Adjust spacing of the inline diagnostics
        },
        signs = true, 
    }
)

EOF
