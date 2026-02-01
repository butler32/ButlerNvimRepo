return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim", -- Добавили сюда
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- 1. PATH Setup
			local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
			if not string.find(vim.env.PATH, mason_bin) then
				vim.env.PATH = mason_bin .. (vim.fn.has("win32") == 1 and ";" or ":") .. vim.env.PATH
			end

			-- 2. Mason Core
			require("mason").setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
			})

			-- 3. LSP Config
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"cssls",
					"html",
					"dockerls",
					"jsonls",
					"lemminx",
				},
			})

			-- 4. Tool Installer (тот самый блок, который вызвал ошибку)
			require("mason-tool-installer").setup({
				ensure_installed = {
					"csharpier",
					"prettier",
					"stylua",
					"netcoredbg",
				},
				auto_update = true,
				run_on_start = true,
			})

			-- 5. Native LSP Setup (Neovim 0.11+)
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local servers = { "lua_ls", "ts_ls", "cssls", "html", "dockerls", "jsonls", "lemminx" }

			for _, server_name in ipairs(servers) do
				vim.lsp.enable(server_name, {
					capabilities = capabilities,
					settings = server_name == "lua_ls" and {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = { checkThirdParty = false },
						},
					} or nil,
				})
			end

			-- 6. Diagnostics (иконки и оформление)
			local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌵 ", Info = "󰋽 " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			vim.diagnostic.config({
				virtual_text = false,
				update_in_insert = false,
				underline = true,
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
