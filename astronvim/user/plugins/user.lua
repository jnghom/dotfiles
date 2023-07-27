return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    name = "tokyonight",
    config = function()
      vim.cmd [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=DarkSlateBlue
      hi LspReferenceText cterm=bold ctermbg=red guibg=#823838
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=MediumPurple3
      ]]
      -- vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require('lspsaga').setup({})
    end,
  },
  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- after = "nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup {
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      }
    end,
  },
  { "Vimjas/vim-python-pep8-indent" },
  { "farmergreg/vim-lastplace" },
  { "christoomey/vim-tmux-navigator" },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        manual_mode = true,
      }
    end,
  },
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    -- after = "telescope.nvim",
    config = function() require("telescope").load_extension "project" end,
  },
  {
    "kosayoda/nvim-lightbulb",
    dependencies = "antoinemadec/FixCursorHold.nvim",
    config = function() require("nvim-lightbulb").setup { autocmd = { enabled = true } } end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function() require("symbols-outline").setup() end,
  },
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function() require("octo").setup() end,
  },
  {
    "tpope/vim-fugitive",
  },
  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function() require("trouble").setup {} end,
  },
  {
    "gbprod/yanky.nvim",
    config = function()
      require("yanky").setup({})
    end
  },
  {
    'jvgrootveld/telescope-zoxide',
    dependencies = "nvim-telescope/telescope.nvim",
    -- after = "telescope.nvim",
    config = function()
      require("telescope").load_extension('zoxide')
    end
  }
}
