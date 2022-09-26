local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'


if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])


U = require('user')

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    "lazytanuki/nvim-mapper",
    disable = true,
    config = function() require("nvim-mapper").setup{} end,
    before = "telescope.nvim"
  }
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  -- use 'machakann/vim-sandwich'
  use 'christoomey/vim-tmux-navigator'
  -- use 'easymotion/vim-easymotion'
  use 'Raimondi/delimitMate'

  use 'ntpeters/vim-better-whitespace'
  use 'nathanaelkane/vim-indent-guides'
  use 'tpope/vim-fugitive'
  use 'junegunn/vim-peekaboo'
  -- use {'scrooloose/nerdtree', opt = true, cmd = 'NERDTreeToggle' }

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  }

  use {'farmergreg/vim-lastplace'}

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  use {
    'feline-nvim/feline.nvim',
    tag = 'v1.0.0',
    config = function()
      require('feline').setup()
    end
  }

  use {
    'folke/tokyonight.nvim',
    setup = function()
      -- vim.g.tokyonight_colors = { fg = '#cfd3e3' }
      vim.g.tokyonight_style = "storm" -- storm, night, day
    end,
        -- hi CursorLine    ctermbg=236 guibg=#444444 cterm=none gui=none
    config = function()
      vim.cmd('colorscheme tokyonight')
      if vim.g.tokyonight_style == "storm" then
        vim.cmd [[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=DarkSlateBlue
        hi LspReferenceText cterm=bold ctermbg=red guibg=#823838
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=MediumPurple3
        ]]
      end
    end
  }

  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
  -- use 'justinmk/vim-sneak'

  use {'ray-x/lsp_signature.nvim'}


  use {
    -- automatically highlighting other uses of the current word under the cursor
    'RRethy/vim-illuminate',
    config = function()
      vim.api.nvim_command [[ hi def link LspReferenceText CursorLine ]]
      vim.api.nvim_command [[ hi def link LspReferenceWrite CursorLine ]]
      vim.api.nvim_command [[ hi def link LspReferenceRead CursorLine ]]

      vim.api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
      vim.api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})

    end
  }
  -- use {
  --   'neovim/nvim-lspconfig'
  -- }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      {'RRethy/vim-illuminate'},
      {'ray-x/lsp_signature.nvim'}
    }
  }

  use {
    'williamboman/nvim-lsp-installer'
  }

  -- simrat39/symbols-outline.nvim
  -- :SymbolsOutline

  -- Debug Adapter Protocol client implementation for Neovim
  use 'mfussenegger/nvim-dap'
  -- use { 'cstrap/python-snippets' }
  use "rafamadriz/friendly-snippets"
  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  }
  use { 'saadparwaiz1/cmp_luasnip' }

  -- Install nvim-cmp, and buffer source as a dependency
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip" ,
      "hrsh7th/cmp-nvim-lua",
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      cmp.setup {

        -- You can set mappings if you want
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4, { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping.scroll_docs(4, { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          -- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" })
        },

        snippet = {
          expand = function(args)
            require'luasnip'.lsp_expand(args.body)
          end
        },

        -- You should specify your *installed* sources.
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'nvim_lua' },
          { name = 'path' },
          { name = 'luasnip' }
          -- { name = 'vsnip' },
        },
      }
    end
  }

  use {
    'junegunn/fzf.vim',
    disable = true,
    config = function()
      U.fuzzy.setup_fzf_vim()
    end
  }

  use {
    'ibhagwan/fzf-lua',
    disable = true,
    config = function()
      U.fuzzy.setup_fzf_lua()
    end,
    requires = { 'kyazdani42/nvim-web-devicons' }
  }


  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'}
    },
    config = function()
      U.fuzzy.setup_telescope()
    end,
    extensions = {
      fzf = {
        fuzzy = true
      }
    }
  }

  require('telescope').load_extension('fzf')
  -- nvim-telescope/telescope-frecency.nvim
  -- Using an implementation of Mozilla's Frecency algorithm (used in Firefox's address bar),
  -- files edited frecently are given higher precedence in the list index.

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {
          'python', 'bash', 'javascript', 'vim', 'yaml', 'json', 'lua', 'css', 'html',
          'clojure', 'dart', 'go', 'java', 'c_sharp', 'rust', 'typescript'
        },
        highlight = {
          enable = true
      }
    }
    end
  }

  use {
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
  }

  use {
    'junegunn/fzf',
    run = function()
      vim.fn['fzf#install']()
    end
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          -- null_ls.builtins.diagnostics.pylint,
          -- null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.formatting.autopep8,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.json_tool,
          null_ls.builtins.formatting.lua_format,
          null_ls.builtins.code_actions.eslint,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.diagnostics.eslint,
          -- null_ls.builtins.diagnostics.pydocstyle,
          null_ls.builtins.diagnostics.standardjs,
          null_ls.builtins.diagnostics.tidy,
          null_ls.builtins.diagnostics.yamllint
        }
      })
    end
  }
  -- A File Explorer For Neovim Written In Lua
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-tree').setup()
      vim.cmd [[
      nnoremap <F8> :NvimTreeToggle<CR>
      ]]
    end
  }

  -- Lua
  use {
    "ahmedkhalf/project.nvim",
    disable = true,
    require = {'nvim-telescope/telescope.nvim'},
    config = function()
      require("project_nvim").setup {
      }
      require('telescope').load_extension('projects')
    end
  }

  -- use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function()
      vim.cmd [[
      " Move to previous/next
      nnoremap <silent>    [b :BufferPrevious<CR>
      nnoremap <silent>    ]b :BufferNext<CR>
      " Re-order to previous/next
      nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
      nnoremap <silent>    <A->> :BufferMoveNext<CR>
      " Goto buffer in position...
      nnoremap <silent>    <A-1> :BufferGoto 1<CR>
      nnoremap <silent>    <A-2> :BufferGoto 2<CR>
      nnoremap <silent>    <A-3> :BufferGoto 3<CR>
      nnoremap <silent>    <A-4> :BufferGoto 4<CR>
      nnoremap <silent>    <A-5> :BufferGoto 5<CR>
      nnoremap <silent>    <A-6> :BufferGoto 6<CR>
      nnoremap <silent>    <A-7> :BufferGoto 7<CR>
      nnoremap <silent>    <A-8> :BufferGoto 8<CR>
      nnoremap <silent>    <A-9> :BufferLast<CR>
      ]]
    end
  }

  -- quickfix window better
  use {'kevinhwang91/nvim-bqf'}
  -- better glance at matched information, seamlessly jump between matched instances
  use {
    'kevinhwang91/nvim-hlslens',
    config = function()
      vim.api.nvim_set_keymap(
        "n",
        "n",
        "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "N",
        "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap("n", "*", "*<Cmd>lua require('hlslens').start()<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "#", "#<Cmd>lua require('hlslens').start()<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "g*", "g*<Cmd>lua require('hlslens').start()<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "g#", "g#<Cmd>lua require('hlslens').start()<CR>", { noremap = true })

      vim.api.nvim_set_keymap("n", "<leader>l", ":noh<CR>", { noremap = true, silent = true })
    end
  }

  use 'ggandor/lightspeed.nvim'

  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
