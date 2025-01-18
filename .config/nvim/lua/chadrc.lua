local options = {

  base46 = {
    theme = "tokyonight",
  },

  ui = {
    cmp = {
      style = "atom",
      format_colors = {
        tailwind = true,
      },
    },

    telescope = { style = "borderless" },

    statusline = {
      enabled = true,
      theme = "vscode_colored",
      separator_style = "block",
    },

    tabufline = {
      enabled = true,
      order = { "treeOffset", "buffers" },
    },
  },

  nvdash = {
    load_on_startup = true,
    header = {
      " █    ██  ███▄    █ ▄▄▄█████▓▓█████  ███▄ ▄███▓ ██▓",
      " ██  ▓██▒ ██ ▀█   █ ▓  ██▒ ▓▒▓█   ▀ ▓██▒▀█▀ ██▒▓██▒",
      "▓██  ▒██░▓██  ▀█ ██▒▒ ▓██░ ▒░▒███   ▓██    ▓██░▒██▒",
      "▓▓█  ░██░▓██▒  ▐▌██▒░ ▓██▓ ░ ▒▓█  ▄ ▒██    ▒██ ░██░",
      "▒▒█████▓ ▒██░   ▓██░  ▒██▒ ░ ░▒████▒▒██▒   ░██▒░██░",
      "░▒▓▒ ▒ ▒ ░ ▒░   ▒ ▒   ▒ ░░   ░░ ▒░ ░░ ▒░   ░  ░░▓  ",
      "░░▒░ ░ ░ ░ ░░   ░ ▒░    ░     ░ ░  ░░  ░      ░ ▒ ░",
      " ░░░ ░ ░    ░   ░ ░   ░         ░   ░      ░    ▒ ░",
      "   ░              ░             ░  ░       ░    ░  ",
      "                                                   ",
      "                                                   ",
    },

    buttons = {
      { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
      { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
      { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
      { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
      { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },
    },
  },
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
