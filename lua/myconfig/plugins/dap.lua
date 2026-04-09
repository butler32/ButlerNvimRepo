return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    -- Автоматическое открытие/закрытие окон отладки
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- 1. Настройка адаптера для C/C++ (codelldb)
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
      },
    }

    dap.configurations.c = {
      {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
    dap.configurations.cpp = dap.configurations.c

    -- 2. Настройка адаптера для C# (NetCoreDbg)
    dap.adapters.coreclr = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
      args = { "--interpreter=vscode" },
    }

    -- 2. Конфигурация запуска
    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          -- Ищем файлы .dll в папках bin/Debug
          local dlls = vim.fn.glob(vim.fn.getcwd() .. "/bin/Debug/**/*.dll", false, true)
          if #dlls == 1 then
            return dlls[1]
          elseif #dlls > 1 then
            return vim.fn.input("Path to dll: ", dlls[1], "file")
          else
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end
        end,
      },
    }

    -- 3. Красивые иконки для брейкпоинтов
    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )

    -- 4. Горячие клавиши
    vim.keymap.set("n", "<F5>", function()
      dap.continue()
    end, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<F10>", function()
      dap.step_over()
    end, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F11>", function()
      dap.step_into()
    end, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<leader>b", function()
      dap.toggle_breakpoint()
    end, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dr", function()
      dap.repl.open()
    end, { desc = "Debug: Open REPL" })
    vim.keymap.set("n", "<leader>du", function()
      dapui.toggle()
    end, { desc = "Debug: Toggle UI" })
  end,
}
