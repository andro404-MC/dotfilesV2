local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier", "rustywind" },
    go = { "gofumpt", "goimports-reviser", "golines" },
    templ = { "templ", "rustywind" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
