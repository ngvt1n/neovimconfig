local projects = "~/Documents/Code/Projects/nvim-projects/"
local overrides = require "configs.overrides"
return {
  -- { "michaeljsmith/vim-indent-object", lazy = false },
  { -- when specifying local dependencies, set both name and dev?
    "nvim-lua/plenary.nvim",
    -- name = 'plenary.nvim',
    dev = true,
  },
  {
    "kylechui/nvim-surround",
    version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
  },
  {
    "igorlfs/nvim-dap-view",
    lazy = false,
    opts = {
      winbar = { controls = { enabled = true } },
    },
  },
  {
    "mfussenegger/nvim-dap",
    cmd = { "DapContinue" },
    dependencies = {
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          local dap = require "dap"
          local configs = {}
          dap.configurations.python = configs
          local python_path =
          "C:/Users/tinnguyen/AppData/Local/nvim-data/mason/packages/debugpy/venv/Scripts/python.EXE"
          -- python_path/python -m debugpy --version might require -Xfrozen_modules=off
          -- this is the debugee cannot be debugged if it is a frozen module
          -- in the context of cs252, likely not
          require("dap-python").setup(python_path, { include_configs = false })
          table.insert(configs, {
            type = "python",
            request = "launch",
            name = "file Windows",
            program = "${file}",
            console = "internalConsole",
            pythonPath = function()
              print(vim.fn.getcwd() .. "/.venv/Scripts/python")
              return vim.fn.getcwd() .. "/.venv/Scripts/python"
            end,
          })
        end,
      },
    },
  },
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
  },
  { "nvchad/ui",                  url = "https://github.com/ngvt1n/ui", branch = "tin" },
  {
    {
      "pwntester/octo.nvim",
      cmd = "Octo",
      opts = {
        -- or "fzf-lua" or "snacks" or "default"
        picker = "telescope",
        -- bare Octo command opens picker of commands
        enable_builtin = true,
      },
      dependencies = {
        "plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-tree/nvim-web-devicons",
      },
    },
  },
  {
    "ngvt1n/img-clip.nvim",
    event = "VeryLazy",
    cmd = "PasteImage",
  },
  {
    "kawre/leetcode.nvim",
    cmd = "Leet",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- "ibhagwan/fzf-lua",
      "plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      storage = {
        home = "C:/Users/tinnguyen/Documents/cp/LeetCode",
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      scope = {
        show_start = false,
        show_end = false,
      },
    }
  },
  {
    "kiyoon/treesitter-indent-object.nvim",
    keys = {
      {
        "af",
        function()
          require("treesitter_indent_object.textobj").select_indent_outer(true, "V")
        end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (outer, line-wise)",
      },
      {
        "if",
        function()
          require("treesitter_indent_object.textobj").select_indent_inner(true, "V")
        end,
        mode = { "x", "o" },
        desc = "Select context-aware indent (inner, entire range) in line-wise visual mode",
      },
    },
  },
  {
    "Wansmer/treesj",
    keys = { { "<leader>j", "<Cmd>TSJToggle<CR>" } },
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require("treesj").setup {
        use_default_keymaps = false,
      }
    end,
  },
  { "seandewar/killersheep.nvim", cmd = "KillKillKill" },
  { "seandewar/nvimesweeper",     cmd = "Nvimesweeper" },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },
  {
    "xeluxee/competitest.nvim",
    cmd = "CompetiTest",
    dependencies = "MunifTanjim/nui.nvim",
    -- lazy load via workspace.nvim's hooks
    lazy = true,
    config = function()
      require("competitest").setup(overrides.competitest)
    end,
  },
  {
    "max397574/better-escape.nvim",
    enabled = false,
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = false,
    -- branch = "main",
    -- commit = "d23a3ca9",
    keys = {
      { ",,", "<cmd>CopilotChatToggle<cr>", mode = { "n", "v" }, desc = "CopilotChat - Toggle" },
    },
    -- cmd = { "CopilotChat", "CopilotChatToggle" },
    -- dependencies = {
    --   { "zbirenbaum/copilot.lua" },
    --   { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    --   { "nvim-treesitter/nvim-treesitter" },
    -- },
    -- opts = overrides.copilotchat,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = overrides.gitsigns,
  },
  {
    "jbyuki/venn.nvim",
    enabled = false,
    cmd = "VBox",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "User FilePost",
    config = function()
      require("treesitter-context").setup(overrides.context)
    end,
  },
  {
    "mechatroner/rainbow_csv",
    ft = { "csv", "tsv", "csv_semicolon", "csv_whitespace", "csv_pipe", "rfc_csv", "rfc_semicolon" },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    config = function()
      require("copilot").setup(overrides.copilot)
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install && git restore .",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "jbyuki/nabla.nvim",
    -- enabled = false,
    keys = {
      { "<leader>P", '<cmd>lua require("nabla").toggle_virt()<CR>', "Peek mathzones" },
      { "<leader>p", '<cmd>lua require("nabla").popup()<CR>',       "Peek mathzones" },
    },
  },
  {
    "stevearc/aerial.nvim",
    -- enabled = false,
    keys = { { "<leader>a", "<cmd>AerialToggle!<CR>" } },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("aerial").setup(overrides.aerial)
    end,
  },
  {
    "natecraddock/workspaces.nvim",
    config = function()
      require("workspaces").setup(overrides.workspaces)
    end,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      { "rafamadriz/friendly-snippets",     enabled = false },
      { "ghostfish0/friendly-snippets.nvim" },
    },
    opts = {
      enable_autosnippets = true,
      history = true,
      updateevents = "TextChanged,TextChangedI",
    },
    config = function(_, opts)
      require("luasnip").config.set_config(opts)
      require "nvchad.configs.luasnip"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup {}
        end,
      },
    },
    config = function(_, opts)
      require("cmp").setup(opts)
      require("cmp").setup.filetype("cpp", overrides.cmpcpp)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    cmd = { "TSInstall" },
    opts = require "configs.treesitter",
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
        name = 'plenary.nvim',
        dev = true,
      },
    },
    config = overrides.telescope,
  },
  -- disabled plugins
  { "nvzone/volt",                  enabled = false },
  { "nvzone/menu",                  enabled = false },
  { "nvzone/minty",                 enabled = false },
  { "rafamadriz/friendly-snippets", enabled = false },
  {
    "folke/which-key.nvim",
    enabled = false,
  },
  -- {
  --   "folke/lazydev.nvim",
  --   ft = "lua", -- only load on lua files
  --   opts = {
  --     runtime = "?.lua;?/init.lua;C:/Users/tinnguyen/AppData/Roaming/luarocks/share/lua/5.4/?.lua;C:/Users/tinnguyen/AppData/Roaming/luarocks/share/lua/5.4/?/init.lua",
  --     library = {
  --       vim.fn.expand '~/luarocks/share/lua/5.4',
  --       {
  --         path = "C:/Users/tinnguyen/AppData/Local/nvim-data/mason/packages/lua-language-server/meta/3rd/busted/",
  --         words = { "describe" },
  --       },
  --       { path = "C:/Users/tinnguyen/AppData/Local/nvim-data/mason/packages/lua-language-server/meta/3rd/luassert/library",
  --         words = { "describe" },
  --       },
  --       { path = "${3rd}/love/library", words = { "love" } },
  --     },
  --   },
  -- },
}
