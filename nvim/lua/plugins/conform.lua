return {
  {
    "stevearc/conform.nvim",
    opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = true,
      },
      formatters_by_ft = {
        ["templ"] = { "templ" },
      },
    },
  },
}
