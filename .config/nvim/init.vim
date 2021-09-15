set nocompatible
lua require('plugins')
"source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/bedit.vim

lua require('config.init')

" general editor stuff
autocmd vimenter * ++nested colorscheme gruvbox
" Enable type inlay hints
"autocmd BufEnter,BufWinEnter,TabEnter *.rs lua require('lsp_extensions').inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
"autocmd BufEnter,BufWinEnter,TabEnter *.rs lua require('rust-tools.inlay_hints').set_inlay_hints()

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
"autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
" Code navigation shortcuts
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
inoremap <expr> <C-j>   pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"

" goto-preview
nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>


" nvimtree
let g:nvim_tree_side = 'right' "left by default
let g:nvim_tree_width = 40 "30 by default, can be width_in_columns or 'width_in_percent%'
let g:nvim_tree_follow = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_follow_update_path = 1

" rust
let g:rustfmt_autosave = 1
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
" Use completion-nvim in every buffer
"autocmd BufEnter * lua require'completion'.on_attach()
let g:lsp_diagnostics_echo_cursor = 1

" general autoformat with neoformat
augroup fmt
  autocmd!
  autocmd BufWritePre undojoin | Neoformat
augroup END

" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1


" general editor
" spcbr
let mapleader = " "
set number
syntax on
set showtabline=2
nnoremap <C-l> :BufferLineCycleNext<CR>
nnoremap <C-h> :BufferLineCyclePrev<CR>
nnoremap <silent> <leader>bx :Bdelete<CR>
"execute "nnoremap <silent> " . g:magit_show_magit_mapping . " :call magit#show_magit('h')<cr>"
" nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
set ts=2
set shiftwidth=2
set expandtab
set list listchars:tab:>-
set ai
set si
set mouse=a
autocmd BufEnter * lcd %:p:h
"nnoremap <C-P> :FZF<CR>
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set timeoutlen=300
set signcolumn=yes
set termguicolors
set ignorecase
set smartcase
" ctrl+a/x (inc/dec)
nnoremap + <C-a>
nnoremap - <C-x>

set breakindent
set breakindentopt=shift:2
set showbreak=\\\\\

" persistent undo!
let s:undodir = "/tmp/.undodir_" . $USER
if !isdirectory(s:undodir)
    call mkdir(s:undodir, "", 0700)
endif
let &undodir=s:undodir
set undofile

autocmd VimEnter * IndentLinesEnable
filetype plugin on

" automatically re-run packer after the packer file is modified
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
