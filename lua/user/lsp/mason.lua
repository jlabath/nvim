local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

local servers = {
  --"codelldb", -- Dap server for rust
  "cssls",
  "cssmodules_ls",
  "emmet_ls",
  "html",
  "jsonls",
  "sumneko_lua",
  "terraformls",
  "tsserver",
  "yamlls",
  "bashls",
  "rust_analyzer",
  "taplo",
  "solargraph",
  "bashls",
  "elmls",
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})


local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  if server == "jsonls" then
    --    local jsonls_opts = require "user.lsp.settings.jsonls"
    --opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "yamlls" then
    --local yamlls_opts = require "user.lsp.settings.yamlls"
    --opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
  end

  if server == "sumneko_lua" then
    --local l_status_ok, lua_dev = pcall(require, "neodev")
    --if not l_status_ok then
    --  return
    --end
    -- local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    -- opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    -- opts = vim.tbl_deep_extend("force", require("lua-dev").setup(), opts)
    -- local luadev = lua_dev.setup {
    --   --   -- add any options here, or leave empty to use the default settings
    --   -- lspconfig = opts,
    --   lspconfig = {
    --     on_attach = opts.on_attach,
    --     capabilities = opts.capabilities,
    --     --   -- settings = opts.settings,
    --   },
    -- }
    -- lspconfig.sumneko_lua.setup(luadev)
    lspconfig.sumneko_lua.setup({
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace"
          }
        }
      }
    })
    goto continue
  end

  if server == "rust_analyzer" then
    local rust_opts = require "user.lsp.settings.rust"
    -- opts = vim.tbl_deep_extend("force", rust_opts, opts)
    local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
    if not rust_tools_status_ok then
      return
    end

    rust_tools.setup(rust_opts)
    goto continue
  end

  if server == "codelldb" then
    goto continue
  end

  lspconfig[server].setup(opts)
  ::continue::
end
