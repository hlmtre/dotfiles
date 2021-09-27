local wk = require("which-key")

wk.register({
  f = {
    name = "file",
    f = { "<cmd>Telescope find_files<cr>", "find file" },
    r = { "<cmd>Telescope oldfiles<cr>", "open recent" },
    e = { "<cmd>e $MYVIMRC<CR>", "edit $MYVIMRC" },
    s = { "<cmd>source $MYVIMRC<CR>", "source $MYVIMRC" },
  },
  ["0"] = { "<cmd>NvimTreeFocus<CR>", "nvimtree" },
  m = { "<cmd>Telescope keymaps<CR>", "keymaps" },
  b = {
    name = "buffers",
    d = { "<cmd>Bdelete!<CR>", "close" },
    n = { "<cmd>ene<CR>", "new" },
    b = { "<cmd>Telescope buffers<CR>", "list" },
  },
  p = {
    name = "packer",
    s = { "<cmd>PackerSync<CR>", "sync" },
    c = { "<cmd>PackerCompile<CR>", "compile" },
  },
  g = {
    name = "git",
    s = { "<cmd>Neogit<CR>", "status" },
    b = { "<cmd>GitBlameToggle<CR>", "blame" },
  },
  x = {
    name = "autopairs",
    d = { function() require('nvim-autopairs').disable() end, "disable"},
    e = { function() require('nvim-autopairs').enable() end, "enable"}
  }
}, {
  prefix = "<leader>",
})

local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = false,
  noremap = true,
  nowait = true,
}

local mappings = {
  ["l"] = {
    name = "lsp",
    R = { ":RustRunnables<CR>", "rust runnables" },
    e = { function() vim.lsp.buf.references() end, "references" },
    r = { function() Rename.rename() end, "rename" },
    a = { function() vim.lsp.buf.code_action() end, "code action" },
    d = { function() vim.lsp.diagnostic.show_line_diagnostics() end, "diagnostics" },
    D = { function() vim.lsp.buf.definition() end, "definition" },
    t = { ":LspTroubleDocumentToggle<CR>", "trouble" },
  },
}

wk.register(mappings, opts)

local plugins = {}
plugins = {
  marks = true,
  registers = true,
  spelling = {
    enabled = true,
    suggestions = 20,
  },
}

-- the rest of our defaults are fine atm
wk.setup({ plugins = plugins })