end)


  -- use {
  --   'ray-x/navigator.lua',
  --   requires = {
  --     'ray-x/guihua.lua',
  --     run = 'cd lua/fzy && make'
  --   },
  --   config = function ()
  --     require'navigator'.setup({
  --       lsp_installer = true,
  --       lsp = {
  --         servers = {'pyright'}
  --       }
  --     })
  --   end
  -- }

  -- use {
  --   'phaazon/hop.nvim',
  --   branch = 'v1', -- optional but strongly recommended
  --   config = function()
  --     -- you can configure Hop the way you like here; see :h hop-config
  --     require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
  --     -- place this in one of your configuration file(s)
  --     vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", {})
  --     vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>", {})
  --     vim.api.nvim_set_keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, inclusive_jump = true })<cr>", {})
  --     vim.api.nvim_set_keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, inclusive_jump = true })<cr>", {})
  --     vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", {})
  --     vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>", {})
  --   end
  -- }

  -- mg979/vim-visual-multi

  -- need lua alternative
  -- magit
  --
  -- inline expression
  --
  -- strip trailing whitespace
  -- nerdtree
  -- expand object
  -- restore last position
  --
  -- ojroques/vim-oscyank
  -- copy text to the system clipboard from anywhere using the ANSI OSC52 sequence.
  --
  -- jump list
  -- bookmark
  -- ojroques/nvim-lspfuzzy

  -- github
  -- use 'pwntester/octo.nvim'
  -- sindrets/diffview.nvim
  -- kevinhwang91/nvim-bqf
  --
  -- use 'nvim-telescope/telescope-dap.nvim'
  -- use 'mfussenegger/nvim-dap-python'
  -- pip install debugpy
  --
  -- Debug Adapter Protocol client implementation for Neovim

  -- use { 'nvim-lua/completion-nvim' }

  -- glepnir/lspsaga.nvim
  -- use {
  --   'glepnir/lspsaga.nvim',
  --   config = function ()
  --     local saga = require 'lspsaga'
  --     saga.init_lsp_saga()
  --     -- nnoremap <silent> gh :Lspsaga lsp_finder<CR>
  --     -- nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
  --     -- vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
  --     -- nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
  --     vim.cmd [[
  --     nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
  --     nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
  --     ]]
  --   end
  -- }

  -- use {
  --   'hrsh7th/vim-vsnip',
  --   -- https://marketplace.visualstudio.com/search?term=snippets&target=VSCode&category=All%20categories&sortBy=Relevance
  --   requires = {
  --     'hrsh7th/vim-vsnip-integ',
  --     'ylcnfrht/vscode-python-snippet-pack'
  --   },
  --   config = function ()
  --     vim.cmd([[
  --     " NOTE: You can use other key to expand snippet.

  --     " Expand
  --     imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
  --     smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

  --     " Expand or jump
  --     imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
  --     smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

  --     " Jump forward or backward
  --     " imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
  --     " smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
  --     " imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
  --     " smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

  --     " Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
  --     " See https://github.com/hrsh7th/vim-vsnip/pull/50
  --     nmap        s   <Plug>(vsnip-select-text)
  --     xmap        s   <Plug>(vsnip-select-text)
  --     nmap        S   <Plug>(vsnip-cut-text)
  --     xmap        S   <Plug>(vsnip-cut-text)

  --     " If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
  --     let g:vsnip_filetypes = {}
  --     let g:vsnip_filetypes.javascriptreact = ['javascript']
  --     let g:vsnip_filetypes.typescriptreact = ['typescript']

  --     ]])
  --   end
  -- }
  -- use {
  --   'windwp/nvim-autopairs',
  --   config = function()
  --     require('nvim-autopairs').setup{
  --       disable_filetype = { "TelescopePrompt" , "vim" }
  --     }
  --   end
  -- }
