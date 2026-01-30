return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Ensure objective-c and objective-cpp parsers are installed
      vim.list_extend(opts.ensure_installed, {
        "c",
        "cpp",
        "objc",
      })
    end,
  },
}
