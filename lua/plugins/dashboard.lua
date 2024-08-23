-- local Util = require("lazyvim.util")
--
-- function _G.switch_projects()
--   local ok, fzf_lua = pcall(require, "fzf-lua")
--
--   if not ok then
--     return
--   end
--
--   local history = require("project_nvim.utils.history")
--   local results = history.get_recent_projects()
--   fzf_lua.fzf_exec(results, {
--     actions = {
--       ["default"] = {
--         function(selected)
--           fzf_lua.files({ cwd = selected[1] })
--         end,
--       },
--     },
--   })
-- end

return {
  "nvimdev/dashboard-nvim",
  lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
  opts = function()
    -- stylua: ignore
    local telescope_actions = {
        { action = "Telescope find_files",                                      desc = " Find file",       icon = " ", key = "f" },
        { action = "ene | startinsert",                                         desc = " New file",        icon = " ", key = "n" },
        { action = "Telescope oldfiles",                                        desc = " Recent files",    icon = " ", key = "r" },
        { action = "Telescope live_grep",                                       desc = " Find text",       icon = " ", key = "g" },
        -- { action = "Telescope harpoon marks",                                   desc = " Open mark",       icon = " ", key = "m" },
        { action = [[lua require('telescope').extensions.projects.projects()]], desc = " Projects",        icon = " ", key = "p" },
        -- { action = [[lua require("lazyvim.util").telescope.config_files()()]],  desc = " Config",          icon = " ", key = "c" },
        { action = "SessionRestore",                                            desc = " Restore Session", icon = " ", key = "s" },
        -- { action = "SessionManager load_current_dir_session",                   desc = " Restore Session", icon = " ", key = "s" },
        { action = "LazyExtras",                                                desc = " Lazy Extras",     icon = " ", key = "x" },
        { action = "Lazy",                                                      desc = " Lazy",            icon = "󰒲 ", key = "l" },
        { action = "qa",                                                        desc = " Quit",            icon = " ", key = "q" },
    }

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        -- Center the dashboard
        -- header = vim.split(logo, "\n"),
        center = telescope_actions,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
}
