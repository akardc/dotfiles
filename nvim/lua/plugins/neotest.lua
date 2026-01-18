return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-contrib/nvim-ginkgo",
      "nvim-neotest/neotest-jest",
      "nvim-neotest/neotest-go",
      "jfpedroza/neotest-elixir",
    },
    opts = {
      adapters = {
        "nvim-ginkgo",
        "neotest-elixir",
        -- "neotest-go",
      },
    },
  },
}
