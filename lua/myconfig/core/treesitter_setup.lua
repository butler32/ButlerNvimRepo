-- Настройка компилятора
require('nvim-treesitter.install').compilers = { "zig" }

local configs = require("nvim-treesitter.configs")

configs.setup({
    ensure_installed = {
        "c_sharp", "lua", "vim", "vimdoc", "javascript",
        "html", "css", "python", "go", "cpp", "c",
        "sql", "dockerfile"
    },
    highlight = { 
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
})
