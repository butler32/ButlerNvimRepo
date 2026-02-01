return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- 1. PRE-REQUISITE: Add Mason's bin folder to Neovim's PATH 
      -- This fixes the "Spawning language server failed" error
      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
      if not string.find(vim.env.PATH, mason_bin) then
        vim.env.PATH = mason_bin .. (vim.fn.has("win32") == 1 and ";" or ":") .. vim.env.PATH
      end

      -- 2. Mason Core Setup
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
      })

      -- 3. Mason-LSPConfig (Ensures binaries are downloaded)
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", "ts_ls", "cssls", "html", "dockerls", "jsonls", "lemminx"
        },
      })

      -- 4. NEW: Native Neovim 0.11 LSP Setup
      -- We no longer require('lspconfig'). We use the native vim.lsp.enable
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local servers = { "lua_ls", "ts_ls", "cssls", "html", "dockerls", "jsonls", "lemminx" }

      for _, server_name in ipairs(servers) do
        -- This is the modern 0.11+ way to enable servers
        -- It avoids the deprecated 'lspconfig' framework warning
        vim.lsp.enable(server_name, {
          capabilities = capabilities,
          -- For lua_ls specific settings:
          settings = server_name == "lua_ls" and {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          } or nil
        })
      end

      local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌵 ", Info = "󰋽 " }
      for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.diagnostic.config({
          virtual_text = false,
          update_in_insert = false,
          uderline = true,
          severity_sort = true,
          float = {
              focused = true,
              style = "minimal",
              border = "rounded",
              source = "always",
              header = "",
              prefix = "",
          },
      })

      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostic" })
    end,
  },
}
