" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lspconfig'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'rust-lang/rust.vim'
Plug 'vim-syntastic/syntastic'
Plug 'junegunn/fzf'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/deoplete-lsp'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-gitgutter'
call plug#end()

" general
set number
set showtabline=2
syntax on
filetype plugin indent on
set ts=2
set shiftwidth=2
autocmd vimenter * colorscheme gruvbox
let g:NERDTreeWinPos = "right"
"
" mapping
map <F2> :NERDTreeToggle<CR>
nmap <C-P> :FZF<CR>


" rust
"let g:deoplete#enable_at_startup = 1
"let g:neosnippet#enable_complete_done = 1
"let g:LanguageClient_serverCommands = {
"    \ 'rust': ['~/.cargo/bin/ra_lsp_server'],
"    \ }
let g:LanguageClient_serverCommands = {  'rust': ['rust-analyzer'], }
let g:rustfmt_autosave = 1
let g:rustc_path = $HOME."/.cargo/bin/rustc"
" lua require'nvim_lsp'.rust_analyzer.setup{}
set completeopt=menuone,noinsert,noselect
" Avoid showing extra messages when using completion
set shortmess+=c
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'nvim_lsp'

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
		    require'diagnostic'.on_attach(client)
			end

			-- Enable rust_analyzer
			nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })

EOF
autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc
let g:deoplete#enable_at_startup = 1
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
			\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }
" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
" Visualize diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_trimmed_virtual_text = '40'
" Don't show diagnostics while in insert mode
let g:diagnostic_insert_delay = 1

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>PrevDiagnosticCycle<cr>
nnoremap <silent> g] <cmd>NextDiagnosticCycle<cr>
