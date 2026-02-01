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
      cs = { "csharpier" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettier" },
      css = { "prettier" },
    },
    -- ВЫКЛЮЧАЕМ авто-формат при сохранении
    format_on_save = false, 
  },
}
