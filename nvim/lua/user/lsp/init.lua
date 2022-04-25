local M = {}
local lsp_installer = require "nvim-lsp-installer"


function M.on_attach(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('v', '<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)

    buf_set_keymap('n', '<leader>ls', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
    buf_set_keymap('n', '<leader>ws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
    -- vim.lsp.buf.document_symbol()
    -- vim.lsp.buf.workspace_symbol()

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end

    require 'lsp_signature'.on_attach()
    require 'illuminate'.on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

local enhance_server_opts = {
  -- Provide settings that should only apply to the "eslint" server
  ["sumneko_lua"] = function(opts)
    opts.settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true)
        }
      },
    }
  end,
  ["pyright"] = function(opts)
    opts.settings = {
      python = {
        analysis = {
          autoImportCompletions = false
        }
      }
    }
  end
}

M.servers = { 'pyright', 'rust_analyzer', 'tsserver', 'bashls', 'vimls', 'cssls', 'html', 'sumneko_lua' }
function M.setup()
    for _, name in pairs(M.servers) do
        local server_is_found, server = lsp_installer.get_server(name)
        if server_is_found and not server:is_installed() then
            server:install()
        end
    end
    lsp_installer.on_server_ready(function(server)
        local opts = {
            on_attach = M.on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            }
        }

        if enhance_server_opts[server.name] then
          -- Enhance the default opts with the server-specific ones
          enhance_server_opts[server.name](opts)
        end
        server:setup(opts)
    end)
end

return M
