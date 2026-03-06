return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                -- 关闭风格检查
                pycodestyle = { enabled = false },

                -- 关闭复杂度检查
                mccabe = { enabled = false },

                -- 关闭格式化器
                autopep8 = { enabled = false },
                yapf = { enabled = false },

                -- 关闭 pylint / flake8
                pylint = { enabled = false },
                flake8 = { enabled = false },

                -- 保留真正语法错误检查
                pyflakes = {
                  enabled = true,
                },
              },
            },
          },
        },
      },
    },
  },
}
