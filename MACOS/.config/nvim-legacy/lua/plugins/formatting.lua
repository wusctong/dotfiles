return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      rust = { "rustfmt" },
    },
    formatters = {
      rustfmt = {
        command = "rustfmt",
        args = { "--edition", "2024" },
      },
    },
  },
}
