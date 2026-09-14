-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>")

local wk = require("which-key")
wk.add({
  {
    "<leader>y",
    group = "Yank options",
  },
  {
    "<leader>yl",
    function()
      local s = vim.fn.line("v")
      local e = vim.fn.line(".")
      if s > e then
        s, e = e, s
      end
      local file = vim.fn.expand("%:.")
      local text = s == e and (file .. ":L" .. s) or (file .. ":L" .. s .. "-" .. e)
      vim.fn.setreg("+", text)
      vim.fn.setreg('"', text)
      vim.notify("Yanked line numbers")
    end,
    desc = "Yank the current file and line number",
    mode = "nx",
  },
  {
    "<leader>yf",
    function()
      local file = vim.fn.expand("%:.")
      vim.fn.setreg("+", file)
      vim.fn.setreg('"', file)
      vim.notify("Yanked filename")
    end,
    desc = "Yank the current filename",
    mode = "nx",
  },
})
