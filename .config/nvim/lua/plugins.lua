require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'
  use 'morhetz/gruvbox'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'kabouzeid/nvim-lspinstall',
      config = function()
        local lspi = require('lspinstall')
        lspi.setup()
        local servers = lspi.installed_servers()
        for _, server in pairs(servers) do
          if string.find("lua", server) then -- we have some specifics
            require('lspconfig')[server].setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim' }
                }
              }
            }})
          elseif not string.find("rust", server) then -- this is done by rust-tools
            require('lspconfig')[server].setup{}
          end
        end
        lspi.post_install_hook = function()
          vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
        end
      end
  }
  use {
    'simrat39/rust-tools.nvim',
    config = function()
      local tools = {
          autoSetHints = true,
          runnables = {use_telescope = true},
          inlay_hints = {show_parameter_hints = true},
          hover_actions = {auto_focus = true}
      }
      require('rust-tools').setup({
          tools = tools,
          server = {
              flags = {debounce_text_changes = 150},
              settings = {
                ['rust-analyzer'] = {
                  checkOnSave = {
                    command = "check"
                  }
                }
              }

          }
      })
      require('rust-tools-debug').setup()
    end
  }
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
  --use 'famiu/feline.nvim'
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require('lualine').setup({
        sections = {
          options = {theme = 'gruvbox_material'},
          lualine_a = {'mode'},
          lualine_b = {'filename', 'branch'},
          lualine_c = { "os.data(%a)", 'data', require('lsp-status').status },
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        }
      })
    end
  }
  use 'akinsho/bufferline.nvim'
  use 'kyazdani42/nvim-tree.lua'

  use {
    'hrsh7th/nvim-cmp',
    config = function()
    local cmp = require('cmp')
    cmp.setup({
      -- Enable LSP snippets
      snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      mapping = {
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        -- Add tab support
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        })
      },

      -- Installed sources
      sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer' },
      },
    })
    end
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/vim-vsnip'
  use {'navarasu/onedark.nvim',
  --[[
    config = function()
      vim.g.onedark_italic_comment = 0
      vim.g.onedark_style = 'darker'
      require('onedark').setup()
    end
    --]]
  }

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
  --[[
  --]]
