local mappings = {
  { mode = 'n' },
  { '<leader>0', '<cmd>Neotree focus<CR>', desc = 'neotree', nowait = true, remap = false, silent = false },
  { '<leader>M', '<cmd>Mason<CR>', desc = 'mason', nowait = true, remap = false, silent = false },
  { '<leader>b', group = 'buffers', nowait = true, remap = false, silent = false },
  { '<leader>bb', '<cmd>Telescope buffers<CR>', desc = 'list', nowait = true, remap = false, silent = false },
  { '<leader>bd', '<cmd>Bdelete!<CR>', desc = 'close', nowait = true, remap = false, silent = false },
  { '<leader>bl', '<cmd>b#<CR>', desc = 'last', nowait = true, remap = false, silent = false },
  { '<leader>bn', '<cmd>ene<CR>', desc = 'new', nowait = true, remap = false, silent = false },
  { '<leader>f', group = 'file', nowait = true, remap = false, silent = false },
  { '<leader>fe', '<cmd>e $MYVIMRC<CR>', desc = 'edit $MYVIMRC', nowait = true, remap = false, silent = false },
  { '<leader>ff', '<cmd>Telescope file_browser<cr>', desc = 'find file', nowait = true, remap = false, silent = false },
  { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'open recent', nowait = true, remap = false, silent = false },
  { '<leader>fs', '<cmd>source $MYVIMRC<CR>', desc = 'source $MYVIMRC', nowait = true, remap = false, silent = false },
  { '<leader>g', group = 'git', nowait = true, remap = false, silent = false },
  { '<leader>gb', '<cmd>BlameToggle<CR>', desc = 'blame', nowait = true, remap = false, silent = false },
  { '<leader>gs', '<cmd>LazyGit<CR>', desc = 'LazyGit', nowait = true, remap = false, silent = false },
  { '<leader>l', group = 'lsp', nowait = true, remap = false, silent = false },
  {
    '<leader>lD',
    function()
      vim.lsp.buf.definition()
    end,
    desc = 'definition',
    nowait = true,
    remap = false,
    silent = false,
  },
  { '<leader>lR', ':RustRunnables<CR>', desc = 'rust runnables', nowait = true, remap = false, silent = false },
  { '<leader>la', ':CodeActionMenu<CR>', desc = 'code action', nowait = true, remap = false, silent = false },
  {
    '<leader>ld',
    function()
      vim.lsp.diagnostic.show_line_diagnostics()
    end,
    desc = 'diagnostics',
    nowait = true,
    remap = false,
    silent = false,
  },
  {
    '<leader>le',
    function()
      vim.lsp.buf.references()
    end,
    desc = 'references',
    nowait = true,
    remap = false,
    silent = false,
  },
  { '<leader>lr', ':IncRename ', desc = 'rename', nowait = true, remap = false, silent = false },
  { '<leader>lt', ':Trouble<CR>', desc = 'trouble', nowait = true, remap = false, silent = false },
  { '<leader>m', '<cmd>Telescope keymaps<CR>', desc = 'keymaps', nowait = true, remap = false, silent = false },
  { '<leader>p', '<cmd>Lazy<cr>', desc = 'lazy', nowait = true, remap = false, silent = false },
  { '<leader>s', group = 'session', nowait = true, remap = false, silent = false },
  {
    '<leader>sl',
    '<cmd>SessionManager load_last_session<cr>',
    desc = 'load last session',
    nowait = true,
    remap = false,
    silent = false,
  },
  { '<leader>t', '<cmd>Tagbar<CR>', desc = 'tagbar', nowait = true, remap = false, silent = false },
  { '<leader>w', '<cmd>WhichKey<CR>', desc = 'which', nowait = true, remap = false, silent = false },
  { '<leader>x', group = 'autopairs', nowait = true, remap = false, silent = false },
  {
    '<leader>xd',
    function()
      require('nvim-autopairs').disable()
    end,
    desc = 'disable',
    nowait = true,
    remap = false,
    silent = false,
  },
  {
    '<leader>xe',
    function()
      require('nvim-autopairs').enable()
    end,
    desc = 'enable',
    nowait = true,
    remap = false,
    silent = false,
  },
  --  { prefix = '<leader>' },
}

--[[
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
    t = { ':Trouble<CR>', 'trouble' },
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
  w = {
    ':WhichKey<CR>',
    'which',
  },
  g = {
    name = 'git',
    s = { '<cmd>LazyGit<CR>', 'LazyGit' },
    b = { '<cmd>BlameToggle<CR>', 'blame' },
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
]]

local wk = require('which-key')
wk.add(mappings)

local opts = {
  preset = 'helix',
}

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
wk.setup({ plugins = plugins, opts = opts })
