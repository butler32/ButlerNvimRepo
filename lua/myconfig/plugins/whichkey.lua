--lua/myconfig/plugins/whichkey.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- Настройки иконок и оформления
    icons = {
      group = " ", -- Символ перед названием группы
      separator = "➜", -- Разделитель между клавишей и описанием
    },
    win = {
      border = "rounded", -- Скругленные края панели
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Регистрируем структуру меню для <leader>
    wk.add({
      { "<leader>f", group = "󰈞 find/file" },
      { "<leader>c", group = "󰅩 code" },
      { "<leader>d", group = "󰃤 debug/diag" },
      { "<leader>g", group = "󰊢 git" },
      { "<leader>h", group = "󰊢 git hunks" }, -- Для gitsigns
      { "<leader>s", group = "󰓫 window split" },
      { "<leader>l", group = "󰡨 docker" },
      { "<leader>x", group = "󰒬 trouble" },
      { "<leader>b", group = "󰓗 buffers/breakpoints" },
      { "<leader>n", group = "󰎟 no highlight" },
    })
  end,
}
