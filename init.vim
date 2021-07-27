" TODO: Split init.vim into multiple files after 300 loc
"
" TODO: check other init.vim's for Inspiration
" https://github.com/zhranklin/init.vim/blob/master/files/.config/nvim/init.vim
"

"""""""""""""""""""""
" plugins, vim-plug "
"""""""""""""""""""""
  call plug#begin(stdpath('data') . '/plugged')

  Plug 'ThePrimeagen/vim-be-good'
  Plug 'itchyny/calendar.vim'    
  Plug 'itchyny/lightline.vim'
  Plug 'itchyny/vim-cursorword'
  Plug 'joshdick/onedark.vim'
  Plug 'junegunn/fzf',           { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align' 
  Plug 'justinmk/vim-dirvish'
  Plug 'tools-life/taskwiki'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-sensible'
  Plug 'vimwiki/vimwiki',        { 'branch': 'dev'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'

  call plug#end()

"""""""
" lua "
"""""""

lua << EOF
require'lspconfig'.pyright.setup{}
vim.o.completeopt = "menuone,noselect"

-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

--This line is important for auto-import
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })

EOF

" nvim-compe

" inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <CR>      compe#confirm('<CR>')
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

"""""""""""""""""""
" neovim settings "
"""""""""""""""""""
  " Fundamental settings
  set fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1
  set fileformat=unix
  set fileformats=unix,dos,mac
  filetype on
  filetype plugin on
  filetype plugin indent on
  syntax on

  " Some useful settings
  set smartindent
  set expandtab         "tab to spaces
  set tabstop=2         "the width of a tab
  set shiftwidth=2      "the width for indent
  set foldenable
  set foldmethod=indent
  set foldlevel=99
  set smartcase         "if searching text contains uppercase case will not be ignored
  set ignorecase        "ignore the case when search texts

  " appearance
  set number           "line number
  set relativenumber
  set nocursorline       "hilight the line of the cursor
  set nocursorcolumn     "hilight the column of the cursor
  " set nowrap           "no line wrapping
  colorscheme onedark  
  set background=dark "use the light version of gruvbox

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

  " lightline
  let g:lightline = {
        \ 'colorscheme': 'onedark',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
        \   'gitbranch': 'FugitiveHead'
        \ },
        \ }

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

  " help, man
  nnoremap      <S-K>            :vert bo Man<CR>

  " windows
  " nnoremap <S-A-C-n> <C-w>h
  " nnoremap <S-A-C-e> <C-w>j
  " nnoremap <S-A-C-u> <C-w>k
  " nnoremap <S-A-C-i> <C-w>l

  nnoremap <A-C-n> <C-w>h
  nnoremap <A-C-e> <C-w>j
  nnoremap <A-C-u> <C-w>k
  nnoremap <A-C-i> <C-w>l

  " nnoremap <S-C-n> <C-w>h
  " nnoremap <S-C-e> <C-w>j
  " nnoremap <S-C-u> <C-w>k
  " nnoremap <S-C-i> <C-w>l

  " nnoremap <S-A-n> <C-w>h
  " nnoremap <S-A-e> <C-w>j
  " nnoremap <S-A-u> <C-w>k
  " nnoremap <S-A-i> <C-w>l

  nnoremap <leader>vv :vsplit<CR>
  nnoremap <leader>vs :split<CR>
  " nnoremap <leader>d :close<CR>

  " nnoremap <leader>n <C-w>h
  " nnoremap <leader>e <C-w>j
  " nnoremap <leader>u <C-w>k
  " nnoremap <leader>i <C-w>l

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

  " EasyAlign
  xmap     ga               <Plug>(EasyAlign)
  nmap     ga               <Plug>(EasyAlign)

  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-l> <plug>(fzf-complete-line)

  " Fzf, fuzzy finder
  " nnoremap <leader><tab>    :<plug>
  nnoremap <leader><leader> :GFiles<CR>
  nnoremap <leader><CR>     :Buffers<CR>
  nnoremap <leader>o        :Files<CR>
  nnoremap <leader>O        :Files<CR>
  nnoremap <leader>l        :Lines<CR>
  nnoremap <leader>f        :Ag<CR>
  nnoremap <leader>h        :History<CR>


"""""""""""""""""""""
" aliases, commands "
"""""""""""""""""""""

  " help, man
  cabbrev Man vert bo Man
  cabbrev h vert bo help

  " save, quit
  command W w
  command WQ wq
  command Wq wq
  command Q q
