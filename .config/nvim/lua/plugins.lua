require('packer').startup({function()
  use 'wbthomason/packer.nvim'
  use 'morhetz/gruvbox'
  use 'neovim/nvim-lspconfig'
  use 'simrat39/rust-tools.nvim'
  --use 'Joakker/rust-tools.nvim'
  use 'nvim-lua/lsp-status.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'mfussenegger/nvim-dap'
  use 'TimUntersberger/neogit'
  use 'mhinz/vim-startify'
  use 'airblade/vim-gitgutter'
  use 'kyazdani42/nvim-web-devicons'
  use 'karb94/neoscroll.nvim'
  use 'folke/which-key.nvim'
  use 'famiu/bufdelete.nvim'
  use 'sbdchd/neoformat'
  use 'Yggdroot/indentLine'
  use 'famiu/feline.nvim'
  use 'akinsho/bufferline.nvim'
  use 'kyazdani42/nvim-tree.lua'
end,
config = {
  display = {
    open_fn = require('packer.util').float,
}}})
-- use  'nvim-lua/lsp_extensions.nvim'
--use  'jreybert/vimagit'
