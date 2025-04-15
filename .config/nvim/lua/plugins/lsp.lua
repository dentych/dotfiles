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
            },
          },
        },
      },
    },
  },
}
