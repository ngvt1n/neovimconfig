-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "ts_ls", "pyright", "glsl_analyzer" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig["lua_ls"].setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    Lua = {
      checkThirdParty = false,
      telemetry = { enable = false },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          "C:/Users/tinnguyen/Documents/notes/sketches/love2d/3rd/love2d/library",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}
-- clangd
lspconfig["clangd"].setup {
  filetypes = { "c" },   -- Only enable for C files
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  cmd = {
    "clangd",
    "--header-insertion=never",
  },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = false,
      },
    },
    offsetEncoding = { "utf-16" },
  },
}
