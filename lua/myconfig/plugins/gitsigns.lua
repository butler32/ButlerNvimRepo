return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Навигация по изменениям
        map("n", "]h", function() gs.nav_hunk("next") end, { desc = "Next Git Hunk" })
        map("n", "[h", function() gs.nav_hunk("prev") end, { desc = "Prev Git Hunk" })

        -- Действия
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Git Blame" })
      end,
    })
  end,
}
