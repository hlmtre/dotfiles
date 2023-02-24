--[[
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

--[[
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

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim

-- treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed =  "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
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
print('inside a comment lol')
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
"nnoremap <C-l> :BufferLineCycleNext<CR>
"nnoremap <C-h> :BufferLineCyclePrev<CR>

vim.api.nvim_set_keymap('n', '<C-l>', '<Plug>(cokeline-focus-next)', {silent = true})
vim.api.nvim_set_keymap('n', '<C-h>', '<Plug>(cokeline-focus-prev)', {silent = true})
--]]
vim.api.nvim_set_keymap('n', '<C-l>', '<cmd>BufferLineCycleNext<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-h>', '<cmd>BufferLineCyclePrev<CR>', {silent = true})

--[[
_G._rename = require('util')._rename
_G.rename = require('util').prename

_G.Rename = {
   rename = require('util').prename,
   _rename = require('util')._rename
}
--]]

--vim.api.nvim_set_keymap('n', '<leader>lr', '<cmd>lua Rename.rename()<CR>', {silent = true})



vim.g.gitblame_enabled = 0

--require('bufdelete')
print('inside config/init.lua')
require('config.telescope')
require('config.which')
--require('config.nvchad_statusline')
