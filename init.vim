set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set number
set relativenumber

call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'numToStr/Comment.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'sainnhe/everforest'
Plug 'shortcuts/no-neck-pain.nvim', { 'tag': '*' }
call plug#end()

colorscheme everforest
let mapleader = " "

autocmd FileType c,cpp,cuda,cxx,h,hpp,hxx setlocal formatprg=clang-format\ --style=file\ --assume-filename=%:p

" Pane management
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" Tab management
nnoremap <M-n> gT
nnoremap <M-m> gt
nnoremap <leader>t :tabnew<CR>

nnoremap <C-M-h> :leftabove vsplit<CR>
nnoremap <C-M-j> :rightbelow split<CR>
nnoremap <C-M-k> :leftabove split<CR>
nnoremap <C-M-l> :rightbelow vsplit<CR>

nnoremap <C-Up>    :resize +2<CR>
nnoremap <C-Down>  :resize -2<CR>
nnoremap <C-Left>  :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>
nnoremap <leader><C-n> :NoNeckPain<CR>

" LSP
nnoremap K         <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap gd        <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gr        <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gi        <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>d <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <C-k>     <cmd>lua vim.lsp.buf.signature_help()<CR>

lua << EOF

require("no-neck-pain").setup({
width = 160, 
autocmds = {
  skipEnteringNoNeckPainBuffer = false,
  enableOnVimEnter = true
},
})

require('Comment').setup()
local builtin = require('telescope.builtin')
vim.keymap.set("n", "<C-_>", function() require('Comment.api').toggle.linewise.current() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })

  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    window = {
        completion = {
            max_height = 10,
            },
            documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

-- local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('clangd', {
  cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
  init_options = {
    fallbackFlags = {
      '-std=c++20',
      '-Iinclude',
    },
  },
  capabilities = capabilities,
  root_markers = { '.git' },
})
vim.lsp.enable('clangd')

EOF
" Transparent background
highlight Normal guibg=NONE ctermbg=NONE
highlight NormalNC guibg=NONE ctermbg=NONE
"highlight NonText guibg=NONE ctermbg=NONE
"highlight EndOfBuffer guibg=NONE ctermbg=NONE
"highlight LineNr guibg=NONE ctermbg=NONE
"highlight SignColumn guibg=NONE ctermbg=NONE
"highlight FoldColumn guibg=NONE ctermbg=NONE
"highlight MsgArea guibg=NONE ctermbg=NONE
"highlight StatusLine guibg=NONE ctermbg=NONE
"highlight StatusLineNC guibg=NONE ctermbg=NONE
"highlight NormalFloat guibg=NONE ctermbg=NONE
"highlight FloatBorder guibg=NONE ctermbg=NONE
