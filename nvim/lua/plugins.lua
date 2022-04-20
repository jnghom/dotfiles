local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function()
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
  -- use {
  --   'windwp/nvim-autopairs',
  --   config = function()
  --     require('nvim-autopairs').setup{
  --       disable_filetype = { "TelescopePrompt" , "vim" }
  --     }
  --   end
  -- }

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
    config = function()
      vim.cmd('colorscheme tokyonight')
      if vim.g.tokyonight_style == "storm" then
        vim.cmd [[
        hi CursorLine    ctermbg=236 guibg=#444444 cterm=none gui=none
        hi LspReferenceRead cterm=bold ctermbg=red guibg=DarkSlateBlue
        hi LspReferenceText cterm=bold ctermbg=red guibg=#823838
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=MediumPurple3
        ]]
      end
    end
  }

  -- use {
  --   "EdenEast/nightfox.nvim",
  --   config = function()
  --     vim.cmd('colorscheme nightfox')
  -- --   end
  -- }

  -- use {
  --   "ful1e5/onedark.nvim",
  --   config = function()
  --     vim.cmd('colorscheme onedark')
  --   end
  -- }

  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
  -- use 'justinmk/vim-sneak'

  use {'ray-x/lsp_signature.nvim'}


  use {
    'ray-x/navigator.lua',
    requires = {
      'ray-x/guihua.lua',
      run = 'cd lua/fzy && make'
    },
    config = function ()
      require'navigator'.setup()
    end
  }

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
  use {
    'neovim/nvim-lspconfig'
  }

  --use {
  --  'neovim/nvim-lspconfig',
  --  requires = {
  --    {'RRethy/vim-illuminate'},
  --    {'ray-x/lsp_signature.nvim'}
  --  },
  --  config = function()
  --    local nvim_lsp = require('lspconfig')

  --    -- Use an on_attach function to only map the following keys
  --    -- after the language server attaches to the current buffer
  --    local on_attach = function(client, bufnr)
  --      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  --      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --      --Enable completion triggered by <c-x><c-o>
  --      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  --      local opts = { noremap=true, silent=true }

  --      -- See `:help vim.lsp.*` for documentation on any of the below functions
  --      buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --      buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --      buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --      buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --      buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --      buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --      buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --      buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --      buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --      buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
  --      buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  --      buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  --      buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  --      buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  --      buf_set_keymap('n', '<leader>ls', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  --      buf_set_keymap('n', '<leader>ws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
  --      -- vim.lsp.buf.document_symbol()
  --      -- vim.lsp.buf.workspace_symbol()

  --      -- Set some keybinds conditional on server capabilities
  --      if client.resolved_capabilities.document_formatting then
  --          buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  --      elseif client.resolved_capabilities.document_range_formatting then
  --          buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  --      end

  --      require 'lsp_signature'.on_attach()
  --      require 'illuminate'.on_attach(client)
  --    end

  --    local capabilities = vim.lsp.protocol.make_client_capabilities()
  --    capabilities.textDocument.completion.completionItem.snippetSupport = true
  --    capabilities.textDocument.completion.completionItem.resolveSupport = {
  --      properties = {
  --        'documentation',
  --        'detail',
  --        'additionalTextEdits',
  --      }
  --    }

  --    local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'bashls', 'vimls', 'cssls', 'html' }
  --    -- pyright : npm i -g pyright
  --    -- bashls  : npm i -g bash-language-server
  --    -- vimls   : npm install -g vim-language-server
  --    -- yamlls  : yarn global add yaml-language-server
  --    for _, lsp in ipairs(servers) do
  --      nvim_lsp[lsp].setup {
  --        on_attach = on_attach,
  --        capabilities = capabilities,
  --        flags = {
  --          debounce_text_changes = 150,
  --        }
  --      }
  --    end
  --  end
  --}

  -- simrat39/symbols-outline.nvim
  -- :SymbolsOutline

  -- Debug Adapter Protocol client implementation for Neovim
  use 'mfussenegger/nvim-dap'
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
  -- use { 'cstrap/python-snippets' }

  -- Install nvim-cmp, and buffer source as a dependency
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      -- "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-nvim-lua"
    },
    config = function()
      local cmp = require('cmp')
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
          ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
        },

        -- You should specify your *installed* sources.
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'nvim_lua' },
          { name = 'path' },
          -- { name = 'vsnip' },
        },
      }
    end
  }

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'}
    },
    config = function()
      vim.cmd [[
      " Find files using Telescope command-line sugar.
      nnoremap <leader>ff  <cmd>Telescope find_files<cr>
      nnoremap <leader>fg  <cmd>Telescope live_grep<cr>
      nnoremap <leader>fb  <cmd>Telescope buffers<cr>
      nnoremap <leader>fh  <cmd>Telescope help_tags<cr>
      nnoremap <leader>fds <cmd>Telescope lsp_document_symbols<cr>
      nnoremap <leader>fws <cmd>Telescope lsp_document_symbols<cr>
      nnoremap <leader>fca <cmd>Telescope lsp_code_actions<cr>
      nnoremap <leader>fdi <cmd>Telescope diagnostics<cr>
      ]]
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
    'junegunn/fzf.vim',
    disable = true,
    config = function()
      vim.api.nvim_exec(
      [[
      nnoremap <silent> <space><space> :Files<CR>
      nnoremap <silent> <space>g       :GFiles<CR>
      nnoremap <silent> <space>a       :Buffers<CR>
      nnoremap <silent> <space>A       :Windows<CR>
      nnoremap <silent> <space>;       :Lines<CR>
      nnoremap <silent> <space>.       :BLines<CR>
      nnoremap <silent> <space>T       :Tags<CR>
      nnoremap <silent> <space>t       :BTags<CR>
      nnoremap <silent> <space>h       :History<CR>
      nnoremap <silent> <space>h/      :History/<CR>
      nnoremap <silent> <space>h:      :History:<CR>
      nnoremap <silent> <space>/       :Rg<CR>
      nnoremap <silent> <space>//      :execute 'GGrep ' . input('GGrep/')<CR>
      nnoremap <silent> **             :call SearchWordWithRgW()<CR>
      vnoremap <silent> **             :call SearchVisualSelectionWithRg()<CR>
      nnoremap <silent> <space>C       :Commits<CR>
      nnoremap <silent> <space>c       :BCommits<CR>
      nnoremap <silent> <space>m       :FZFMru<CR>
      nnoremap <silent> <space>M       :Marks<CR>
      nnoremap <silent> <space>?       :Helptags<CR>

      " Mapping selecting mappings
      nmap <leader><tab> <plug>(fzf-maps-n)
      xmap <leader><tab> <plug>(fzf-maps-x)
      omap <leader><tab> <plug>(fzf-maps-o)

      " Insert mode completion
      imap <c-x><c-k> <plug>(fzf-complete-word)
      imap <c-x><c-f> <plug>(fzf-complete-path)
      imap <c-x><c-l> <plug>(fzf-complete-line)

      command! -bang -nargs=* GGrep call fzf#vim#grep( 'git grep --line-number -- '.shellescape(<q-args>), 0, fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
      command! -bang -nargs=* Rgw call fzf#vim#grep( 'rg -w --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1, <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

      function! SearchWordWithRgW()
        execute 'Rgw' expand('<cword>')
      endfunction

      function! SearchVisualSelectionWithRg() range
        let old_reg = getreg('"')
        let old_regtype = getregtype('"')
        let old_clipboard = &clipboard
        set clipboard&
        normal! ""gvy
        let selection = getreg('"')
        call setreg('"', old_reg, old_regtype)
        let &clipboard = old_clipboard
        execute 'Rg' selection
      endfunction

      ]],
      true)
    end
  }

  use {
    'ibhagwan/fzf-lua',
    config = function()
      vim.api.nvim_exec(
      [[
      nnoremap <silent> <c-p> :FzfLua files<CR>
      nnoremap <silent> <space>g       :FzfLua git_files<CR>

      nnoremap <silent> <space><space> :FzfLua builtin<CR>
      nnoremap <silent> <space>b       :FzfLua buffers<CR>
      nnoremap <silent> <space>.       :FzfLua blines<CR>
      nnoremap <silent> <space>m       :FzfLua marks<CR>

      nnoremap <silent> <space>/       :FzfLua grep_project<CR>
      nnoremap <silent> <space>w       :FzfLua grep_cword<CR>

      nnoremap <silent> <space>c       :FzfLua commands<CR>

      nnoremap <silent> <space>j       :FzfLua jumps<CR>
      nnoremap <silent> <space>hf      :FzfLua oldfiles<CR>
      nnoremap <silent> <space>hc      :FzfLua command_history<CR>
      nnoremap <silent> <space>hs      :FzfLua search_history<CR>
      ]],
      true)
    end,
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- ojroques/nvim-lspfuzzy

  -- github
  -- use 'pwntester/octo.nvim'
  -- sindrets/diffview.nvim
  -- kevinhwang91/nvim-bqf
  --
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
end)


