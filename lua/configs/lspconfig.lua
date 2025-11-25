-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "ts_ls", "glsl_analyzer" }
vim.lsp.enable(servers)

vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "off",
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },

  }
})
vim.lsp.enable "basedpyright"

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      checkThirdParty = false,
      telemetry = { enable = false },
      runtime = {
        path = {
          '?.lua',
          '?/init.lua',
          -- 'lua/?.lua',
          -- 'lua/?/init.lua',
          -- '?/lua/?.lua',
          -- '?/lua/?/init.lua',
        }
      },
      workspace = {
        library = {
          -- vim.fn.stdpath "data" .. "/lazy/NvChad/lua/nvchad",
          vim.env.VIMRUNTIME,
          vim.fn.expand '~/luarocks/share/lua/5.4',
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          'C:/Users/tinnguyen/AppData/Local/nvim-data/mason/packages/lua-language-server/meta/3rd/busted/library/',
          'C:/Users/tinnguyen/AppData/Local/nvim-data/mason/packages/lua-language-server/meta/3rd/luassert/library/'
        },
      },
    },
  },
})
vim.lsp.enable "lua_ls"

-- clangd
vim.lsp.config("clangd", {
  filetypes = { "c" }, -- Only enable for C files
  cmd = {
    "clangd",
    "--header-insertion=never",
  },
})
