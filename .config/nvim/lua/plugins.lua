-- Color for highlights
--[[
local colors = {
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}
--]]

--[[
local lualine_config = {
  options = {
    icons_enabled = true,
    theme = "gruvbox",
    lower = true,
    component_separators = { "", "" },
    section_separators = { "", "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "filename", "branch", { "diagnostics", sources = { "nvim_diagnostic" } } },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { "encoding", "fileformat", "filetype" },
    lualine_z = { "progress", "location" },
  },
  -- these aren't off; these are what are on when the window is unfocused
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "nvim-tree", "quickfix" },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(lualine_config.sections.lualine_c, component)
end

ins_left({
  "lsp_progress",
  colors = {
    percentage = colors.cyan,
    title = colors.cyan,
    message = colors.cyan,
    spinner = colors.cyan,
    lsp_client_name = colors.magenta,
    use = true,
  },
  separators = {
    component = " ",
    progress = " | ",
    percentage = { pre = "", post = "%% " },
    title = { pre = "", post = ": " },
    lsp_client_name = { pre = "[", post = "]" },
    spinner = { pre = "", post = "" },
    message = { commenced = "In Progress", completed = "Completed" },
  },
  display_components = { "lsp_client_name", "spinner", { "title", "percentage", "message" } },
  timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
  spinner_symbols = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
})
--]]

vim.g.mapleader = ' ' -- make sure to set `mapleader` before lazy so your mappings are correct

require('lazy').setup({
  'folke/which-key.nvim',
  { 'folke/neoconf.nvim', cmd = 'Neoconf' },
  'folke/neodev.nvim',
  {
    'morhetz/gruvbox',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup({})
    end,
  },
  { 'preservim/tagbar' },
  { 'mboughaba/i3config.vim' },
  --[[
  "nvim-lua/lsp-status.nvim")
  "arkav/lualine-lsp-progress")
  "nvim-lua/popup.nvim")
  --]]
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-telescope/telescope.nvim' },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'nvim-treesitter/nvim-treesitter' },
  { 'RishabhRD/popfix' },
  { 'wesleimp/stylua.nvim' },
  { 'simrat39/rust-tools.nvim' },
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup({
        diagnostics = {
          enable = true,
        },
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        respect_buf_cwd = false,
        sync_root_with_cwd = false,
        view = {
          width = 40,
          side = 'right',
          mappings = {
            custom_only = false,
            list = {
              { key = { '<CR>', '<Tab>' }, action = 'edit' },
            },
          },
        },
      })
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
            autoSetHints = true,
            runnables = { use_telescope = true },
            inlay_hints = { show_parameter_hints = true },
            hover_actions = { auto_focus = true },
          }
          require('rust-tools').setup({
            tools = tools,
            server = {
              flags = { debounce_text_changes = 150 },
              settings = {
                ['rust-analyzer'] = {
                  checkOnSave = {
                    allFeatures = true,
                    overrideCommand = {
                      'cargo',
                      'clippy',
                      '--workspace',
                      '--message-format=json',
                      '--all-targets',
                      '--all-features',
                    },
                  },
                },
              },
            },
          })
        end,
      })
    end,
  },
  {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
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
  { 'kyazdani42/nvim-web-devicons' },
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
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    {
      'hrsh7th/nvim-cmp',
      config = function()
        local cmp = require('cmp')
        cmp.setup({
          -- Enable LSP snippets
          snippet = {
            expand = function(args)
              vim.fn['vsnip#anonymous'](args.body)
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
            { name = 'vsnip' },
            { name = 'path' },
            { name = 'buffer' },
          },
        })
      end,
    },
  },
}) -- end lazy setup
