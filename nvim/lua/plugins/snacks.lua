return {
  {
    "folke/snacks.nvim",
    opts = {
      zen = {
        toggles = {
          dim = false,
          git_signs = true,
          mini_diff_signs = true,
          diagnostics = true,
          inlay_hints = true,
        },
        show = {
          statusline = true,
          tabline = true,
        },
      },
      styles = {
        zen = {
          backdrop = { transparent = true, blend = 40 },
          width = 200,
        },
      },
    },
  },
}
