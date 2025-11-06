return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        settings = {
          javascript = {
            format = {
              indentSwitchCase = false,
            },
          },
          typescript = {
            format = {
              indentSwitchCase = false,
            },
          },
        },
      },
    },
    -- setup = {
    --   vtsls = function(_, opts)
    --     opts.capabilities.settings.javascript.format.indentSwitchCase = false
    --     opts.capabilities.settings.typescript.format.indentSwitchCase = false
    --     -- require("lazyvim.util").lsp.on_attach(function(client)
    --     --   if client.name == "vtsls" then
    --     --     client.settings.javascript.format.indentSwitchCase = false
    --     --     client.settings.typescript.format.indentSwitchCase = false
    --     --   end
    --     -- end)
    --   end,
    -- },
  },
}
