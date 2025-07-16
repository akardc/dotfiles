-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>")

-- " Moving between windows (from Ben Frain's talk at NeovimConf 2022)Add commentMore actions
for i = 1, 6 do
  local lhs = "<leader>" .. i
  local rhs = i .. "<c-w>w"
  vim.keymap.set("n", lhs, rhs, { desc = "Move to window " .. i })
end
