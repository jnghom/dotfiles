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
      tokyonight_style = "storm"
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
      -- ["goolord/alpha-nvim"] = { disable = true },
      ["declancm/cinnamon.nvim"] = { disable = true },

      -- You can also add new plugins here as well:
      -- { "andweeb/presence.nvim" },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },
      {
        "folke/tokyonight.nvim",
        as = "tokyonight",
        config = function() 
          vim.cmd [[
          hi LspReferenceRead cterm=bold ctermbg=red guibg=DarkSlateBlue
          hi LspReferenceText cterm=bold ctermbg=red guibg=#823838
          hi LspReferenceWrite cterm=bold ctermbg=red guibg=MediumPurple3
          ]]
        end
      },

      {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
          require("lsp_signature").setup()
        end,
      },

      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        requires = {'nvim-treesitter/nvim-treesitter'},
        config = function()
          require'nvim-treesitter.configs'.setup {
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
        end
      },
      { "farmergreg/vim-lastplace" },
      { "christoomey/vim-tmux-navigator" },
      {
        "ibhagwan/fzf-lua",
        requires = { 'kyazdani42/nvim-web-devicons' },
        -- config = function()
        --   vim.api.nvim_exec(
        --   [[
        --   nnoremap <silent> <c-p> :FzfLua files<CR>
        --   nnoremap <silent> ,g       :FzfLua git_files<CR>
        --
        --   nnoremap <silent> <space><space> :FzfLua builtin<CR>
        --   nnoremap <silent> ,b       :FzfLua blines<CR>
        --   nnoremap <silent> ,m       :FzfLua marks<CR>
        --
        --   nnoremap <silent> ,/       :FzfLua grep_project<CR>
        --   nnoremap <silent> ,w       :FzfLua grep_cword<CR>
        --
        --   nnoremap <silent> ,c       :FzfLua commands<CR>
        --
        --   nnoremap <silent> ,j       :FzfLua jumps<CR>
        --   nnoremap <silent> ,hf      :FzfLua oldfiles<CR>
        --   nnoremap <silent> ,hc      :FzfLua command_history<CR>
        --   nnoremap <silent> ,hs      :FzfLua search_history<CR>
        --   ]],
        --   true)
        -- end
      }

    },

    -- All other entries override the setup() call for default plugins
    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- null_ls.builtins.diagnostics.pylint,
        -- null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.formatting.autopep8,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.code_actions.refactoring,

        null_ls.builtins.formatting.json_tool,

        null_ls.builtins.formatting.lua_format,

        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.diagnostics.eslint,

        null_ls.builtins.code_actions.shellcheck,
        -- Set a formatter
        null_ls.builtins.formatting.rufo,
        -- Set a linter
        null_ls.builtins.diagnostics.rubocop,
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
    },

    ["nvim-lsp-installer"] = {
      ensure_installed = { "sumneko_lua" },
    },
    packer = {
      compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua",
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

  -- Modify which-key registration
  ["which-key"] = {
    -- Add bindings
    register_mappings = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        -- ["<leader>"] = {
        ["]"] = {
          ["h"] = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
        },
        ["["] = {
          ["h"] = { "<cmd>Gitsigns prev_hunk<cr>", "Prev Hunk" },
        },
        [","] = {
          [","] = { "<cmd>FzfLua builtin<cr>",      "fzf builtin" },
          ["g"] = {
          },
          ["f"] = {
            ["f"] = { "<cmd>FzfLua files<cr>",    "fzf files" },
            ["F"] = { "<cmd>FzfLua git_files<cr>",    "fzf git_files" },
            ["b"] = { "<cmd>FzfLua buffers<cr>",      "fzf buffers" },
            ["h"] = { "<cmd>FzfLua help_tags<cr>",      "fzf help_tags" },
            ["m"] = { "<cmd>FzfLua marks<cr>",      "fzf marks" },
            ["o"] = { "<cmd>FzfLua oldfiles<cr>",      "fzf oldfiles" },
            ["c"] = { "<cmd>FzfLua grep_cword<cr>",      "fzf grep_cword" },
            ["C"] = { "<cmd>FzfLua grep_cWORD<cr>",      "fzf grep_cWORD" },
          },
          ["s"] = {
            ["m"] = { "<cmd>FzfLua man_pages<cr>",      "fzf man_pages" },
            ["k"] = { "<cmd>FzfLua keymaps<cr>",      "fzf keymaps" },
            ["c"] = { "<cmd>FzfLua commands<cr>",      "fzf commands" },
          },
          ["l"] = {
            ["i"] = { "<cmd>LspInfo<cr>",      "lsp info" },
            ["s"] = { "<cmd>FzfLua lsp_document_symbols<cr>",      "fzf lsp_document_symbols" },
            ["S"] = { "<cmd>FzfLua lsp_workspace_symbols<cr>",      "fzf lsp_workspace_symbols" },
            ["d"] = { "<cmd>FzfLua diagnostics_document<cr>",      "fzf diagnostics_document" },
            ["D"] = { "<cmd>FzfLua diagnostics_workspace<cr>",      "fzf diagnostics_workspace" },
          }
        }
      },
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without lsp-installer
    servers = {
      -- "pyright"
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the server on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the lsp installer server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = {
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  mappings = {
    -- first key is the mode
    n = {
      -- second key is the lefthand side of the map
      ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
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

    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}

return config
