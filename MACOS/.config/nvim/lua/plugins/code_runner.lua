-- code_runner.lua
return {
  "CRAG666/code_runner.nvim",
  config = function()
    require("code_runner").setup({
      filetype = {
        rust = "cd $dir && cargo run",
        c = "cd $dir && gcc $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
        cpp = "cd $dir && g++ -std=c++17 $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
        python = "python3 -u",
        java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
        zig = "cd $dir && zig run $fileName",
      },
    })
  end,
}
