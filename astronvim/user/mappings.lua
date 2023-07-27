-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {

    -- Grep
    ["<leader>,"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "grep in buffer" },
    -- ["<leader>."] = { "<cmd>lua require'telescope.builtin'.live_grep{ search_dirs={vim.fn.getcwd()} }<cr>", desc = "grep in dir" },
    -- ["<leader>/"] = { "<cmd>lua require'telescope.builtin'.live_grep{ search_dirs={get_git_path()} }<cr>", desc = "grep in git dir" },
    ["<leader>."] = { "<cmd>lua require'telescope.builtin'.live_grep{ cwd=vim.fn.getcwd() }<cr>", desc = "grep in dir" },
    ["<leader>/"] = { "<cmd>lua require'telescope.builtin'.live_grep{ cwd=get_git_path() }<cr>", desc = "grep in git dir" },

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

    -- project
    ["<leader>fp"] = { "<cmd>Telescope project<cr>", desc = "project" },

    -- vim
    ["<leader>h"] = { "<cmd>Telescope help_tags<cr>", desc = "help_tags" },
    ["<leader>c"] = { "<cmd>Telescope commands<cr>", desc = "command" },
    ["<leader>C"] = { "<cmd>Telescope command_history<cr>", desc = "command_history" },
    ["<leader>k"] = { "<cmd>Telescope keymaps<cr>", desc = "keymaps" },
    ["<leader>m"] = { "<cmd>Telescope marks<cr>", desc = "marks" },
    ["<leader>vo"] = { "<cmd>Telescope vim_options<cr>", desc = "vim options" },
    ["<leader>vr"] = { "<cmd>Telescope registers<cr>", desc = "registers" },
    ["<leader>vh"] = { "<cmd>Telescope highlights<cr>", desc = "highlights" },
    ["<leader>va"] = { "<cmd>Telescope autocommands<cr>", desc = "autocommands" },
    ["<leader>vc"] = { "<cmd>Telescope colorscheme<cr>", desc = "autocommands" },

    -- control
    ["<leader>r"] = { "<cmd>Telescope resume<cr>", desc = "resume" },
    ["<leader>b"] = { "<cmd>Telescope builtin<cr>", desc = "builtin" },


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

    -- UI
    [",ta"] = { "<cmd>AerialToggle<cr>", desc = "AerialToggle" },
    [",tt"] = { "<cmd>Neotree toggle<cr>", desc = "Neotree toggle" },


    -- FzfLua
    -- [",,"] = { "<cmd>FzfLua builtin<cr>", desc = "fzf builtin" },
    --
    -- [",ff"] = { "<cmd>FzfLua files<cr>", desc = "fzf files" },
    -- [",fF"] = { "<cmd>FzfLua git_files<cr>", desc = "fzf git_files" },
    -- [",fb"] = { "<cmd>FzfLua buffers<cr>", desc = "fzf buffers" },
    -- [",fh"] = { "<cmd>FzfLua help_tags<cr>", desc = "fzf help_tags" },
    -- [",fm"] = { "<cmd>FzfLua marks<cr>", desc = "fzf marks" },
    -- [",fo"] = { "<cmd>FzfLua oldfiles<cr>", desc = "fzf oldfiles" },
    -- [",fc"] = { "<cmd>FzfLua grep_cword<cr>", desc = "fzf grep_cword" },
    -- [",fC"] = { "<cmd>FzfLua grep_cWORD<cr>", desc = "fzf grep_cWORD" },
    --
    -- [",sm"] = { "<cmd>FzfLua man_pages<cr>", desc = "fzf man_pages" },
    -- [",sk"] = { "<cmd>FzfLua keymaps<cr>", desc = "fzf keymaps" },
    -- [",sc"] = { "<cmd>FzfLua commands<cr>", desc = "fzf commands" },
    --
    -- [",li"] = { "<cmd>LspInfo<cr>", desc = "lsp info" },
    -- [",ls"] = { "<cmd>FzfLua lsp_document_symbols<cr>", desc = "fzf lsp_document_symbols" },
    -- [",lS"] = { "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "fzf lsp_workspace_symbols" },
    -- [",ld"] = { "<cmd>FzfLua diagnostics_document<cr>", desc = "fzf diagnostics_document" },
    -- [",lD"] = { "<cmd>FzfLua diagnostics_workspace<cr>", desc = "fzf diagnostics_workspace" },
    -- [",lr"] = { "<cmd>FzfLua lsp_references<cr>", desc = "fzf lsp_references" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
