" plugins first!
call plug#begin(stdpath('config') . '/plugs')
  Plug 'morhetz/gruvbox'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
  Plug 'nvim-lua/plenary.nvim'
  Plug 'TimUntersberger/neogit'
  Plug 'mhinz/vim-startify'
  Plug 'airblade/vim-gitgutter'
  Plug 'jistr/vim-nerdtree-tabs'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
call plug#end()

lua << EOF
-- rust
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

-- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" general editor stuff
set number
syntax on
autocmd vimenter * ++nested colorscheme gruvbox
"colorscheme gruvbox
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
set ts=2
set shiftwidth=2
set expandtab
set list listchars:tab:>-
set ai
set si
set mouse=a
let g:NERDTreeMapActivateNode	= "<tab>"
let NERDTreeWinPos=1
let g:rustfmt_autosave = 1
autocmd BufEnter * lcd %:p:h
map <C-o> :NERDTreeToggle %<CR>
nmap <C-P> :FZF<CR>
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set timeoutlen=500
let g:airline_powerline_fonts = 1

