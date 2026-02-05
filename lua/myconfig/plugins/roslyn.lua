return {
  "seblyng/roslyn.nvim",
  ft = "cs",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Используем те же возможности (capabilities) для автодополнения
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("roslyn").setup({
      dotnet_cmd = "dotnet", -- убедись, что dotnet в PATH
      
      on_attach = function(client, bufnr)
        -- Твои бинды (как в Rider)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      end,
      capabilities = capabilities,
      
      -- Важно для Razor и крупных проектов
      choose_target = function(targets)
        -- Если проектов несколько, выберем первый или дадим выбрать тебе
        return targets[1]
      end,
    })
  end,
}
