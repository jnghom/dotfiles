return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
     local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    --config.sources = {
    --  -- Set a formatter
    --  -- null_ls.builtins.formatting.stylua,
    --  -- null_ls.builtins.formatting.prettier,
    --}
    config.sources = {
      null_ls.builtins.diagnostics.pylint.with {
        extra_args = {
          "--disable="
                  .. "import-error,no-name-in-module,logging-fstring-interpolation,"
                  .. "too-few-public-methods,"
                  .. "too-many-arguments",
        },
      },
      --null_ls.builtins.diagnostics.flake8.with {
      --  extra_args = {
      --    "--ignore=E203,E402",
      --    "--max-line-length",
      --    "100",
      --  },
      --},
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
    return config -- return final config table
  end,
}
