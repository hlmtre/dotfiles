require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'
  use 'morhetz/gruvbox'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'kabouzeid/nvim-lspinstall'
  use 'simrat39/rust-tools.nvim'
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

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/vim-vsnip'
  use 'navarasu/onedark.nvim'

  use {
  'rmagatti/goto-preview',
  config = function()
    require('goto-preview').setup {
      width = 120; -- Width of the floating window
      height = 15; -- Height of the floating window
      default_mappings = true; -- Bind default mappings
      debug = false; -- Print debug information
      opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
      post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
    }
  end
  }
  use 'kikito/inspect.lua'
  use { 'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup({
      enable_check_bracket_line = false
    })
  end
  }
end,

config = {
  display = {
    open_fn = require('packer.util').float,
}}})
-- use  'nvim-lua/lsp_extensions.nvim'
--use  'jreybert/vimagit'
