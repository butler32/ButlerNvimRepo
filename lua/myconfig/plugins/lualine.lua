return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Кастомные названия режимов и их иконки
    local mode_map = {
      ['n']      = '󰭩 NORMAL',
      ['i']      = '󰏫 INSERT',
      ['v']      = '󰈈 VISUAL',
      ['V']      = '󰈈 V-LINE',
      ['\22']   = '󰈈 V-BLOCK',
      ['c']      = '󰘳 COMMAND',
      ['s']      = '󰒅 SELECT',
      ['S']      = '󰒅 S-LINE',
      ['\19']   = '󰒅 S-BLOCK',
      ['R']      = '󰛔 REPLACE',
      ['t']      = '󰙯 TERMINAL',
    }

    require('lualine').setup({
      options = {
        theme = 'auto', -- Он сам подстроится под твою цветовую схему
        component_separators = { left = '󰇝', right = '󰇝' },
        section_separators = { left = '', right = '' }, -- Красивые скошенные углы
        globalstatus = true, -- Одна полоса на все окна
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function() return mode_map[vim.api.nvim_get_mode().mode] or vim.api.nvim_get_mode().mode end,
            gui = 'bold',
          }
        },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } }, -- path = 1 показывает относительный путь
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
    })
  end,
}
