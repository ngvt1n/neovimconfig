local M = {}

local multiselect = function(prompt_bufnr)
  local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require("telescope.actions").close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then
        vim.cmd(string.format("%s %s", "edit", j.path))
      end
    end
  else
    require("telescope.actions").select_default(prompt_bufnr)
  end
end


M.gitsigns = {
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk)
    map('n', '<leader>hr', gitsigns.reset_hunk)

    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('n', '<leader>hS', gitsigns.stage_buffer)
    map('n', '<leader>hR', gitsigns.reset_buffer)
    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>hi', gitsigns.preview_hunk_inline)

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end)

    map('n', '<leader>hd', gitsigns.diffthis)

    map('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end)

    map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
    map('n', '<leader>hq', gitsigns.setqflist)

    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>td', gitsigns.toggle_deleted)
    map('n', '<leader>tw', gitsigns.toggle_word_diff)

    -- Text object
    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
  end
}

M.jdtls = {}

M.competitest = {
  compile_command = {
    cpp = {
      exec = "g++",
      args = { "-std=c++20", "-Wall", "$(FNAME)", "-o", "$(FNOEXT)", "-DLOCAL" },
    },
  },
  testcases_directory = "./testcases",
  received_problems_path = "$(HOME)/Documents/cp/$(JUDGE)/$(CONTEST)/$(PROBLEM).$(FEXT)",
  template_file = { cpp = "~/Documents/cp/template.cpp" },
  evaluate_template_modifiers = true,
}

M.context = {
  max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
  separator = "·",
}

M.aerial = {
  backends = {
    python = {"lsp"},
    ["_"] = { "treesitter", "lsp" },
  },
  filter_kind = {
    lua = false,
    python = {
      "Method"
    },
    -- lua = {
    --   -- "String",
    --   "Constructor",
    --   "Enum",
    --   "Function",
    --   "Interface",
    --   "Module",
    --   "Method",
    --   "Struct",
    -- },
    ["_"] = false,
  },
  icons = {
    markdown = { Interface = "" },
    tex = { Method = "" },
  },
  guides = {
    whitespace = " ",
  },
}

M.peek = {
  auto_load = false,         -- whether to automatically load preview when entering another markdown buffer
  syntax = true,             -- enable syntax highlighting, affects performance
  app = "browser",           -- 'webview', 'browser', string or a table of strings explained below
  filetype = { "markdown" }, -- list of filetypes to recognize as markdown
}

M.copilotchat = {
  debug = false,
  question_header = ">",
  answer_header = "<",
  error_header = "**!!!**",
  separator = " ",

  -- show_folds = false,
  show_help = false,
  -- auto_insert_mode = false,

  -- context = "buffers",
  -- See Configuration section for rest
  -- window = {
  --   layout = "float",
  --   border = "rounded",
  -- },
  model = 'gpt-4o'
}

M.copilot = {
  suggestion = { enabled = false },
  panel = { enabled = false },
  filetypes = {
    terminal = false,
    lazy = false,
    mason = false,
    lspinfo = false,
    TelescopePrompt = false,
    TelescopeResults = false,
    nvdash = false,
    nvcheatsheet = false,
    NvimTree = false,
    aerial = false,
    markdown = true,
  },
}

M.treesitter = {
  matchup = {
    enable = true,
    disable = { "c", "ruby", "help" },
    disable_virtual_text = true,
  },
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
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.telescope = {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    preview = {
      filesize_limit = 0.1,
      highligh_limit = 0.1,
      timeout = 100,
    },
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },
  extensions_list = { "themes", "workspaces", "aerial", "file_browser" },
  pickers = {
    live_grep = {
      mappings = {
        n = { l = multiselect, }
      }
    },
    find_files = {
      mappings = {
        n = { l = multiselect, }
      }
    },
  },
}

M.telescopefb = function()
  local action_state = require "telescope.actions.state"
  local actions = require("telescope").extensions.file_browser.actions
  local fb_utils = require "telescope._extensions.file_browser.utils"

  local changecwd = function(prompt_bufnr)
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    local finder = current_picker.finder
    local entry_path = action_state.get_selected_entry().Path
    finder.path = entry_path:parent():absolute()
    finder.cwd = finder.path
    vim.cmd("cd " .. finder.path)

    fb_utils.redraw_border_title(current_picker)
    current_picker:refresh(
      finder,
      { new_prefix = fb_utils.relative_path_prefix(finder), reset_prompt = true, multi = current_picker._multi }
    )
    fb_utils.notify(
      "action.change_cwd",
      { msg = "Set the current working directory!", level = "INFO", quiet = finder.quiet }
    )
  end

  require("telescope").setup {
    extensions = {
      file_browser = {
        initial_mode = "normal",
        layout_config = { height = 0.4 },
        theme = "ivy",
        hijack_netrw = false,
        grouped = true,
        select_buffer = true,
        hide_parent_dir = true,
        quiet = true,
        dir_icon = "󰉋",
        dir_icon_hl = "@function",
        display_stat = {},
        git_status = true,
        respect_gitignore = true,
        prompt_path = true,
        hidden = false,
        mappings = {
          ["i"] = {
            ["<C-a>"] = actions.create,
            ["<C-e>"] = actions.rename,
            ["<C-x>"] = actions.move,
            ["<C-l>"] = multiselect,
            ["<C-h>"] = actions.goto_parent_dir,
            ["<C-g>"] = actions.toggle_respect_gitignore,
            ["<C-.>"] = actions.toggle_hidden,
          },
          ["n"] = {
            a = actions.create,
            e = actions.rename,
            x = actions.move,
            l = multiselect,
            h = actions.goto_parent_dir,
            c = actions.copy,
            g = actions.toggle_respect_gitignore,
            t = changecwd,
            ["."] = actions.toggle_hidden,
          },
        },
      },
    },
  }
end

M.workspaces = {
  cd_type = "tab",
  hooks = {
    open = function(name, _)
      if name == "cp" then
        require("competitest").setup()
        return false
      end
    end,
  },
}

-- git support and more in nvimtree
M.nvimtree = {
  hijack_cursor = false,
  view = {
    cursorline = false,
    width = {
      max = "25%",
    },
  },
  actions = {
    open_file = {
      resize_window = false,
    },
  },
  filters = {
    -- git_ignored = false,
  },
  git = {
    disable_for_dirs = {
      "C:\\Users\\tinnguyen\\Documents\\notes\\",
    },
    enable = true,
  },

  renderer = {
    highlight_opened_files = "all",
    -- highlight_git = true,
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      show = {
        git = true,
      },
    },
  },
}

-- M.colorizer = {
--   filetypes = {
--     markdown = { names = false },
--     "*", -- Highlight all files, but customize some others.
--   },
-- }

M.blankline = {
  scope = {
    show_start = false,
    show_end = false,
  },
}

local cmp = require "cmp"
M.cmp = {
  sources = {
    { name = "luasnip" },
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "async_path" },
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
  },
}

M.cmpcpp = {
  sources = {
    { name = "luasnip", priority = "1000000" },
    { name = "buffer" },
    { name = "async_path" },
  },
}

return M
