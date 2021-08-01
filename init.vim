" TODO: Split init.vim into multiple files after 300 loc
"
" TODO: check other init.vim's for Inspiration
" https://github.com/zhranklin/init.vim/blob/master/files/.config/nvim/init.vim
"

"""""""""""""""""""""
" plugins, vim-plug "
"""""""""""""""""""""
call plug#begin(stdpath('data') . '/plugged')

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'glepnir/galaxyline.nvim', { 'branch': 'main' }
Plug 'kyazdani42/nvim-web-devicons'  " needed for galaxyline icons

Plug 'ThePrimeagen/vim-be-good'

Plug 'itchyny/calendar.vim'    
Plug 'itchyny/vim-cursorword'
" Plug 'itchyny/lightline.vim'

" theme
Plug 'joshdick/onedark.vim'

Plug 'junegunn/vim-easy-align' 

Plug 'justinmk/vim-dirvish'

Plug 'tools-life/taskwiki'
Plug 'vimwiki/vimwiki',        { 'branch': 'dev'}

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'

" Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/nvim-compe'

call plug#end()

"""""""""""""""""""
" neovim settings "
"""""""""""""""""""
" basic settings
set title
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1
set fileformat=unix
set fileformats=unix,dos,mac
filetype on
filetype plugin on
filetype plugin indent on
syntax on
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=10
set shell=zsh
" set inccommand " ?



" Some useful settings
set smartindent
set expandtab         "tab to spaces
set tabstop=2         "the width of a tab
set shiftwidth=2      "the width for indent
set foldenable
set foldmethod=indent
set foldlevel=99
set ignorecase        "ignore the case when search texts
set smartcase         "if searching text contains uppercase case will not be ignored
set incsearch
set visualbell
set ruler
set virtualedit=all
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent
set mouse=a

" appearance
set number           "line number
set relativenumber
set cursorline       "hilight the line of the cursor
set nocursorcolumn     "hilight the column of the cursor
" set nowrap           "no line wrapping
colorscheme onedark  

highlight Normal guibg=black guifg=white
hi Normal ctermbg=16 guibg=#000000
hi LineNr ctermbg=16 guibg=#000000
set background=dark 

" Other Settings
set termguicolors
set clipboard=unnamedplus

set smarttab
set linebreak
set cindent " idk what this does

set timeoutlen=10000 " 10 second timeout

set hidden

" FIXME: conceal cursor
set concealcursor=
set conceallevel=0

if has('persistent_undo')         "check if your vim version supports
    set undodir=$HOME/.vim/undo     "directory where the undo files will be stored
    set undofile                    "turn on the feature
endif

"""""""""""""""""""
" plugin settings "
"""""""""""""""""""

" Vimwiki
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_global_ext = 0
let g:vimwiki_folding = 'syntax'
let g:vimwiki_list = [{'path': '~/vimwiki/',
            \ 'syntax': 'markdown', 'ext': '.md'}]

" Taskwiki
let g:taskwiki_markup_syntax = 'markdown'

" Calendar.vim
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

source ~/.cache/calendar.vim/credentials.vim

" " lightline
" let g:lightline = {
"       \ 'colorscheme': 'onedark',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'FugitiveHead'
"       \ },
"       \ }

"""""""""""""""""""""""""""""""""""
" mapping, keybinds, binds, remap "
"""""""""""""""""""""""""""""""""""

" leader
let mapleader = "\<Space>"
nnoremap <SPACE> <Nop>

" clear search highlights
nnoremap <C-L>            :nohlsearch<CR><C-L>

" reload, vimrc, init.vim
nnoremap <leader>sv       :source $MYVIMRC<CR>
nnoremap <leader>ss       :source $MYVIMRC<CR>

nnoremap <A-C-n> <C-w>h
nnoremap <A-C-e> <C-w>j
nnoremap <A-C-u> <C-w>k
nnoremap <A-C-i> <C-w>l

nnoremap <leader>vv :vsplit<CR>
nnoremap <leader>vs :split<CR>
" nnoremap <leader>d :close<CR>

" tabs
" nnoremap <leader>tt :tabnew<CR>
nnoremap tn  gT
nnoremap ti gt
nnoremap td :tabclose<CR>
noremap tt :tab split<CR>


" buffer
nnoremap <leader>bi :bnext<CR>
nnoremap <leader>bn :brev<CR>
nnoremap <leader>bs :wq<CR>
nnoremap <leader>bS :wq!<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>bD :q!<CR>


"" plugins

" git, fugitive
nnoremap <leader>gg       :vert bo Git<CR>
nnoremap <leader>gp       :Git push<CR>
nnoremap <leader>gl       :Git pull<CR>
nnoremap <leader>gf       :Git fetch<CR>
nnoremap <leader>gb       :Git blame<CR>

" >> EasyAlign
xmap     ga               <Plug>(EasyAlign)
nmap     ga               <Plug>(EasyAlign)

" >> Telescope bindings
nnoremap <Leader>pp :lua require'telescope.builtin'.builtin{}<CR>
" most recentuly used files
nnoremap <Leader>m :lua require'telescope.builtin'.oldfiles{}<CR>
" find buffer
nnoremap <leader>bb :lua require'telescope.builtin'.buffers{}<CR>
nnoremap <leader><leader> :lua require'telescope.builtin'.buffers{}<CR>
" find in current buffer
nnoremap <Leader>/ :lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>
" bookmarks
nnoremap <Leader>' :lua require'telescope.builtin'.marks{}<CR>
" git files
nnoremap <Leader>. :lua require'telescope.builtin'.git_files{}<CR>
" all files
nnoremap <Leader>o :lua require'telescope.builtin'.find_files{}<CR>
" ripgrep like grep through dir
nnoremap <Leader>f :lua require'telescope.builtin'.live_grep{}<CR>

" >> LSP Key Bindings
nnoremap <silent> <C-k>    <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <space>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> K        <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> [d       <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d       <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> gD       <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd       <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ge       <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> gf       <cmd>lua vim.lsp.buf.formatting()<CR>
"nnoremap <silent> gc       <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gi       <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gn       <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gr       <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gwa      <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <silent> gwl      <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nnoremap <silent> gwr      <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>

"""""""""""""""""""""
" aliases, commands "
"""""""""""""""""""""

" help, man
cabbrev Manv vert bo Man
cabbrev hv vert bo help

" save, quit
command W w
command WQ wq
command Wq wq
command Q q

"""""""
" lua "
"""""""

lua <<EOF
require("lsp")
require("treesitter")
require("completion")
require("statusbar")
require'lspsaga'.init_lsp_saga()
EOF


