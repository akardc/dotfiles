return {
  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-contrib/neotest-ginkgo",
      -- "nvim-neotest/neotest-jest",
      -- "nvim-neotest/neotest-go",
      -- "jfpedroza/neotest-elixir",
    },
    -- config = function()
    --   require("neotest").setup({
    --     adapters = {
    --       require("neotest-ginkgo"),
    --     },
    --   })
    -- end,
    opts = {
      adapters = {
        "neotest-ginkgo",
        -- "neotest-elixir",
        -- "neotest-go",
      },
    },
  },
}
