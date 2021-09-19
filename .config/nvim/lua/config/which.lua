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
  g = { "<cmd>Neogit<CR>", "git" },
  --g = { "<cmd>Magit<CR>", "git"},
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
    r = { '<cmd>lua Rename.rename()<CR>', "rename" },
    a = { function() vim.lsp.buf.code_action() end, "code action" },
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
