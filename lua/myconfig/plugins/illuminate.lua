return {
  -- Подсветка одинаковых слов (LSP-based)
  {
    "RRethy/vim-illuminate",
    config = function()
      require('illuminate').configure({
        delay = 200,
        large_file_cutoff = 2000,
      })
    end,
  },
}  
