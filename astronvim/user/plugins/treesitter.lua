return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
     auto_install = true,
     ensure_installed = {
       "lua", "vim", "help",
       "python",
       "html", "css", "javascript", "typescript",
       "yaml", "json"
     },
  },
}
