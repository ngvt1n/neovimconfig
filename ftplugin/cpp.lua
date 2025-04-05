-- local api = vim.api
-- local ucmd = api.nvim_create_user_command
-- local acmd = api.nvim_create_autocmd
local o = vim.o

o.makeprg = "clear && g++ %:p -o %:p:r && %:p:r > /tmp/cpp_output && cat /tmp/cpp_output"
