return {
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
}