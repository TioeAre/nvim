local M = require("plugin_config.tree")

return {
    -- tree explore
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        config = M.config_nvim_tree,
        keys = M.keys_nvim_tree,
    },
    -- {
    -- 	"nvim-neo-tree/neo-tree.nvim",
    -- 	lazy = false,
    -- 	branch = "v3.x",
    -- 	dependencies = {
    -- 	  "nvim-lua/plenary.nvim",
    -- 	  "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    -- 	  "MunifTanjim/nui.nvim",
    -- 	  "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    -- 	},
    -- 	config = M.config_neo_tree,
    -- },
    -- outline
    {
        "simrat39/symbols-outline.nvim",
        cmd = "SymbolsOutline",
        opts = M.opts_outline,
        config = M.config_outline,
    },
    -- project in trees
    {
        "ahmedkhalf/project.nvim",
        config = M.config_project,
    },
}
