local lsp_status = require('lsp-status')

lsp_status.config({
  current_function = false,
  show_filename = true,
  diagnostics = true,
  update_interval = 1000, -- prevent crazy cpu use polling rust-analyzer all the time
  indicator_errors = 'E',
  indicator_warnings = 'W',
  indicator_info = 'i',
  indicator_hint = '?',
  indicator_ok = 'Ok',
})

lsp_status.register_progress()

--[[
--  conditionally sets mappings if the lsp supports it
local alt_key_mappings = {
    {"code_lens", "n", "<leader>lcld","<Cmd>lua vim.lsp.codelens.refresh()<CR>"},
    {"code_lens", "n", "<leader>lclr", "<Cmd>lua vim.lsp.codelens.run()<CR>"}
}

local function set_lsp_config(client, bufnr)
    require"lsp_signature".on_attach({
        bind = true,
        handler_opts = {border = "single"}
    })

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(...) end

    buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    for _, mappings in pairs(alt_key_mappings) do
        local capability, mode, lhs, rhs = unpack(mappings)
        if client.resolved_capabilities[capability] then
            buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end
    end

end

-- rust_analyzer
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
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach, lsp_status.on_attach, capabilities = capabilities })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = { prefix = "⮑", spacing = 1, },
    signs = true,
    underline = true,
    update_in_insert = true,
  }
)
--]]

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim

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
    additional_vim_regex_highlighting = true,
  },
}

-- nvimtree
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- default mappings
vim.g.nvim_tree_bindings = {
  { key = {"<CR>", "<Tab>", "<2-LeftMouse>"}, cb = tree_cb("edit") },
  { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
  { key = "<C-v>",                        cb = tree_cb("vsplit") },
  { key = "<C-x>",                        cb = tree_cb("split") },
  { key = "<C-t>",                        cb = tree_cb("tabnew") },
  { key = "<",                            cb = tree_cb("prev_sibling") },
  { key = ">",                            cb = tree_cb("next_sibling") },
  { key = "P",                            cb = tree_cb("parent_node") },
  { key = "<BS>",                         cb = tree_cb("close_node") },
  { key = "<S-CR>",                       cb = tree_cb("close_node") },
  { key = "K",                            cb = tree_cb("first_sibling") },
  { key = "J",                            cb = tree_cb("last_sibling") },
  { key = "I",                            cb = tree_cb("toggle_ignored") },
  { key = "H",                            cb = tree_cb("toggle_dotfiles") },
  { key = "R",                            cb = tree_cb("refresh") },
  { key = "a",                            cb = tree_cb("create") },
  { key = "d",                            cb = tree_cb("remove") },
  { key = "r",                            cb = tree_cb("rename") },
  { key = "<C-r>",                        cb = tree_cb("full_rename") },
  { key = "x",                            cb = tree_cb("cut") },
  { key = "c",                            cb = tree_cb("copy") },
  { key = "p",                            cb = tree_cb("paste") },
  { key = "y",                            cb = tree_cb("copy_name") },
  { key = "Y",                            cb = tree_cb("copy_path") },
  { key = "gy",                           cb = tree_cb("copy_absolute_path") },
  { key = "[c",                           cb = tree_cb("prev_git_item") },
  { key = "]c",                           cb = tree_cb("next_git_item") },
  { key = "-",                            cb = tree_cb("dir_up") },
  { key = "s",                            cb = tree_cb("system_open") },
  { key = "q",                            cb = tree_cb("close") },
  { key = "g?",                           cb = tree_cb("toggle_help") },
}

-- bufferline.nvim
require("bufferline").setup {
  diagnostics = "nvim_lsp",
  offsets = {
    {
      filetype = "NvimTree",
      text = function() return vim.fn.getcwd() end,
      text_align = "left"
    }
  },
  options = {
    close_command = "bdelete! %d",
  },
}

_G.Rename = {
   rename = require('util').rename,
   dorename = require('util').dorename
}

--vim.api.nvim_set_keymap('n', '<leader>lr', '<cmd>lua Rename.rename()<CR>', {silent = true})

vim.g.gitblame_enabled = 0

require('bufdelete')
require('config.telescope')
require('config.which')
--require('config.nvchad_statusline')
