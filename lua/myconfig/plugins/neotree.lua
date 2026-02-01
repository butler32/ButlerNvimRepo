return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            window = {
                mappings = {
                    ["<space>"] = "none",

                    ["l"] = "open",
                    ["h"] = function(state)
                        local node = state.tree:get_node()
                        if node.type == 'directory' and node:is_expanded() then
                            require('neo-tree.sources.filesystem.commands').toggle_node(state)
                        else
                            require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
                        end
                    end,
                },
            },
            filesystem = {
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
            },
        })

        vim.keymap.set("n", "<leader>e", ":Neotree toggle reveal left<CR>", { desc = "Toggle Explorer" })
    end,
}
