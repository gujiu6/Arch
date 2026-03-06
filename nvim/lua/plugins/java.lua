return {
  -- ===============================
  -- Java LSP 配置 (使用新版 Snacks 钩子)
  -- ===============================
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      -- 1. 注入自定义设置
      opts.jdtls = vim.tbl_deep_extend("force", opts.jdtls or {}, {
        settings = {
          java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
          },
        },
      })

      -- 2. 修复 Deprecated 警告，使用新版 on_attach 方式
      -- 这部分会自动处理快捷键和禁用格式化逻辑
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "jdtls" then
            -- ❌ 禁用 LSP 自动格式化
            client.server_capabilities.documentFormattingProvider = false

            -- 快捷键映射
            local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
            end

            map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
            map("n", "gr", vim.lsp.buf.references, "References")
            map("n", "K", vim.lsp.buf.hover, "Hover")
            map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
            map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
          end
        end,
      })
    end,
  },

  -- ===============================
  -- 禁用自动 format (conform)
  -- ===============================
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = false,
    },
  },

  -- ===============================
  -- F5 运行逻辑 & 缩进配置
  -- ===============================
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- Java 专用 4 空格缩进
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          vim.opt_local.tabstop = 4
          vim.opt_local.shiftwidth = 4
          vim.opt_local.expandtab = true
          vim.opt_local.softtabstop = 4
        end,
      })

      -- F5 快捷键映射
      vim.keymap.set("n", "<F5>", function()
        local file = vim.fn.expand("%")
        local name = vim.fn.expand("%:t:r")
        vim.cmd("write")
        -- 使用 split 开启终端运行
        vim.cmd("split | term javac " .. file .. " && java " .. name)
      end, { desc = "Run Java File" })
    end,
  },
}
