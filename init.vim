call plug#begin('~/.config/nvim/plugged')
Plug 'navarasu/onedark.nvim'
Plug 'sbdchd/neoformat'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdcommenter' "https://github.com/preservim/nerdcommenter
Plug 'airblade/vim-gitgutter'  "https://github.com/airblade/vim-gitgutter
Plug 'mattn/emmet-vim'
Plug 'AndrewRadev/tagalong.vim',
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'neovim/nvim-lsp'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'petertriho/nvim-scrollbar'
Plug 'kdheepak/lazygit.nvim'
Plug 'akinsho/toggleterm.nvim'
call plug#end()


" Leader Mapping
map <Space> <leader>
" NvimTree
nmap <space>e :NvimTreeToggle<CR>
" Telescope open
nmap <space>t :Telescope <CR>
" Telescope find file
nmap <space>ff :Telescope find_files<CR>
" Switch Panes
nmap <space>w <C-W>w
"Prettier
nmap  <silent> <space>gp :Neoformat prettier<CR>
" setup mapping to call :LazyGit
nnoremap <silent> <leader>gg :LazyGit<CR>
" Normal mode in terminal window
tnoremap <Esc><Esc> <C-\><C-n>
" Buffers
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
" Emmet
let g:user_emmet_leader_key=','
" Tagalong
let g:tagalong_filetypes = ['html',"svelte","vue"]
"Starting directory CtrlP
let g:ctrlp_working_path_mode = 'ra'
" Ignored files/directories from autocomplete (and CtrlP)
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/bundle/*,*/node_modules/.git
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" Svelte syntax fix
" au BufNewFile,BufRead,BufReadPost *.svelte set syntax=html
" Theme
syntax on
set t_Co=256
set cursorline
colorscheme onedark

" Airline 
let g:airline_theme='onedarkpro'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" Nvim-tree
let g:nvim_tree#open_on_setup = 0
let g:nvim_tree_quit_on_open = 1

" LSP
lua <<EOF
  local cmp = require'cmp'
  local actions = require("telescope.actions")
  -- Telescope setup
  require('telescope').setup{ 
    defaults = { 
      file_ignore_patterns = {"node_modules", ".git"}, 
      mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        }
    } 
  }
  --  scrollbar setup
  require("scrollbar").setup({
      show = true,
      handle = {
          color = "#443",
      }
    })
  --  toggleterm setup
  require("toggleterm").setup{  
      open_mapping = [[<c-t>]]    
  }
  -- LSP setup
  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, 
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), 
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, 
    }, {
      { name = 'buffer' },
    })
  })
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  require('lspconfig')['svelte'].setup {capabilities = capabilities}
  require('lspconfig')['eslint'].setup {capabilities = capabilities}
  require('lspconfig')['tsserver'].setup { capabilities = capabilities}
  require('lspconfig')['jsonls'].setup {capabilities = capabilities}
  require('lspconfig')['cssls'].setup {
    {capabilities = capabilities },
    {filetypes = { "css", "scss", "less", "svelte" }}
  }
  require('lspconfig')['cssmodules_ls'].setup {capabilities = capabilities}
EOF

" Ignored files/directories from autocomplete (and CtrlP)
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/bundle/*,*/node_modules/
set title
set hid
set norelativenumber
set autoread
set clipboard+=unnamedplus            " Maps yank to clipboard buffer (needs xsel)
set backspace=indent,eol,start        " http://vi.stackexchange.com/a/2163
set listchars=extends:→               " Show arrow if line continues rightwards
set listchars+=precedes:←             " Show arrow if line continues leftwards
set nobackup nowritebackup noswapfile " Turn off backup files
set history=500
set timeoutlen=1000 ttimeoutlen=0     " Remove timeout when hitting escape
set expandtab shiftwidth=2 tabstop=2  " Four spaces for tabs everywhere
set number
set termguicolors
nnoremap <c-z> <nop>