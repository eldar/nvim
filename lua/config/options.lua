vim.g.have_nerd_font = false

-- Enable 24-bit RGB colors
vim.opt.termguicolors = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
-- Enable break indent
vim.opt.breakindent = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
-- vim.opt.timeoutlen = 300

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.compatible = false

vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.opt.incsearch = true

-- Case character
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Indent
-- vim.opt.smartindent = false

-- Tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.autoindent = true

vim.opt.number = true

vim.opt.mouse = "a"

vim.cmd[[
  filetype plugin on 
  filetype plugin indent on " allow auto-indenting depending on file type
  set clipboard=unnamedplus " using system clipboard
  set linebreak " break lines by words not characters
]]

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'

vim.opt.fillchars = {
  fold = ' ',
  diff = '╱',
  wbr = '─',
  msgsep = '─',
  horiz = ' ',
  horizup = '│',
  horizdown = '│',
  vertright = '│',
  vertleft = '│',
  verthoriz = '│',
}
