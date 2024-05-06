-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  { import = "astrocommunity.colorscheme.catppuccin" },

  { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.git.octo-nvim" },
  { import = "astrocommunity.git.neogit" },

  { import = "astrocommunity.diagnostics.trouble-nvim" },

  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.helm" },
  -- import/override with your plugins folder
}
