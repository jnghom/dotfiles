return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    }
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
  -- {
  --   "folke/trouble.nvim",
  --   branch = "dev", -- IMPORTANT!
  --   keys = {
  --     {
  --       "<leader>xx",
  --       "<cmd>Trouble diagnostics toggle<cr>",
  --       desc = "Diagnostics (Trouble)",
  --     },
  --     {
  --       "<leader>xX",
  --       "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  --       desc = "Buffer Diagnostics (Trouble)",
  --     },
  --     {
  --       "<leader>cs",
  --       "<cmd>Trouble symbols toggle focus=false<cr>",
  --       desc = "Symbols (Trouble)",
  --     },
  --     {
  --       "<leader>cl",
  --       "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  --       desc = "LSP Definitions / references / ... (Trouble)",
  --     },
  --     {
  --       "<leader>xL",
  --       "<cmd>Trouble loclist toggle<cr>",
  --       desc = "Location List (Trouble)",
  --     },
  --     {
  --       "<leader>xQ",
  --       "<cmd>Trouble qflist toggle<cr>",
  --       desc = "Quickfix List (Trouble)",
  --     },
  --   },
  --   opts = {}, -- for default options, refer to the configuration section for custom setup.
  -- },
}
