-- bootstrap lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- vim.opt.nocompatible = true

vim.cmd([[autocmd FileType markdown setlocal spell spelllang=en_gb]])
vim.cmd([[autocmd FileType gitcommit setlocal spell spelllang=en_gb]])
vim.cmd([[autocmd FileType markdown setlocal complete+=kspell]])
vim.cmd([[autocmd FileType gitcommit setlocal complete+=kspell]])
vim.cmd([[autocmd FileType help setlocal nospell]])

vim.cmd([[source $HOME/.config/nvim/bedit.vim]])
--" general editor stuff
--autocmd vimenter * ++nested colorscheme gruvbox
vim.g.gruvbox_contrast_dark = 'hard'
-- let g:gruvbox_contrast_dark = 'hard'

-- Set updatetime for CursorHold
vim.api.nvim_set_option('updatetime', 1000)
vim.opt.updatetime = 1000
-- autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})

vim.keymap.set('n', 'g[', function()
  vim.lsp.diagnostic.goto_prev()
end)
vim.keymap.set('n', 'g]', function()
  vim.lsp.diagnostic.goto_next()
end)
vim.keymap.set('n', 'gD', function()
  vim.lsp.buf.definition()
end)
vim.keymap.set('n', 'ga', function()
  vim.lsp.buf.code_action()
end)
vim.keymap.set('n', 'K', function()
  vim.lsp.buf.hover()
end)
--nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
--nnoremap <silent> gD    <cmd>lua vim.lsp.buf.definition()<CR>
--nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
--nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
--nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
--Code navigation shortcuts
--nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
--nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
--nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
--nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
--nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
--nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
--nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
--inoremap <expr> <C-j>   pumvisible() ? "\<C-n>" : "\<C-j>"
--inoremap <expr> <C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"
-- make esc get you out of terminal insert mode
-- tnoremap <silent> <Esc> <C-\><C-n>

--" goto-preview
--"nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
--"nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
--"nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
--
--
--" nvimtree now set in plugins.lua setup
vim.g.nvim_tree_side = 'right' --left by default
vim.g.nvim_tree_width = 40 --30 by default, can be width_in_columns or 'width_in_percent%'
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_follow_update_path = 1
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_disable_default_keybindings = 1

-- rust
vim.g.rustfmt_autosave = 1

vim.cmd([[autocmd BufWritePre *.rs lua vim.lsp.buf.format() ]])
vim.cmd([[autocmd BufWritePre *.lua lua require('stylua').format() ]])
--" Use completion-nvim in every buffer
--vim.cmd([[autocmd BufEnter * lua require('completion').on_attach() ]])
--let g:lsp_diagnostics_echo_cursor = 1
--
--" general autoformat with neoformat
--augroup fmt
--  autocmd!
--  autocmd BufWritePre undojoin | Neoformat
--augroup END
--
--" Enable alignment
vim.g.neoformat_basic_format_align = 1
-- Enable tab to spaces conversion
vim.g.neoformat_basic_format_retab = 1
-- Enable trimmming of trailing whitespace
vim.g.neoformat_basic_format_trim = 1
--
--" general editor
--" spcbr
--let mapleader = " "
vim.o.number = true
-- vim.o.syntax = true
vim.o.showtabline = 2
--nnoremap <silent> <leader>bx :Bdelete<CR>
--"execute "nnoremap <silent> " . g:magit_show_magit_mapping . " :call magit#show_magit('h')<cr>"
--" nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
vim.o.ts = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.opt.listchars.extends = { tab = '>-' }
vim.o.ai = true
vim.o.si = true
vim.o.mouse = 'a'
--autocmd BufEnter * lcd %:p:h
--set completeopt=menuone,noinsert,noselect
vim.o.omnifunc = 'v:vim.lsp.omnifunc'
--set shortmess+=c
--set timeoutlen=300
vim.o.signcolumn = 'number'
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.smartcase = true
--" ctrl+a/x (inc/dec)
--vim.api.nvim_exec([[nnoremap + <C-a>]])
--vim.api.nvim_exec([[nnoremap - <C-x>]])
--
vim.o.breakindent = true
-- vim.o.breakindentopt = true
-- vim.o.showbreak="\\\\\""
--
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldcolumn = '1'
vim.opt.foldtext = ' '
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 1
vim.opt.foldnestmax = 4
vim.opt.foldenable = false
--
--" persistent undo!
vim.o.undodir = '/tmp/.undodir_' .. os.getenv('USER')
--if !isdirectory(s:undodir)
--    call mkdir(s:undodir, "", 0700)
--endif
--let &undodir=s:undodir
vim.o.undofile = true
--
--vim.cmd([[autocmd VimEnter * IndentLinesEnable]])
vim.g.do_filetype_lua = 1
--vim.o.filetype plugin on
--
vim.g.tagbar_position = 'topleft vertical'
--
--

-- made obsolete by lsp_lines plugin
vim.diagnostic.config({
  virtual_text = false,
})
require('plugins')
require('config.init')
