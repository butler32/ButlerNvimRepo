-- Настройка компилятора
require('nvim-treesitter.install').compilers = { "gcc" }

local configs = require("nvim-treesitter.configs")

configs.setup({
    ensure_installed = {
        "c_sharp", "lua", "vim", "vimdoc", "javascript",
        "html", "css", "python", "go", "cpp", "c",
        "sql", "dockerfile", "json", "xml", "rust"
        -- "razor" часто вызывает ошибки установки, если нет CLI tools, 
        -- но C# и HTML обычно достаточно для cshtml.
        -- Если подсветка cshtml будет плохой, можно попробовать добавить "razor" вручную позже.
    },
    highlight = { 
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
})
