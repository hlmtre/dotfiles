local wk = require('which-key')

wk.register({
  f = {
    name = "file",
    f = { "<cmd>Telescope find_files<cr>", "find file" }, 
    r = { "<cmd>Telescope oldfiles<cr>", "open recent file" }, 
    e = { "<cmd>e $MYVIMRC<CR>", "edit $MYVIMRC"},
    s = { "<cmd>source $MYVIMRC<CR>", "source $MYVIMRC"}, 
  }, 
  ["0"] = { "<cmd>NvimTreeFocus<CR>", "nvimtree" },
  m = { "<cmd>Telescope keymaps<CR>", "keymaps"},
  p = {
    name = "vim-plug",
    i = {"<cmd>PlugInstall<CR>", "plug install" },
    c = {"<cmd>PlugClean<CR>", "plug clean" },
  },
}, { prefix = "<leader>" })

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
wk.setup{plugins=plugins}
