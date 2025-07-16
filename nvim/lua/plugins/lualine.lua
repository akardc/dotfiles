local window = function()
  return vim.api.nvim_win_get_number(0)
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
        refresh_time = 16, -- ~60fps
        events = {
          "WinEnter",
          "BufEnter",
          "BufWritePost",
          "SessionLoadPost",
          "FileChangedShellPost",
          "VimResized",
          "Filetype",
          "CursorMoved",
          "CursorMovedI",
          "ModeChanged",
        },
      },
    },
    sections = {
      lualine_a = { window, "mode" },
      -- lualine_a = {
      -- 	{
      -- 		'windows',
      -- 		show_filename_only = true, -- Shows shortened relative path when set to false.
      -- 		show_modified_status = true, -- Shows indicator when the window is modified.
      --
      -- 		mode = 1,    -- 0: Shows window name
      -- 		-- 1: Shows window index
      -- 		-- 2: Shows window name + window index
      --
      -- 		-- max_length = vim.o.columns * 2 / 3, -- Maximum width of windows component,
      -- 		-- it can also be a function that returns
      -- 		-- the value of `max_length` dynamically.
      -- 		-- filetype_names = {
      -- 		-- 	TelescopePrompt = 'Telescope',
      -- 		-- 	dashboard = 'Dashboard',
      -- 		-- 	packer = 'Packer',
      -- 		-- 	fzf = 'FZF',
      -- 		-- 	alpha = 'Alpha'
      -- 		-- },                            -- Shows specific window name for that filetype ( { `filetype` = `window_name`, ... } )
      --
      -- 		-- disabled_buftypes = { 'quickfix', 'prompt' }, -- Hide a window if its buffer's type is disabled
      --
      -- 		-- Automatically updates active window color to match color of other components (will be overidden if buffers_color is set)
      -- 		use_mode_colors = false,
      --
      -- 		-- windows_color = {
      -- 		-- 	-- Same values as the general color option can be used here.
      -- 		-- 	active = 'lualine_{section}_normal', -- Color for active window.
      -- 		-- 	inactive = 'lualine_{section}_inactive', -- Color for inactive window.
      -- 		-- },
      -- 	}
      -- },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        {
          "filename",
          file_status = true, -- Displays file status (readonly status, modified status)
          newfile_status = true, -- Display new file status (new file means no write after created)
          path = 1, -- 0: Just the filename
          -- 1: Relative path
          -- 2: Absolute path
          -- 3: Absolute path, with tilde as the home directory
          -- 4: Filename and parent dir, with tilde as the home directory

          shorting_target = 40, -- Shortens path to leave 40 spaces in the window
          -- for other components. (terrible name, any suggestions?)
          symbols = {
            modified = "[+]", -- Text to show when the file is modified.
            readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
            unnamed = "[No Name]", -- Text to show for unnamed buffers.
            newfile = "[New]", -- Text to show for newly created file before first write
          },
        },
      },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = { window },
      lualine_b = {},
      lualine_c = {
        {
          "filename",
          file_status = true, -- Displays file status (readonly status, modified status)
          newfile_status = false, -- Display new file status (new file means no write after created)
          path = 0, -- 0: Just the filename
          -- 1: Relative path
          -- 2: Absolute path
          -- 3: Absolute path, with tilde as the home directory
          -- 4: Filename and parent dir, with tilde as the home directory

          shorting_target = 40, -- Shortens path to leave 40 spaces in the window
          -- for other components. (terrible name, any suggestions?)
          symbols = {
            modified = "[+]", -- Text to show when the file is modified.
            readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
            unnamed = "[No Name]", -- Text to show for unnamed buffers.
            newfile = "[New]", -- Text to show for newly created file before first write
          },
        },
      },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  },
}
