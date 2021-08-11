-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()
--
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'christoomey/vim-tmux-navigator'
  use 'easymotion/vim-easymotion'
  -- auto-pair
  -- use 'tmsvg/pear-tree'
  use 'windwp/nvim-autopairs'
  use 'ntpeters/vim-better-whitespace'
  use 'nathanaelkane/vim-indent-guides'
  use 'tpope/vim-fugitive'
  use 'junegunn/vim-peekaboo'
  use {'scrooloose/nerdtree', opt = true, cmd = 'NERDTreeToggle' }
  use {'liuchengxu/vim-which-key', cmd = 'WhichKey'}
  -- nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }


  -- use {
  --   'glepnir/galaxyline.nvim',
  --   branch = 'main',
  --   -- some optional icons
  --   requires = {'kyazdani42/nvim-web-devicons', opt = true}
  -- }

  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function() require('lualine').setup() end
  }

  -- Simple plugins can be specified as strings
  -- use '9mm/vim-closer'
  use 'NLKNguyen/papercolor-theme'
  vim.g.colors_name = 'PaperColor'

  -- Lazy loading:
  -- Load on specific commands
  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
  use 'justinmk/vim-sneak'

  use { 'neovim/nvim-lspconfig' }
  -- use { 'nvim-lua/completion-nvim' }

  -- glepnir/lspsaga.nvim

  use {
    '/hrsh7th/nvim-compe',
    config = function()
      require'compe'.setup {
        enabled = true;
        autocomplete = true;
        debug = false;
        min_length = 1;
        preselect = 'enable';
        throttle_time = 80;
        source_timeout = 200;
        resolve_timeout = 800;
        incomplete_delay = 400;
        max_abbr_width = 100;
        max_kind_width = 100;
        max_menu_width = 100;
        documentation = {
          border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
          winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
          max_width = 120,
          min_width = 60,
          max_height = math.floor(vim.o.lines * 0.3),
          min_height = 1,
        },
        source = {
          path = true;
          buffer = true;
          calc = true;
          nvim_lsp = true;
          nvim_lua = true;
          vsnip = true;
          ultisnips = true;
          luasnip = true;
        };
      }
    end
  }
  -- terryma/vim-multiple-cursors
  -- hrsh7th/vim-vsnip

  -- telescope, lsp, treesitter

  -- need lua alternative
  -- textobj
  -- highlight cursor words
  -- magit
  -- fzf
  -- coc
  -- lightline
  --
  -- inline expression
  --
  -- strip trailing whitespace
  -- nerdtree
  -- expand object
  -- restore last position
end)

