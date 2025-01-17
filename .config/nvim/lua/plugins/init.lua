return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  { "github/copilot.vim", enabled = false, lazy = false },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        width = 23,
      },
      filters = {
        dotfiles = false,
      },
    },
  },
}
