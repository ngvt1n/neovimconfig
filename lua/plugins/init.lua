local overrides = require("configs.overrides")
return {
  {
    'nvim-mini/mini.ai',
    version = '*',
    event = "User FilePost",
    config = function()
      local spec_treesitter = require('mini.ai').gen_spec.treesitter
      require('mini.ai').setup({
        custom_textobjects = {
          F = spec_treesitter({
            a = { '@function.outer' },
            i = { '@function.inner' },
          }),
          m = { '%$().-()%$', '^.().*().$' },
          M = {
            {
              '%f[$]%s*%$%$\r?\n().-[%s%S]-()\r?\n%s*%$%$%f[^$]', -- around (a)
              '^%s*%$%$\r?\n().-[%s%S]-()\r?\n%s*%$%$'
            },
          }
        },
      })
    end
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = overrides.imgclip,
    cmd = {
      "PasteImage",
      "ImgClipDebug",
      "ImgClipConfig"
    },
  },
  {
    "lervag/vimtex",
    enabled = false,
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      vim.g.vimtex_view_general_viewer = 'okular'
      vim.g.vimtex_view_general_options = 'file:@pdf#src:@line@tex'
      vim.g.vimtex_delim_list = {
        delim_math = {
          name = {
            { "\\mq",  "\\md" },
            { "\\am",  "\\ad" },
            { "\\pm",  "\\pd" },
            { "\\eqn", "\\eqd" },
          }
        }
      }
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup(overrides.blankline)
    end,
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
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = overrides.telescopefb,
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },
  {
    "max397574/better-escape.nvim",
    enabled = false,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    keys = {
      { ",,", "<cmd>CopilotChatToggle<cr>", mode = { "n", "v" }, desc = "CopilotChat - Toggle" },
    },
    cmd = { "CopilotChat", "CopilotChatToggle" },
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
      { "nvim-treesitter/nvim-treesitter" },
    },
    opts = overrides.copilotchat,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = overrides.gitsigns,
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
    url = "https://github.com/ngvt1n/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install && git restore .",
    init = function()
      vim.g.mkdp_auto_close = 0;
      vim.g.mkdp_markdown_css = vim.fn.expand('~/Documents/notes/markdown.css')
      -- vim.g.mkdp_combine_preview = 1;
      -- vim.g.mkdp_combine_preview_auto_refresh = 1;
      vim.g.mkdp_theme = 'light'
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_preview_options = {
        -- disable_sync_scroll = 1,
        disable_sync_scroll = 1,
        content_editable = true,
        katex = {
          macros = {
            ["\\al"] = "\\begin{aligned}",
            ["\\la"] = "\\end{aligned}",
            ["\\mq"] = "\\begin{bmatrix}",
            ["\\md"] = "\\end{bmatrix}",
            ["\\am"] = "\\begin{matrix}",
            ["\\ad"] = "\\end{matrix}",
            ["\\pm"] = "\\begin{matrix}",
            ["\\pd"] = "\\end{matrix}",
            ["\\eqn"] = "\\begin{array}{rcl}",
            ["\\eqd"] = "\\end{array}",
            ["\\RR"] = "\\mathbb{R}",
            ["\\ZZ"] = "\\mathbb{Z}",
            ["\\NN"] = "\\mathbb{N}",
            ["\\BB"] = "\\mathfrak{B}",
            ["\\grad"] = "\\nabla",
            ["\\div"] = "\\nabla \\cdot",
            ["\\curl"] = "\\nabla \\times",
            ["\\union"] = "\\cup",
            ["\\del"] = "\\nabla",
          }
        },
      }
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
    opts = require("configs.conform"),
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        url = "https://github.com/ngvt1n/friendly-snippets.nvim"
      },
    },
    opts = {
      enable_autosnippets = true,
    },
    config = function(_, opts)
      -- lua snippets
      require("luasnip.loaders.from_vscode").lazy_load()                           -- friendly snippets
      require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets/" }) -- custom lua snippets
      require("luasnip").config.set_config(opts)
      require("nvchad.configs.luasnip")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup({})
        end,
      },
    },
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },
  {
    "windwp/nvim-autopairs",
    opts = overrides.autopairs,
    config = function(_, opts)
      local npairs = require('nvim-autopairs')
      local rule = require('nvim-autopairs.rule')
      local cond = require('nvim-autopairs.conds')
      npairs.setup(opts)
      npairs.add_rule(rule("$", "$", { "md", "markdown" })) -- for deleting
      npairs.add_rule(rule("∥", "∥", { "md", "markdown" })) -- for deleting
      -- npairs.get_rules('[')[1].not_filetypes = { "markdown_inline", "markdown" }
      npairs.get_rules("'")[1].not_filetypes = { "markdown_inline", "markdown" }
      -- setup cmp for autopairs
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("configs.lspconfig")
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    -- dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects'},
    opts = overrides.treesitter
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },
  -- disabled plugins
  { "nvzone/volt",  enabled = false },
  { "nvzone/menu",  enabled = false },
  { "nvzone/minty", enabled = false },
  {
    "folke/which-key.nvim",
    enabled = false,
  },
}
