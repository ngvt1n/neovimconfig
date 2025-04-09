local options = {
  formatters_by_ft = {
    lua = {},
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    java = { "clang-format" },
    cpp = { "clang-format" },
    c = { "clang-format-c" },
  },
  formatters = {
    ["clang-format-c"] = {
      command = "clang-format",
      args = '--style="{BasedOnStyle: llvm, UseTab: Always, IndentWidth: 4, TabWidth: 4}"',
    },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
