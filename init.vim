" TODO: Split init.vim into multiple files after 300 loc
"
" TODO: check other init.vim's for Inspiration
" https://github.com/zhranklin/init.vim/blob/master/files/.config/nvim/init.vim
"

"""""""""""""""""""""
" plugins, vim-plug "
"""""""""""""""""""""
call plug#begin(stdpath('data') . '/plugged')

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'ThePrimeagen/vim-be-good'
Plug 'glepnir/galaxyline.nvim', { 'branch': 'main' }
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'itchyny/calendar.vim'    
Plug 'itchyny/vim-cursorword'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/vim-easy-align' 
Plug 'justinmk/vim-dirvish'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'kyazdani42/nvim-web-devicons'  " needed for galaxyline icons
Plug 'lewis6991/gitsigns.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'tools-life/taskwiki'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'vimwiki/vimwiki',        { 'branch': 'dev'}
Plug 'voldikss/vim-floaterm'
Plug 'windwp/nvim-autopairs'

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
set tabstop=4         "the width of a tab
set shiftwidth=4      "the width for indent
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
set background=dark 
hi Normal guibg=NONE ctermbg=NONE

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
let g:vimwiki_use_calendar = 1
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_global_ext = 0
let g:vimwiki_folding = 'syntax'
let g:vimwiki_list = [{'path': '~/vimwiki/',
            \ 'syntax': 'markdown', 'ext': '.md'}]

au BufNewFile ~/vimwiki/diary/*.md
  \ call append(0,[
  \ "# " . split(expand('%:r'),'/')[-1], "",
  \ "## Summary",  "",
  \ "## Todo",  "",
  \ "## Standup",  "",
  \ "## Notes", "" ])

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

" floaterm "
let g:floaterm_keymap_toggle = ',,'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9

"""""""""""""""""""""""""""""""""""
" mapping, keybinds, binds, remap "
"""""""""""""""""""""""""""""""""""
" vimwiki diary"
nmap <C-Left> <Plug>VimwikiDiaryPrevDay
nmap <C-Right> <Plug>VimwikiDiaryNextDay

" mark alias 
nnoremap M m
nnoremap gm '
nnoremap gM '

" insert date
nnoremap <leader>D :put =strftime('# %a %Y-%m-%d %H:%M:%S%z')<CR>

" leader
let mapleader = "\<Space>"
nnoremap <SPACE> <Nop>

" clear search highlights
nnoremap <C-L>            :nohlsearch<CR><C-L>

" reload, vimrc, init.vim
nnoremap <leader>sv       :source $MYVIMRC<CR>
nnoremap <leader>ss       :source $MYVIMRC<CR>

" windows
nnoremap ,ww <C-w>w 
nnoremap ,wn <C-w>h 
nnoremap ,we <C-w>j 
nnoremap ,wu <C-w>k 
nnoremap ,wi <C-w>l 
nnoremap ,wmn <C-w>H 
nnoremap ,wme <C-w>J 
nnoremap ,wmu <C-w>K 
nnoremap ,wmi <C-w>L 
nnoremap ,wv :vsplit<CR>
nnoremap ,wh :split<CR>
nnoremap ,ws :w<CR>
nnoremap ,wc :close<CR>
nnoremap ,wd :x<CR>
nnoremap ,wq :q!<CR>
nnoremap ,wo <C-w>o

" tabs
" nnoremap <leader>tt :tabnew<CR>
nnoremap ,tn  gT
nnoremap ,ti gt
nnoremap ,td :tabclose<CR>
nnoremap ,tt :tab split<CR>

" buffer
nnoremap ,bi :bnext<CR>
nnoremap ,bn :brev<CR>
nnoremap ,bs :wq<CR>
nnoremap ,bS :wq!<CR>
nnoremap ,bd :bd<CR>
nnoremap ,bD :q!<CR>


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
" find telescope
nnoremap <Leader>f' :lua require'telescope.builtin'.marks{}<CR>
nnoremap <Leader>f. :lua require'telescope.builtin'.grep_string{}<CR>
nnoremap <Leader>f/ :lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>
nnoremap <Leader>fB :lua require'telescope.builtin'.file_browser{}<CR>
nnoremap <Leader>fT :lua require'telescope.builtin'.treesitter{}<CR>
nnoremap <Leader>ff :lua require'telescope.builtin'.find_files{}<CR>
nnoremap <Leader>fgf :lua require'telescope.builtin'.git_files{}<CR>
nnoremap <Leader>fgs :lua require'telescope.builtin'.git_status{}<CR>
nnoremap <Leader>fm :lua require'telescope.builtin'.marks{}<CR>
nnoremap <Leader>fo :lua require'telescope.builtin'.oldfiles{}<CR>
nnoremap <Leader>fr :lua require'telescope.builtin'.live_grep{}<CR>
nnoremap <Leader>ft :lua require'telescope.builtin'.builtin{}<CR>
nnoremap <leader>fb :lua require'telescope.builtin'.buffers{}<CR>

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
nnoremap <silent> <space>c <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gi       <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gn       <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gr       <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gwa      <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <silent> gwl      <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nnoremap <silent> gwr      <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>


" nnoremap <leader>; :x<CR>
nnoremap <leader><BS> :x<CR>
nnoremap <BS> ;
vnoremap <BS> ;
nnoremap <space><space> :w<CR>

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
require('gitsigns').setup()
require('nvim-autopairs').setup{}
EOF

" autocmd "
autocmd FileType help  setlocal number
autocmd FileType help  setlocal relativenumber
