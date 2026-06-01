-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

local highlights = require "highlights"

M = {
  ui = {
    statusline = {
      theme = "default", -- default/vscode/vscode_colored/minimal
      separator_style = "round",
      order = { "sky", "cwd", "git", "%=", "lsp_msg", "diagnostics", "%=", "lsp", "cursor", "clock", "copilot" },
    },
    tabufline = {
      lazyload = false,
      order = { 'faces', 'spinner', 'buffers', 'tabs' },
    },
    cmp = {
      style = "default", -- default/flat_light/flat_dark/atom/atom_colored
      format_colors = { lsp = true, icon = "󱓻" },
      icons_left = true,
    },
    telescope = { style = "borderless" },
  },
  cheatsheet = { theme = "grid" },
  colorify = {
    enabled = true,
    mode = "bg", -- fg, bg, virtual
    highlight = { hex = true, lspvars = true },
  },
  base46 = {
    theme = require("ui.theme"), -- base16, tokyonight, onedark, gruvbox, catppuccino
    transparency = false,
    hl_override = highlights.override,
    hl_add = highlights.add,
  },
  mason = {
    pkgs = {
      -- lua stuff
      "lua-language-server",
      "stylua",

      -- web dev stuff
      "css-lsp",
      "html-lsp",
      "typescript-language-server",
      "prettier",

      -- c/cpp stuff
      "clangd",
      "clang-format",
      "glsl_analyzer",
      "rust_analyzer",

      -- python stuff
      "black",
      "pyright",

      -- java
      "jdtls",

      -- note-taking stuff
      -- "marksman",
    },
  },

  term = {
    base46_colors = false,
  },

}

return M
