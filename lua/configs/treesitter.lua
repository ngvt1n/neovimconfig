pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

return {
  ensure_installed = {
    "java",
    "vim",
    -- lua stuff
    "lua",
    -- web dev stuff
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    --- c/cpp stuff
    "c",
    "cpp",
    "cuda",
    -- python stuff
    "python",
    --- note taking stuff
    "markdown",
    "markdown_inline",
    --- graphics stuff
    "glsl",
    ---
    "diff",
  },
}
