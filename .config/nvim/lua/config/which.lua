local opts = {
  mode = 'n',
  prefix = '<leader>',
  buffer = nil,
  silent = false,
  noremap = true,
  nowait = true,
}

local mappings = {
  ['l'] = {
    name = 'lsp',
    R = { ':RustRunnables<CR>', 'rust runnables' },
    e = {
      function()
        vim.lsp.buf.references()
      end,
      'references',
    },
    r = { ':IncRename ', 'rename' },
    a = { ':CodeActionMenu<CR>', 'code action' },
    d = {
      function()
        vim.lsp.diagnostic.show_line_diagnostics()
      end,
      'diagnostics',
    },
    D = {
      function()
        vim.lsp.buf.definition()
      end,
      'definition',
    },
    t = { ':TroubleToggle<CR>', 'trouble' },
  },
  s = {
    name = 'session',
    l = { '<cmd>SessionManager load_last_session<cr>', 'load last session' },
  },
  f = {
    name = 'file',
    f = { '<cmd>Telescope file_browser<cr>', 'find file' },
    r = { '<cmd>Telescope oldfiles<cr>', 'open recent' },
    e = { '<cmd>e $MYVIMRC<CR>', 'edit $MYVIMRC' },
    s = { '<cmd>source $MYVIMRC<CR>', 'source $MYVIMRC' },
  },
  ['p'] = { '<cmd>Lazy<cr>', 'lazy' },
  ['0'] = { '<cmd>NvimTreeFocus<CR>', 'nvimtree' },
  ['t'] = { '<cmd>Tagbar<CR>', 'tagbar' },
  m = { '<cmd>Telescope keymaps<CR>', 'keymaps' },
  M = { '<cmd>Mason<CR>', 'mason' },
  b = {
    name = 'buffers',
    d = { '<cmd>Bdelete!<CR>', 'close' },
    n = { '<cmd>ene<CR>', 'new' },
    b = { '<cmd>Telescope buffers<CR>', 'list' },
    l = { '<cmd>b#<CR>', 'last' },
  },
  g = {
    name = 'git',
    s = { '<cmd>Neogit<CR>', 'status' },
    b = { '<cmd>GitBlameToggle<CR>', 'blame' },
  },
  x = {
    name = 'autopairs',
    d = {
      function()
        require('nvim-autopairs').disable()
      end,
      'disable',
    },
    e = {
      function()
        require('nvim-autopairs').enable()
      end,
      'enable',
    },
  },
  { prefix = '<leader>' },
}

local wk = require('which-key')
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
