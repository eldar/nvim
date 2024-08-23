local util = require("config.utils")
local nmap = util.nmap
local vmap = util.vmap

function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

local opts = { noremap = true, silent = true }

-- Better window navigation
nmap("<C-h>", "<C-w>h", opts)
nmap("<C-j>", "<C-w>j", opts)
nmap("<C-k>", "<C-w>k", opts)
nmap("<C-l>", "<C-w>l", opts)

-- Telescope
nmap("<leader>Tk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
nmap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", { desc = "Find Files inc. hidden" })
nmap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", { desc = "buffers" })
nmap("<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { desc = "ripgrep" })
-- nmap("<leader>sg", "<cmd>lua require('telescope.builtin').live_grep({additional_args = {'--hidden'}})<cr>", { desc = "ripgrep inc. hidden" })
nmap("<leader>cg", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", { desc = "current buffer fuzzy find" })

-- https://github.com/nvim-telescope/telescope.nvim/issues/1923#issuecomment-1122642431
nmap("<leader>g", ':Telescope current_buffer_fuzzy_find<cr>', opts)
vmap("<leader>g", function()
  local text = vim.getVisualSelection()
  require('telescope.builtin').current_buffer_fuzzy_find({ default_text = text })
end, opts)

nmap("<leader>gg", ':Telescope live_grep<cr>', opts)
vmap("<leader>gg", function()
  local text = vim.getVisualSelection()
  require('telescope.builtin').live_grep({ default_text = text })
end, opts)

-- nvim-tree
nmap("<leader>e", ":<C-u>NvimTreeToggle<CR>:doautocmd WinEnter<CR>", opts)
nmap("<leader>fe", ":<C-u>NvimTreeFocus<CR>", opts)

-- Copy to clipboard
vmap("<leader>y", '"+y')
nmap("<leader>Y", '"+yg_')
nmap("<leader>y", '"+y')
-- nmap("<leader>p", '"+p')
-- nmap("<leader>P", '"+P')

nmap('<leader>bd', ':<C-u>bprevious <Bar> bdelete #<CR>', opts)

nmap("-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

local km, l, api = vim.keymap.set, vim.lsp, vim.api
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event)
    local bufopts = { noremap = true, silent = true, buffer = event.buf }
    km("n", "<leader>p", require("telescope.builtin").lsp_document_symbols, bufopts)
    km("n", "<leader>pp", require("telescope.builtin").lsp_dynamic_workspace_symbols, bufopts)
    -- km('n', 'gr', vim.lsp.buf.references, bufopts)
    km('n', 'gr', require('telescope.builtin').lsp_references, bufopts) -- '[G]oto [R]eferences'
    km('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', bufopts)
    -- Thank you teej
    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    -- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L514
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup = vim.api.nvim_create_augroup("nvim-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("nvim-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "nvim-lsp-highlight", buffer = event2.buf })
        end,
      })
    end
  end,
})

local Path = require("plenary").path

vim.api.nvim_create_user_command("CopyAbsPath", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_user_command("CopyRelPath", function()
    local path = Path:new(vim.fn.expand("%")):make_relative()
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

nmap("<leader>cr", ':CopyRelPath <cr>', opts)
nmap("<leader>ca", ':CopyAbsPath <cr>', opts)

nmap("<leader>do", vim.diagnostic.open_float, opts)
nmap('<leader>dp', vim.diagnostic.goto_prev, opts)
nmap('<leader>dn', vim.diagnostic.goto_next, opts)
nmap('<leader>ds', vim.diagnostic.setqflist, opts)

nmap("<F3>", "<cmd>Neogit<cr>", {desc = "Neogit"})
