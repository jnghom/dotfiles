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
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{
        disable_filetype = { "TelescopePrompt" , "vim" }
      }
    end
  }
  use 'ntpeters/vim-better-whitespace'
  use 'nathanaelkane/vim-indent-guides'
  use 'tpope/vim-fugitive'
  use 'junegunn/vim-peekaboo'
  use {'scrooloose/nerdtree', opt = true, cmd = 'NERDTreeToggle' }
  -- make it easier to know the available key bindings
  use {
    'liuchengxu/vim-which-key', cmd = 'WhichKey',
    config = function()
      vim.cmd([[
        nnoremap <silent> <leader>      :<c-u>WhichKey '<leader>'<CR>
        vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<leader>'<CR>
      ]])
    end
  }
  -- nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
  use {'farmergreg/vim-lastplace'}

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
    config = function()
      require('lualine').setup {
        options = {
          theme = 'tokyonight'
        }
      }
    end
  }

  -- Simple plugins can be specified as strings
  -- use '9mm/vim-closer'
  use 'NLKNguyen/papercolor-theme'
  -- vim.g.colors_name = 'PaperColor'
  use 'folke/tokyonight.nvim'
  vim.g.colors_name = 'tokyonight'
  vim.g.tokyonight_style = "day" -- storm, night, day

  -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes
  -- shaunsingh/seoul256.nvim

  -- Lazy loading:
  -- Load on specific commands
  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
  use 'justinmk/vim-sneak'

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

  use {
    'neovim/nvim-lspconfig',
    config = function()
      -- require'lspconfig'.pyright.setup{}
      local nvim_lsp = require('lspconfig')

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        --Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap=true, silent=true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
        -- vim.lsp.buf.document_symbol()
        -- vim.lsp.buf.workspace_symbol()

        -- Set some keybinds conditional on server capabilities
        if client.resolved_capabilities.document_formatting then
            buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        elseif client.resolved_capabilities.document_range_formatting then
            buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        end

        -- Set autocommands conditional on server_capabilities
        if client.resolved_capabilities.document_highlight then
            -- require('lspconfig').util.nvim_multiline_command [[
            -- :hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
            -- :hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
            -- :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
            --
            -- :hi default LspReferenceRead cterm=bold gui=Bold ctermbg=yellow guifg=yellow guibg=purple4 |
            -- :hi default LspReferenceText cterm=bold gui=Bold ctermbg=red guifg=SlateBlue guibg=MidnightBlue |
            -- :hi default LspReferenceWrite cterm=bold gui=Bold,Italic ctermbg=red guifg=DarkSlateBlue guibg=MistyRose
            vim.cmd [[
            augroup lsp_document_highlight
                autocmd!
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
            ]]
        end


        require 'lsp_signature'.on_attach()
        require 'illuminate'.on_attach(client)

      end

      -- Use a loop to conveniently call 'setup' on multiple servers and
      -- map buffer local keybindings when the language server attaches
      local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'bashls', 'vimls' }
      -- pyright : npm i -g pyright
      -- bashls  : npm i -g bash-language-server
      -- vimls   : npm install -g vim-language-server
      -- yamlls  : yarn global add yaml-language-server
      for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup {
          on_attach = on_attach,
          flags = {
            debounce_text_changes = 150,
          }
        }
      end
    end
  }

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
  use {
    'glepnir/lspsaga.nvim',
    config = function ()
      local saga = require 'lspsaga'
      saga.init_lsp_saga()
      -- nnoremap <silent> gh :Lspsaga lsp_finder<CR>
      -- nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
      -- vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
      -- nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
      vim.cmd [[
      nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
      nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
      ]]
    end
  }

  use {
    'hrsh7th/vim-vsnip',
    -- https://marketplace.visualstudio.com/search?term=snippets&target=VSCode&category=All%20categories&sortBy=Relevance
    requires = {
      'hrsh7th/vim-vsnip-integ',
      'ylcnfrht/vscode-python-snippet-pack'
    },
    config = function ()
      vim.cmd([[
      " NOTE: You can use other key to expand snippet.

      " Expand
      imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
      smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

      " Expand or jump
      imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
      smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

      " Jump forward or backward
      " imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
      " smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
      " imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
      " smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

      " Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
      " See https://github.com/hrsh7th/vim-vsnip/pull/50
      nmap        s   <Plug>(vsnip-select-text)
      xmap        s   <Plug>(vsnip-select-text)
      nmap        S   <Plug>(vsnip-cut-text)
      xmap        S   <Plug>(vsnip-cut-text)

      " If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
      let g:vsnip_filetypes = {}
      let g:vsnip_filetypes.javascriptreact = ['javascript']
      let g:vsnip_filetypes.typescriptreact = ['typescript']

      ]])
    end
  }
  use { 'cstrap/python-snippets' }

  use {
    'hrsh7th/nvim-compe',
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
      local t = function(str)
	      return vim.api.nvim_replace_termcodes(str, true, true, true)
      end

      local check_back_space = function()
	      local col = vim.fn.col('.') - 1
	      return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      -- Use (s-)tab to:
      --- move to prev/next item in completion menuone
      --- jump to prev/next snippet's placeholder
      _G.tab_complete = function()
	      if vim.fn.pumvisible() == 1 then
		      return t "<C-n>"
	      elseif vim.fn['vsnip#available'](1) == 1 then
		      return t "<Plug>(vsnip-expand-or-jump)"
	      elseif check_back_space() then
		      return t "<Tab>"
	      else
		      return vim.fn['compe#complete']()
	      end
      end
      _G.s_tab_complete = function()
	      if vim.fn.pumvisible() == 1 then
		      return t "<C-p>"
	      elseif vim.fn['vsnip#jumpable'](-1) == 1 then
		      return t "<Plug>(vsnip-jump-prev)"
	      else
		      -- If <S-Tab> is not working in your terminal, change it to <C-h>
		      return t "<S-Tab>"
	      end
      end

      vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
      vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
      vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
      vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
      vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
      vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      vim.cmd [[
      " Find files using Telescope command-line sugar.
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader>fb <cmd>Telescope buffers<cr>
      nnoremap <leader>fh <cmd>Telescope help_tags<cr>

      " Using Lua functions
      nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
      nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
      nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
      nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
      ]]
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",
        highlight = {
          enable = true
      }
    }
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
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

              -- Or you can define your own textobjects like this
              ["iF"] = {
                python = "(function_definition) @function",
                cpp = "(function_definition) @function",
                c = "(function_definition) @function",
                java = "(method_declaration) @function",
              },
            },
          },
        },
      }
    end
  }

  use {'junegunn/fzf'}

  use {
    'junegunn/fzf.vim',
    config = function()
      vim.api.nvim_exec(
      [[

      " nnoremap <silent> <expr> <space><space> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
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
      " nnoremap <silent> <space>/       :execute 'Rg ' . input('Rg/')<CR>
      nnoremap <silent> <space>//      :execute 'GGrep ' . input('GGrep/')<CR>
      nnoremap <silent> **             :call SearchWordWithRgW()<CR>
      vnoremap <silent> **             :call SearchVisualSelectionWithRg()<CR>
      nnoremap <silent> <space>C       :Commits<CR>
      nnoremap <silent> <space>c       :BCommits<CR>
      nnoremap <silent> <space>m       :FZFMru<CR>
      nnoremap <silent> <space>M       :Marks<CR>
      nnoremap <silent> <space>?       :Helptags<CR>
      "nnoremap <silent> <space>ft :Filetypes<CR>

      " Mapping selecting mappings
      nmap <leader><tab> <plug>(fzf-maps-n)
      xmap <leader><tab> <plug>(fzf-maps-x)
      omap <leader><tab> <plug>(fzf-maps-o)

      " Insert mode completion
      imap <c-x><c-k> <plug>(fzf-complete-word)
      imap <c-x><c-f> <plug>(fzf-complete-path)
      imap <c-x><c-l> <plug>(fzf-complete-line)

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

  -- github
  -- use 'pwntester/octo.nvim'
  --
  -- A File Explorer For Neovim Written In Lua
  -- kyazdani42/nvim-tree.lua
  --
  -- A lua fork of vim-devicons. This plugin provides the same icons as well as colors for each icon.
  -- kyazdani42/nvim-web-devicons

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
  --
  -- ojroques/vim-oscyank
  -- copy text to the system clipboard from anywhere using the ANSI OSC52 sequence.
  --
  -- jump list
  -- bookmark
end)

