return {
  { "nvim-contrib/nvim-ginkgo" },
  { "nvim-neotest/neotest-jest" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        "nvim-ginkgo",
      },
    },
  },
}
