local function lsps_setup()
  local lsp_status = require("lsp-status")
  lsp_status.config({
    current_function = false,
    show_filename = true,
    diagnostics = true,
    update_interval = 1000, -- prevent crazy cpu use polling rust-analyzer all the time
    indicator_errors = "E",
    indicator_warnings = "W",
    indicator_info = "i",
    indicator_hint = "h",
    indicator_ok = "Ok",
  })
  lsp_status.register_progress()

  local s = lsp_status.status()
  return s
end

require("packer").startup({
  function(use)
    use("wbthomason/packer.nvim")
    use("morhetz/gruvbox")
    use("neovim/nvim-lspconfig")
    use("nvim-lua/lsp-status.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use({ "nvim-telescope/telescope.nvim" })
    use({ "nvim-treesitter/nvim-treesitter"})
    use("RishabhRD/popfix")
    use({
      "RishabhRD/nvim-lsputils",
      config = function()
        vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler
        vim.lsp.handlers["textDocument/references"] = require("lsputil.locations").references_handler
        vim.lsp.handlers["textDocument/definition"] = require("lsputil.locations").definition_handler
        vim.lsp.handlers["textDocument/declaration"] = require("lsputil.locations").declaration_handler
        vim.lsp.handlers["textDocument/typeDefinition"] = require("lsputil.locations").typeDefinition_handler
        vim.lsp.handlers["textDocument/implementation"] = require("lsputil.locations").implementation_handler
        vim.lsp.handlers["textDocument/documentSymbol"] = require("lsputil.symbols").document_handler
        vim.lsp.handlers["workspace/symbol"] = require("lsputil.symbols").workspace_handler
      end,
    })
    use({
      "williamboman/nvim-lsp-installer",
      config = function()
        local lsp_installer = require("nvim-lsp-installer")
        lsp_installer.on_server_ready(function(server)
          local opts = {}
          if string.find("lua", server.name) then -- we have some specifics
            require("lspconfig")[server].setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            })
          elseif not string.find("rust", server.name) then -- this is done by rust-tools
            opts.capabilities = vim.lsp.protocol.make_client_capabilities()
            opts.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
            opts.capabilities.textDocument.completion.completionItem.snippetSupport = true
            opts.capabilities.textDocument.completion.completionItem.preselectSupport = true
            opts.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
            opts.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
            opts.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
            opts.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
            opts.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
            opts.capabilities.textDocument.completion.completionItem.resolveSupport = {
              properties = {
                "documentation",
                "detail",
                "additionalTextEdits",
              },
            }
          end

          -- (optional) Customize the options passed to the server
          -- if server.name == "tsserver" then
          --     opts.root_dir = function() ... end
          -- end

          -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
          server:setup(opts)
          vim.cmd([[ do User LspAttachBuffers ]])
        end)
      end,
    })
    use({ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" })
    use ({'kosayoda/nvim-lightbulb',
      config = function()
        vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
      end
    })
    use("f-person/git-blame.nvim")
    use({
      "simrat39/rust-tools.nvim",
      config = function()
        local tools = {
          autoSetHints = true,
          runnables = { use_telescope = true },
          inlay_hints = { show_parameter_hints = true },
          hover_actions = { auto_focus = true },
        }
        require("rust-tools").setup({
          tools = tools,
          server = {
            flags = { debounce_text_changes = 150 },
            settings = {
              ["rust-analyzer"] = {
                checkOnSave = {
                  allFeatures = true,
                  overrideCommand = {
                    "cargo",
                    "clippy",
                    "--workspace",
                    "--message-format=json",
                    "--all-targets",
                    "--all-features",
                  },
                },
              },
            },
          },
        })
        --require('rust-tools-debug').setup()
      end,
    })
    --use("mfussenegger/nvim-dap")
    use("TimUntersberger/neogit")
    use("mhinz/vim-startify")
    use("airblade/vim-gitgutter")
    use("kyazdani42/nvim-web-devicons")
    use({
      "karb94/neoscroll.nvim",
      config = function()
        require("neoscroll").setup()
      end,
    })
    use("folke/which-key.nvim")
    use("folke/trouble.nvim")
    use("famiu/bufdelete.nvim")
    --use({ "famiu/feline.nvim" })
    use("sbdchd/neoformat")
    use("Yggdroot/indentLine")
    use({ "mbbill/undotree" })

    use({
      "hoob3rt/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require("lualine").setup({
          options = {
            theme = "gruvbox_material",
            lower = true,
          },
          sections = {
            lualine_a = { "mode" },
            lualine_b = { "filename", "branch" },
            lualine_c = { { require("lsp-status").status } },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
          },
          extensions = {
            "nvim-tree",
            "quickfix",
          },
        })
      end,
    })
    use({
      "akinsho/bufferline.nvim",
      config = function()
        require("bufferline").setup({
          highlights = {
            buffer_selected = {
              guifg = {
                attribute = "bg",
                highlight = "Normal",
              },
              guibg = {
                attribute = "fg",
                highlight = "Normal",
              },
            },
            close_button_selected = {
              guifg = {
                attribute = "bg",
                highlight = "Normal",
              },
              guibg = {
                attribute = "fg",
                highlight = "Normal",
              },
            },
          },
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "NvimTree",
              text = function()
                return vim.fn.getcwd()
              end,
              text_align = "left",
            },
          },
          options = {
            close_command = "bdelete! %d",
            tab_size = 18,
            enforce_regular_tabs = true,
          },
        })
      end,
    })
    --[[
    use {
      'noib3/cokeline.nvim',
      requires = 'kyazdani42/nvim-web-devicons', -- If you want devicons
      config = function()
        vim.opt.termguicolors = true
        local get_hex = require('cokeline/utils').get_hex

        require('cokeline').setup({
          -- If true the bufferline is hidden when only one buffer is listed
          hide_when_one_buffer = false,

          -- Controls what happens when the first (last) buffer is focused and the user
          -- tries to focus/switch to the previous (next) buffer. If true the last
          -- (first) buffer gets focused/switched to, if false nothing happens.
          cycle_prev_next_mappings = true,

          -- Default colors for the foregound/background of focused/unfocused
          -- lines. Their default values are derived from the foreground/background of
          -- other highlight groups.
          default_hl = {
            focused = {
              fg = get_hex('ColorColumn', 'bg'),
              bg = get_hex('Normal', 'fg'),
            },
            unfocused = {
              fg = get_hex('Normal', 'fg'),
              bg = get_hex('ColorColumn', 'bg'),
            },
          },

          -- A list of components used to build every line of the cokeline.
          components = {
            {
              text = function(buffer) return ' ' .. buffer.devicon.icon end,
              hl = {
                fg = function(buffer) return buffer.devicon.color end,
              },
            },
            {
              text = function(buffer) return buffer.unique_prefix end,
              hl = {
                fg = get_hex('Comment', 'fg'),
                style = 'italic',
              },
            },
            {
              text = function(buffer) return buffer.filename .. ' ' end,
            },
            {
              text = '',
              delete_buffer_on_left_click = true,
            },
            {
              text = ' ',
            }
          },
        })

      end
    }
    --]]
    use({
      "kyazdani42/nvim-tree.lua",
      config = function()
        local tree_cb = require("nvim-tree.config").nvim_tree_callback
        require("nvim-tree").setup({
          --open_on_setup = true,
          --open_on_tab = true,
          update_cwd = true,
          lsp_diagnostics = true,
          update_focused_file = {
            enable = true,
            update_cwd = true,
          },
          view = {
            width = 40,
            side = "right",
            mappings = {
              custom_only = false,
              list = {
                { key = { "<CR>", "<Tab>" }, cb = tree_cb("edit") },
              },
            },
          },
        })
      end,
    })

    use({
      "hrsh7th/nvim-cmp",
      config = function()
        local cmp = require("cmp")
        cmp.setup({
          -- Enable LSP snippets
          snippet = {
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body)
            end,
          },
          mapping = {
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-j>"] = cmp.mapping.select_next_item(),
            -- Add tab support
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-u>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            }),
          },

          -- Installed sources
          sources = {
            { name = "nvim_lsp" },
            { name = "vsnip" },
            { name = "path" },
            { name = "buffer" },
          },
        })
      end,
    })
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/vim-vsnip")
    use({
      "navarasu/onedark.nvim",
    })
    use("kikito/inspect.lua")
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup({
          enable_check_bracket_line = false,
        })
      end,
    })
  end,

  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
})
--[[
    use({
      "rinx/lspsaga.nvim",
      config = function()
        local conf = {
          use_saga_diagnostic_sign = false,
          code_action_prompt = {
            enable = true
          },
          code_action_keys = {
            quit = '<esc>', exec = '<CR>'
          },
          rename_action_keys = {
            quit = '<esc>', exec = '<CR>'
          },
          finder_action_keys = {
            open = 'o', vsplit = 's',split = '<CR>',quit = 'q',
            scroll_down = '<C-j>',scroll_up = '<C-k>'
          },
        }
        require("lspsaga").init_lsp_saga(conf)
      end,
    })
    --]]

