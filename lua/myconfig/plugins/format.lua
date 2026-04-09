return {
  "stevearc/conform.nvim",
  -- Загружаем плагин только когда вызываем команду или нажимаем клавиши
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>F",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "n",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- clang-format: часть LLVM, не устанавливается через Mason.
      -- Если установлен системно (winget install LLVM.LLVM), будет найден в PATH.
      -- Иначе форматирование идёт через clangd (lsp_fallback).
      c = { "clang-format" },
      cpp = { "clang-format" },
      cs = { "csharpier" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettier" },
      css = { "prettier" },
      python = { "black" },
      rust = { "rustfmt" },
    },
    -- ВЫКЛЮЧАЕМ авто-формат при сохранении
    format_on_save = false, 
  },
}
