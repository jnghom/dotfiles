local function get_python_path(workspace)
  -- Use activated virtualenv.
  print("virtualenv :", vim.env.VIRTUAL_ENV)
  if vim.env.VIRTUAL_ENV then return path.join(vim.env.VIRTUAL_ENV, "bin", "python") end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs { "*", ".*" } do
    local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then return path.join(path.dirname(match), "bin", "python") end
  end

  -- Fallback to system Python.
  return exepath "python3" or exepath "python" or "python"
end

function _G.get_git_path()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    if dot_git_path == nil or dot_git_path == "" then
      return vim.fn.getcwd()
    end
    return vim.fn.fnamemodify(dot_git_path, ":h")
end

local config = {

  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme
  -- colorscheme = "default_theme",
  colorscheme = "tokyonight",

  -- Override highlight groups in any theme
  highlights = {
    -- duskfox = { -- a table of overrides
    --   Normal = { bg = "#000000" },
    -- },
    default_theme = function(highlights) -- or a function that returns one
      local C = require "default_theme.colors"

      highlights.Normal = { fg = C.fg, bg = C.bg }
      return highlights
    end,
  },

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      relativenumber = true, -- sets vim.opt.relativenumber
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
      tokyonight_style = "storm",
    },
  },

  -- Default theme configuration
  default_theme = {
    diagnostics_style = { italic = true },
    -- Modify the color table
    colors = {
      fg = "#abb2bf",
    },
    plugins = { -- enable or disable extra plugin highlighting
      aerial = true,
      beacon = false,
      bufferline = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Disable AstroNvim ui features
  ui = {
    nui_input = true,
    telescope_select = true,
  },

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      -- You can disable default plugins as follows:
      ["declancm/cinnamon.nvim"] = { disable = true },
      ["Darazaki/indent-o-matic"] = { disable = true },
      {
        "folke/tokyonight.nvim",
        as = "tokyonight",
        config = function()
          vim.cmd [[
          hi LspReferenceRead cterm=bold ctermbg=red guibg=DarkSlateBlue
          hi LspReferenceText cterm=bold ctermbg=red guibg=#823838
          hi LspReferenceWrite cterm=bold ctermbg=red guibg=MediumPurple3
          ]]
        end,
      },
      {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
          local saga = require "lspsaga"

          saga.init_lsp_saga {}
        end,
      },
      {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function() require("lsp_signature").setup() end,
      },

      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        requires = { "nvim-treesitter/nvim-treesitter" },
        after = "nvim-treesitter",
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
        requires = {
          { "nvim-lua/plenary.nvim" },
          { "nvim-treesitter/nvim-treesitter" },
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
        requires = "nvim-telescope/telescope.nvim",
        after = "telescope.nvim",
        config = function() require("telescope").load_extension "project" end,
      },
      {
        "kosayoda/nvim-lightbulb",
        requires = "antoinemadec/FixCursorHold.nvim",
        config = function() require("nvim-lightbulb").setup { autocmd = { enabled = true } } end,
      },
      {
        "ibhagwan/fzf-lua",
        requires = { "kyazdani42/nvim-web-devicons" },
      },
      {
        "simrat39/symbols-outline.nvim",
        config = function() require("symbols-outline").setup() end,
      },
      {
        "pwntester/octo.nvim",
        requires = {
          "nvim-lua/plenary.nvim",
          "nvim-telescope/telescope.nvim",
          "kyazdani43/nvim-web-devicons",
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
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require("trouble").setup {} end,
      },
      {
        "gbprod/yanky.nvim",
        config = function()
          require("yanky").setup({})
        end
      }
    },

    -- "--disable=import-error,no-name-in-module,logging-fstring-interpolation",
    -- All other entries override the setup() call for default plugins
    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      config.sources = {
        null_ls.builtins.diagnostics.pylint.with {
          extra_args = {
            "--disable="
                .. "import-error,no-name-in-module,logging-fstring-interpolation,"
                .. "too-few-public-methods,"
                .. "too-many-arguments",
          },
        },
        null_ls.builtins.diagnostics.flake8.with {
          extra_args = {
            "--ignore=E203,E402",
            "--max-line-length",
            "100",
          },
        },
        null_ls.builtins.diagnostics.mypy,
        -- null_ls.builtins.formatting.autopep8,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
        null_ls.builtins.code_actions.gitsigns,

        null_ls.builtins.formatting.jq,
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.code_actions.refactoring,
        -- null_ls.builtins.formatting.json_tool,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.code_actions.shellcheck,
        -- null_ls.builtins.formatting.rufo,
        -- null_ls.builtins.diagnostics.rubocop,
        -- null_ls.builtins.formatting.lua_format,
      }
      -- set up null-ls's on_attach function
      -- config.on_attach = function(client)
      -- NOTE: You can remove this on attach function to disable format on save
      -- if client.resolved_capabilities.document_formatting then
      --   vim.api.nvim_create_autocmd("BufWritePre", {
      --     desc = "Auto format before save",
      --     pattern = "<buffer>",
      --     callback = vim.lsp.buf.formatting_sync,
      --   })
      -- end
      -- end
      return config -- return final config table
    end,
    treesitter = {
      ensure_installed = { "python", "bash", "javascript", "html", "css", "lua", "json" },
      indent = { enabled = true },
    },

    ["mason-lspconfig"] = {
      ensure_installed = {
        "sumneko_lua",
        "pyright",
        "tsserver",
      },
    },
    -- use mason-tool-installer to configure DAP/Formatters/Linter installation
    ["mason-null-ls"] = { -- overrides `require("mason-tool-installer").setup(...)`
      ensure_installed = {
        "prettier",
        "stylua",
        "isort",
        "pylint",
        "flake8",
        "black",
        "mypy",
        "eslint_d",
        "autopep8",
        "yamlfmt",
        "yamllint",
        "jq",
      },
      automatic_setup = false,
    },
    packer = {
      compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua",
    },

    telescope = {
      defaults = {
        mappings = {
          i = {
            -- Telescope not to enter a normal-like mode when hitting escape (and instead exiting)
            ["<esc>"] = require("telescope.actions").close,
            -- clear the prompt on <C-u> rather than scroll the previewer
            ["<C-u>"] = false
          },
        },
      },
      extensions = {
        project = {
          base_dirs = {
            "~/ws",
          },
          hidden_files = false, -- default: false
          -- theme = "dropdown",
          order_by = "recent",
        },
      },
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      javascript = { "javascriptreact" },
    },
  },

  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  lsp = {
    servers = {},
    formatting = {
      format_on_save = {
        enabled = false,
      },
    },
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
        -- ["gr"] = false,
        ["<leader>h"] = false,
        ["<leader>ld"] = {
          "<cmd>lua require'telescope.builtin'.diagnostics{ bufnr=0 }<cr>",
          desc = "diagnostics"
        },
        ["<leader>lD"] = {
          "<cmd>lua require'telescope.builtin'.diagnostics{ root_dir=vim.fn.getcwd() }<cr>",
          desc = "dir diagnostics"
        },
      },
    },
    -- override the mason server-registration function
    -- server_registration = function(server, opts)
    -- end,
    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- https://github.com/microsoft/pyright/blob/main/docs/settings.md
      -- python.venvPath, python.pythonPath
      pyright = {
        settings = {
          python = {
            analysis = {
              autoImportCompletions = false,
              typeCheckingMode = "off", -- or "basic", "strict"
            },
          },
        },
      },
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = false,
    underline = true,
  },

  mappings = {
    n = {

      -- Grep
      ["<leader>,"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "grep in buffer" },
      ["<leader>."] = { "<cmd>lua require'telescope.builtin'.live_grep{ search_dirs={vim.fn.getcwd()} }<cr>", desc = "grep in dir" },
      ["<leader>/"] = { "<cmd>lua require'telescope.builtin'.live_grep{ search_dirs={get_git_path()} }<cr>", desc = "grep in git dir" },

      ["<leader>w,"] = {
        "<cmd>lua require'telescope.builtin'.grep_string{ word_match='-w', search_dirs={'%:p'} }<cr>",
        desc = "word in buffer"
      },
      ["<leader>w."] = {
        "<cmd>lua require'telescope.builtin'.grep_string{ word_match='-w', search_dirs={vim.fn.getcwd()} }<cr>",
        desc = "word in buffer"
      },
      ["<leader>w/"] = {
        "<cmd>lua require'telescope.builtin'.grep_string{ word_match='-w', search_dirs={get_git_path()} }<cr>",
        desc = "word in git dir",
      },

      -- file
      ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", desc = "find_files" },
      ["<leader>fg"] = { "<cmd>Telescope git_files<cr>", desc = "git_files" },
      ["<leader>fo"] = { "<cmd>Telescope oldfiles<cr>", desc = "oldfiles" },

      ["<leader>fp"] = { "<cmd>Telescope project<cr>", desc = "project" },

      ["<leader>h"] = { "<cmd>Telescope help_tags<cr>", desc = "help_tags" },
      ["<leader>b"] = { "<cmd>Telescope builtin<cr>", desc = "builtin" },
      ["<leader>c"] = { "<cmd>Telescope commands<cr>", desc = "command" },
      ["<leader>C"] = { "<cmd>Telescope command_history<cr>", desc = "command_history" },
      ["<leader>k"] = { "<cmd>Telescope keymaps<cr>", desc = "keymaps" },



      ["<leader>ga"] = { "<cmd>Git blame<cr>", desc = "git blame" },
      ["<F6>"] = { "<cmd>Git blame<cr>", desc = "git blame" },

      -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },

      -- Movement
      ["]h"] = { "<cmd>Gitsigns next_hunk<cr>", desc = "Next Hunk" },
      ["[h"] = { "<cmd>Gitsigns prev_hunk<cr>", desc = "Prev Hunk" },
      ["]b"] = { "<cmd>bnext<cr>", desc = "Next buffer" },
      ["[b"] = { "<cmd>bprev<cr>", desc = "Prev buffer" },

      -- LSP
      ["gh"] = { "<cmd>Lspsaga lsp_finder<CR>", desc = "Lspsaga lsp_finder" },
      ["gp"] = { "<cmd>Lspsaga peek_definition<CR>", desc = "Lspsaga peek_definition" },
      -- ["gr"] = { "<cmd>Telescope lsp_references<CR>", desc = "Telescope lsp_references" },
      -- ["r"] = { "<cmd>FzfLua lsp_references<CR>", desc = "FzfLua lsp_references" },

      -- Hop
      [";w"] = { "<cmd>HopWord<cr>", desc = "HopWord" },
      [";e"] = {
        "<cmd>lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>",
        desc = "HopWord END",
      },
      [";s"] = { "<cmd>HopLineStart<cr>", desc = "HopLineStart" },
      [";l"] = { "<cmd>HopLine<cr>", desc = "HopLine" },
      [";1"] = { "<cmd>HopChar1<cr>", desc = "HopChar1" },
      [";2"] = { "<cmd>HopChar2<cr>", desc = "HopChar2" },

      -- Trouble
      ["<leader>xx"] = { "<cmd>TroubleToggle<cr>", desc = "TroubleToggle" },
      ["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "TroubleToggle workspace_diagnostics" },
      ["<leader>xq"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "TroubleToggle document_diagnostics" },
      ["<leader>xr"] = { "<cmd>Trouble lsp_references<cr>", desc = "TroubleToggle lsp_references" },
      ["<leader>xd"] = { "<cmd>TroubleToggle lsp_definitions<cr>", desc = "TroubleToggle lsp_definitions" },


      -- FzfLua
      [",,"] = { "<cmd>FzfLua builtin<cr>", desc = "fzf builtin" },

      [",ff"] = { "<cmd>FzfLua files<cr>", desc = "fzf files" },
      [",fF"] = { "<cmd>FzfLua git_files<cr>", desc = "fzf git_files" },
      [",fb"] = { "<cmd>FzfLua buffers<cr>", desc = "fzf buffers" },
      [",fh"] = { "<cmd>FzfLua help_tags<cr>", desc = "fzf help_tags" },
      [",fm"] = { "<cmd>FzfLua marks<cr>", desc = "fzf marks" },
      [",fo"] = { "<cmd>FzfLua oldfiles<cr>", desc = "fzf oldfiles" },
      [",fc"] = { "<cmd>FzfLua grep_cword<cr>", desc = "fzf grep_cword" },
      [",fC"] = { "<cmd>FzfLua grep_cWORD<cr>", desc = "fzf grep_cWORD" },

      [",sm"] = { "<cmd>FzfLua man_pages<cr>", desc = "fzf man_pages" },
      [",sk"] = { "<cmd>FzfLua keymaps<cr>", desc = "fzf keymaps" },
      [",sc"] = { "<cmd>FzfLua commands<cr>", desc = "fzf commands" },

      [",li"] = { "<cmd>LspInfo<cr>", desc = "lsp info" },
      [",ls"] = { "<cmd>FzfLua lsp_document_symbols<cr>", desc = "fzf lsp_document_symbols" },
      [",lS"] = { "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "fzf lsp_workspace_symbols" },
      [",ld"] = { "<cmd>FzfLua diagnostics_document<cr>", desc = "fzf diagnostics_document" },
      [",lD"] = { "<cmd>FzfLua diagnostics_workspace<cr>", desc = "fzf diagnostics_workspace" },
      [",lr"] = { "<cmd>FzfLua lsp_references<cr>", desc = "fzf lsp_references" },
    },
    t = {
      -- setting a mapping to false will disable it
      -- ["<esc>"] = false,
    },
  },

  -- This function is run last
  -- good place to configuring augroups/autocommands and custom filetypes
  polish = function()
    -- Set key binding
    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = "plugins.lua",
      command = "source <afile> | PackerSync",
    })
  end,
}

return config