--[[
    use({
      "rmagatti/goto-preview",
      config = function()
        require("goto-preview").setup({
          width = 120, -- Width of the floating window
          height = 15, -- Height of the floating window
          default_mappings = true, -- Bind default mappings
          debug = false, -- Print debug information
          opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
          post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        })
      end,
    })
    --]]
--[[
    config = function()
      vim.g.onedark_italic_comment = 0
      vim.g.onedark_style = 'darker'
      require('onedark').setup()
    end
    --]]
--[[
  use({
    --"NTBBloodbath/galaxyline.nvim",
    "~/src/galaxyline.nvim",
    -- your statusline
    config = function()
      require("galaxyline.themes.eviline")
    end,
    -- some optional icons
    requires = { "kyazdani42/nvim-web-devicons", opt = true }
  })
  --]]
--[[
    use({
      "kabouzeid/nvim-lspinstall",
      config = function()
        local lspi = require("lspinstall")
        lspi.setup()
        local servers = lspi.installed_servers()
        for _, server in pairs(servers) do
          if string.find("lua", server) then -- we have some specifics
            require("lspconfig")[server].setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            })
          elseif not string.find("rust", server) then -- this is done by rust-tools
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            capabilities.textDocument.completion.completionItem.preselectSupport = true
            capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
            capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
            capabilities.textDocument.completion.completionItem.deprecatedSupport = true
            capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
            capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
            capabilities.textDocument.completion.completionItem.resolveSupport = {
              properties = {
                "documentation",
                "detail",
                "additionalTextEdits",
              },
            }
            require("lspconfig")[server].setup({ capabilities = capabilities })
          end
        end
        lspi.post_install_hook = function()
          vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
        end
      end,
    })
    --]]
