local M = {}
local utils = require "ui.stl.utils"
local separator_style = "round"
local sep_l = utils.separators[separator_style]["left"]
local sep_r = utils.separators[separator_style]["right"]

local face_fn = function()
  local modes = utils.faces
  if not utils.is_activewin() then
    return ""
  end

  local m = vim.api.nvim_get_mode().mode
  local current_mode = "%#St_" .. modes[m][2] .. "Mode#" .. modes[m][1]
  local mode_sep1 = "%#St_" .. modes[m][2] .. "ModeSep#" .. sep_r
  return current_mode .. mode_sep1
end

M.tabufline = {
  lazyload = false,
  order = {'face', 'buffers', 'tabs' },
  modules = { face = face_fn }
}

M.statusline = {
  theme = "default", -- default/vscode/vscode_colored/minimal
  order = { "file", "git", "%=", "lsp_msg", "diagnostics", "%=", "cwd", "lsp", "cursor", "clock", "copilot" },
  separator_style = separator_style,
}

M.statusline.modules = {
  clock = function()
    return "/  " .. os.date "%H:%M"
  end,
  -- mode = mode_fn,
  file = function()
    local x = utils.file()
    local name = x[2] .. (separator_style == "default" and " " or "")
    return "%#St_file# " .. name .. "%#St_file_sep#" .. sep_r
  end,
  lsp = function()
    if rawget(vim, "lsp") and vim.version().minor >= 10 then
      for _, client in ipairs(vim.lsp.get_clients()) do
        if client.attached_buffers[utils.stbufnr()] and client.name ~= "copilot" then
          return (vim.o.columns > 100 and " %#st_lsp#" .. client.name .. " /") or " %#st_lsp#  /"
        end
      end
    end
    return ""
  end,
  cwd = function()
    local icon = "%#St_cwd_text#" .. "󰉋"
    local name = vim.uv.cwd() or ""
    name = "%#St_cwd_text#" .. " " .. (name:match "([^/\\]+)[/\\]*$" or name) .. " "
    return (vim.o.columns > 85 and ("%#St_cwd_sep# " .. icon .. name) .. "/") or ""
  end,
  cursor = function()
    return "%#St_pos_icon#" .. "%#St_Pos_text# %p%% "
  end,
  copilot = function()
    if rawget(vim, "lsp") and vim.version().minor >= 10 then
      for _, client in ipairs(vim.lsp.get_clients()) do
        if client.attached_buffers[utils.stbufnr()] and client.name == "copilot" then
          local c = require "copilot.client"
          return (c.is_disabled()) and "" or "%#St_CopilotSep# %#St_Copilot#  %#St_CopilotSep#▌"
        end
      end
    end
    return ""
  end,
}

return M
