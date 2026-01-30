local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    cpp = { "clang_format" }, -- use clang-format for C++
    c = { "clang_format" }, -- optional for C
    h = { "clang_format" }, -- header files
    hpp = { "clang_format" },
  },
})

-- Optional: auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.cpp", "*.hpp", "*.h", "*.c" },
  callback = function()
    conform.format({ async = false })
  end,
})
