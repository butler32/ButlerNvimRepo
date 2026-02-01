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
            sources = {
                "filesystem",
                "buffers",
                "git_status",
            },
            source_selector = {
                winbar = true,
                statusline = false,
            },
            window = {
                mappings = {
                    ["<space>"] = "none",

                    ["<tab>"] = "next_source",
                    ["<s-tab>"] = "prev_source",

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
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
            default_component_configs = {
                git_status = {
                    symbols = {
                        added     = "✚",
                        modified  = "",
                        deleted   = "✖",
                        renamed   = "󰁕",
                        untracked = "",
                        ignored   = "",
                        unstaged  = "󰄱",
                        staged    = "",
                        conflict  = "",
                    },
                },
            },
        })

        vim.keymap.set("n", "<leader>e", ":Neotree toggle reveal left<CR>", { desc = "Toggle Explorer" })
        vim.keymap.set("n", "<leader>be", ":Neotree buffers reveal float<CR>", { desc = "Toggle Buffers" })
        vim.keymap.set("n", "<leader>ge", ":Neotree git_status reveal left<CR>", { desc = "Toggle Git" })
    end,
}
