return {
  { import = "nvchad.blink.lazyspec" },

  {
    "piersolenski/wtf.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {},
  },

  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    ft = "markdown",
  },

  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "ibhagwan/fzf-lua" },
    },
    event = "LspAttach",
    opts = {},
  },

  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {},
  },

  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
  },

  -- {
  --   "m4xshen/hardtime.nvim",
  --   lazy = false,
  --   dependencies = { "MunifTanjim/nui.nvim" },
  --   opts = {},
  -- },

  {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = {
      render = "wrapped-compact",
      top_down = false,
      fps = 60,
      max_width = 50,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, {
          border = "single",
        })
      end,
    },
  },

  {
    "mistweaverco/kulala.nvim",
    ft = { "http" },
    opts = {
      global_keymaps = true,
    },
  },

  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },

  { "jvgrootveld/telescope-zoxide", lazy = false },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        width = 25,
      },

      update_focused_file = {
        enable = false,
        update_root = {
          enable = false,
        },
        exclude = false,
      },

      filters = { custom = { "^.git$" } },
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = "BufEnter",
    config = function()
      require "configs.lint"
    end,
  },

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

  {
    "dundalek/bloat.nvim",
    cmd = "Bloat",
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      {
        "<leader>ds",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Start/Continue",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: Step Over",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: Step Out",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: Toggle Breakpoint",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
        end,
        desc = "Debug: Set Breakpoint",
      },
      {
        "<leader>dt",
        function()
          require("dapui").toggle()
        end,
        desc = "Debug: See last session result.",
      },
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      dapui.setup {
        icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
        controls = {
          icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⏎",
            step_over = "⏭",
            step_out = "⏮",
            step_back = "b",
            run_last = "▶▶",
            terminate = "⏹",
            disconnect = "⏏",
          },
        },
      }

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }

      dap.configurations.rust = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
      }
    end,
  },
}
