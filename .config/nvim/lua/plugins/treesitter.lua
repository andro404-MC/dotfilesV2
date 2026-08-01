return {
  {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {}, -- tree-sitter CLI must be installed system-wide

    cmd = {
      "TSManager",
      "TSInstall",
      "TSUninstall",
    },

    config = function()
      require("tree-sitter-manager").setup {
        -- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
        -- highlight = true, -- treesitter highlighting is enabled by default
        auto_install = false,
        ensure_installed = {
          "vim",
          "lua",
          "vimdoc",
          "html",
          "css",
          "javascript",
          "typescript",
          "json",
          "yaml",
          "toml",
          "python",
          "rust",
          "c",
          "cpp",
          "bash",
          "fish",
          "go",
          "templ",
          "svelte",
          "markdown",
          "markdown_inline",
          "sql",
          "gomod",
          "hyprlang",
          "comment",
          "tera",
          "zig",
        },
      }
    end,
  },
}
