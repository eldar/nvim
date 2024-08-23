-- https://neovim.io/doc/user/lua-guide.html
local autocmd = vim.api.nvim_create_autocmd

-- From vim defaults.vim
-- Adapted by https://github.com/alexanderjeurissen/dotfiles/blob/main/config/nvim/lua/autocmd.lua
-- When editing a file, always jump to the last known cursor position.
-- Don't do it for commit messages, when the position is invalid, or when
-- inside an event handler (happens when dropping a file on gvim).
-- In addition open folds till the cursor is visible
autocmd('BufReadPost', {
  callback = function()
    local line = vim.fn.line

    if vim.bo.filetype == 'gitcommit' then return end
    if line("'\"") <= 0 then return end
    if line("'\"") > line('$') then return end

    vim.cmd("normal g`\"")
    vim.cmd('normal zv')
  end,
  group = general
})
