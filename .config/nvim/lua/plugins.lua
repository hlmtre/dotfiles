vim.g.mapleader = ' ' -- make sure to set `mapleader` before lazy so your mappings are correct
require('lazy').setup({
  'folke/which-key.nvim',
  'folke/neodev.nvim',
  {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup({})
    end,
  },
  {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup({})
    end,
  },
  'kdheepak/lazygit.nvim',
  {
    'morhetz/gruvbox',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    'FabijanZulj/blame.nvim',
    config = function()
      require('blame').setup()
    end,
  },
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup({})
    end,
  },
  { 'sbdchd/neoformat' },
  { 'preservim/tagbar' },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'UIEnter' },
    config = function()
      require('hlchunk').setup({
        support_filetypes = {
          '*.lua',
          '*.rs',
        },
        chunk = {
          chars = {
            horizontal_line = '─',
            vertical_line = '│',
            left_top = '╭',
            left_bottom = '╰',
            right_arrow = '>',
          },
          style = '#806d9c',
        },
      })
    end,
  },
  { 'mboughaba/i3config.vim' },
  --[[
  "nvim-lua/lsp-status.nvim")
  "arkav/lualine-lsp-progress")
  "nvim-lua/popup.nvim")
  --]]
  { 'nvim-lua/plenary.nvim' },
  { 'famiu/bufdelete.nvim' }, -- required so nvim-tree doesn't stay open when you close the buffer
  { 'nvim-telescope/telescope.nvim' },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'bash',
          'python',
          'rust',
          'yaml',
          'lua',
          'toml',
          'regex',
          'html',
          'css',
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end,
  },
  -- { 'RishabhRD/popfix' },
  { 'wesleimp/stylua.nvim' },
  { 'mrcjkb/rustaceanvim', version = '^4', ft = { 'rust' } },
  --[[
  {
    'nvim-tree/nvim-tree.lua',
    config = nvim_tree_setup,
  },
  ]]
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = require('config.nt'),
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup()
    end,
  },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('mason-lspconfig').setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require('lspconfig')[server_name].setup({})
          print('loaded lsp server ' .. server_name)
        end,
        -- Next, you can provide targeted overrides for specific servers.
        ['lua_ls'] = function()
          print('loaded lsp server lua_ls')
          local settings = {
            Lua = {
              diagnostics = {
                -- GAHH this has to be single-quoted
                globals = { 'vim' },
              },
            },
          }
          require('lspconfig')['lua_ls'].setup({ settings = settings })
        end,
        -- For example, a handler override for the `rust_analyzer`:
        ['rust_analyzer'] = function()
          print('loaded lsp server rust-analyzer')
          local tools = {
            inlay_hints = {
              auto = false, -- inlay hints are native in nvim greater than some 0.10 version!
            },
            runnables = { use_telescope = true },
            -- inlay_hints = { show_parameter_hints = true },
            hover_actions = { auto_focus = true },
          }

          --          require('rust-tools').setup({
          --            tools = tools,
          --            server = {
          --              flags = { debounce_text_changes = 150 },
          --              settings = {
          --                ['rust-analyzer'] = {
          --                  checkOnSave = {
          --                    allFeatures = true,
          --                    overrideCommand = {
          --                      'cargo',
          --                      'clippy',
          --                      '--workspace',
          --                      '--message-format=json',
          --                      '--all-targets',
          --                      '--all-features',
          --                    },
          --                  },
          --                },
          --              },
          --            },
          --          })
        end,
      })
    end,
  },
  {
    'j-hui/fidget.nvim',
    --tag = 'legacy',
    config = function()
      require('fidget').setup({
        notification = {
          window = {
            relative = 'win',
          },
        },
      })
    end,
  },
  {
    'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup({
        highlights = {
          buffer_selected = {
            fg = {
              attribute = 'bg',
              highlight = 'Normal',
            },
            bg = {
              attribute = 'fg',
              highlight = 'Normal',
            },
          },
          close_button_selected = {
            fg = {
              attribute = 'bg',
              highlight = 'Normal',
            },
            bg = {
              attribute = 'fg',
              highlight = 'Normal',
            },
          },
        },
        options = {
          close_command = 'bdelete! %d',
          tab_size = 18,
          enforce_regular_tabs = true,
          diagnostics = 'nvim_lsp',
          offsets = {
            {
              filetype = 'NvimTree',
              text = function()
                return vim.fn.getcwd()
              end,
              text_align = 'left',
            },
          },
        },
      })
    end,
  },
  { 'akinsho/toggleterm.nvim', version = '*', config = true },
  { 'nvim-tree/nvim-web-devicons' },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup()
    end,
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        enable_check_bracket_line = false,
      })
    end,
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        --{ 'hrsh7th/cmp-vsnip', commit = '1ae05c6' },
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
      },
      config = function()
        local cmp = require('cmp')
        cmp.setup({
          -- Enable LSP snippets
          snippet = {
            expand = function(args)
              -- vim.fn['vsnip#anonymous'](args.body) -- vsnip broke ('unknown function vsnip#anonymous')
              require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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
            }),
          },

          -- Installed sources
          sources = {
            { name = 'nvim_lsp' },
            -- { name = 'vsnip' },
            { name = 'luasnip' },
            { name = 'path' },
            { name = 'buffer' },
          },
        })
      end,
    },
  },
  {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
    config = function()
      vim.api.nvim_set_keymap('n', 'ga', '<cmd>CodeActionMenu<CR>', { silent = true })
    end,
  },
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
      require('lsp_lines').setup()
    end,
  },
  -- starts
  {
    'goolord/alpha-nvim',
    config = function()
      require('alpha').setup(require('alpha.themes.dashboard').config)
    end,
  },
  --{
  --  'Shatur/neovim-session-manager',
  --  config = function()
  --    local Path = require('plenary.path')
  --    local opts = {
  --      sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
  --      path_replacer = '__', -- The character to which the path separator will be replaced for session files.
  --      colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
  --      autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
  --      autosave_last_session = true, -- Automatically save last session on exit and on session switch.
  --      autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
  --      autosave_ignore_dirs = {}, -- A list of directories where the session will not be autosaved.
  --      autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
  --        'gitcommit',
  --      },
  --      autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
  --      autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
  --      max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
  --    }
  --    require('session_manager').setup(opts)
  --  end,
  --},
  --{ 'mhinz/vim-startify' },
  { 'mbbill/undotree' },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          theme = 'gruvbox',
          lower = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            { 'filename', file_status = true, path = 2 },
            'branch',
            { 'diagnostics', sources = { 'nvim_diagnostic' } },
          },
          --lualine_c = { "lsp_progress" },
          lualine_c = {},
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = {
          'nvim-tree',
          'quickfix',
        },
      })
    end,
  },
  {
    'jim-fx/sudoku.nvim',
    config = function()
      require('sudoku').setup({
        persist_settings = true, -- safe the settings under vim.fn.stdpath("data"), usually ~/.local/share/nvim,
        persist_games = true, -- persist a history of all played games
        default_mappings = true, -- if set to false you need to set your own, like the following:
        mappings = {
          { key = 'x', action = 'clear_cell' },
          { key = 'r1', action = 'insert=1' },
          { key = 'r2', action = 'insert=2' },
          { key = 'r3', action = 'insert=3' },
          -- ...
          { key = 'r9', action = 'insert=9' },
          { key = 'gn', action = 'new_game' },
          { key = 'gr', action = 'reset_game' },
          { key = 'gs', action = 'view=settings' },
          { key = 'gt', action = 'view=tip' },
          { key = 'gz', action = 'view=zen' },
          { key = 'gh', action = 'view=help' },
          { key = 'u', action = 'undo' },
          { key = '<C-r>', action = 'redo' },
          { key = '+', action = 'increment' },
          { key = '-', action = 'decrement' },
        },
      })
    end,
  },
  {
    'skosulor/nibbler',
    config = function()
      require('nibbler').setup({
        display_enabled = true, -- Set to false to disable real-time display (default: true)
      })
    end,
  },
  {
    'smjonas/inc-rename.nvim',
    config = function()
      require('inc_rename').setup()
    end,
  },
}) -- end lazy setup
