local wk = require('which-key')

wk.register({
  f = {
    name = "file",
    f = { "<cmd>Telescope find_files<cr>", "find file" }, 
    r = { "<cmd>Telescope oldfiles<cr>", "open recent" }, 
    e = { "<cmd>e $MYVIMRC<CR>", "edit $MYVIMRC"},
    s = { "<cmd>source $MYVIMRC<CR>", "source $MYVIMRC"}, 
  }, 
  ["0"] = { "<cmd>NvimTreeFocus<CR>", "nvimtree" },
  m = { "<cmd>Telescope keymaps<CR>", "keymaps"},
  p = {
    name = "packer",
    s = {"<cmd>packer sync<CR>", "packer sync" },
  },
  g = { "<cmd>Neogit<CR>", "git"},
  --g = { "<cmd>Magit<CR>", "git"},
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