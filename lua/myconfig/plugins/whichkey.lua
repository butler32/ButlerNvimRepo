return {
  "folke/which-key.nvim",
  event = "VeryLazy", -- Грузим только когда начинаем нажимать клавиши
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300 -- Панель появится через 300мс после нажатия
  end,
  opts = {
    -- Твои настройки оформления (можно оставить пустыми для дефолта)
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    
    -- Регистрируем группы, чтобы было красиво (например, <leader>e - Explorer)
    wk.add({
      { "<leader>f", group = "file" },
      { "<leader>c", group = "code" }, -- Сюда пойдут Code Actions
      { "<leader>rn", name = "Rename" },
    })
  end,
}
