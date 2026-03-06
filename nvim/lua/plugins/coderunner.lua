return {
  "CRAG666/code_runner.nvim",
  opts = {
    mode = "term", -- 重点：使用终端模式，方便交互 (比如 pwntools 的 interactive)
    focus = true, -- 运行后自动把焦点跳到输出窗口
    startinsert = true,
    filetype = {
      python = "python3 -u \"$fileName\"",
      go = "go run",
      sh = "bash",
      rust = "cargo run",
      php = "bash -c 'php \"$0\" | tee /dev/tty | wl-copy'",
      c = "mkdir -p \"$dir/Output\" && gcc \"$fileName\" -std=c23 -O2 -Wall -o \"$dir/Output/$fileNameWithoutExt\" && \"$dir/oOutput/$fileNameWithoutExt\"",
      cpp = "mkdir -p \"$dir/Output\" && g++ \"$fileName\" -std=c++23 -O2 -Wall -o \"$dir/Output/$fileNameWithoutExt\" && \"$dir/Output/$fileNameWithoutExt\"",
      java = "mkdir -p \"$dir/Output\" && javac -d \"$dir/Output\" \"$fileName\" && java -cp \"$dir/Output\" \"$fileNameWithoutExt\"",
    },
  },
  keys = {
    -- 建议绑定 F5 或者 <leader>r，符合直觉
    { "<leader>r", ":RunCode<CR>", desc = "运行脚本" },
    { "<leader>rf", ":RunFile<CR>", desc = "运行当前文件" },
  },
}
