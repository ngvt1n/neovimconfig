require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "ts_ls", "glsl_analyzer", "angularls" }
vim.lsp.enable(servers)

vim.lsp.config("cssls", {
  settings = {
    css = {
      lint = {
        validProperties = { "composes" },
        unknownAtRules = "ignore"
      },
    }
  }
})
vim.lsp.enable("cssls")

vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "off",
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        -- useLibraryCodeForTypes = true,
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
vim.lsp.config("emmylua_ls", {
  settings = {
    -- ["$schema"] = "https://raw.githubusercontent.com/EmmyLuaLs/emmylua-analyzer-rust/refs/heads/main/crates/emmylua_code_analysis/resources/schema.json",
    -- signature = {
    --     detailSignatureHelper = true
    -- },
    -- hover = { enable = true },
    -- diagnostics = {
    --   enable = true,
    --   enables = {"syntax-error", "param-type-not-match"},
    -- },
    -- runtime = {
    --   requirePattern = {
    --     '?.lua',
    --     '?/init.lua',
    --     -- 'lua/?.lua',
    --     -- 'lua/?/init.lua',
    --     -- '?/lua/?.lua',
    --     -- '?/lua/?/init.lua',
    --   },
    --   extensions = {".lua", ".lua.txt"}
    -- },
    -- workspace = {
    --   library = {
    --     -- vim.fn.stdpath "data" .. "/lazy/NvChad/lua/nvchad",
    --     vim.env.VIMRUNTIME,
    --     vim.fn.expand '~/luarocks/share/lua/5.4',
    --     vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
    --     'C:/Users/tinnguyen/AppData/Local/nvim-data/mason/packages/lua-language-server/meta/3rd/busted/library/',
    --     'C:/Users/tinnguyen/AppData/Local/nvim-data/mason/packages/lua-language-server/meta/3rd/luassert/library/'
    --   },
    -- },
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
