return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              buildFlags = { "-tags=integration" },
              -- disable annoying hints in the code
              hints = false,
              usePlaceholders = false,
            },
          },
        },
        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                parameterNames = {
                  enabled = false,
                },
              },
            },
          },
        },
      },
    },
  },
}
