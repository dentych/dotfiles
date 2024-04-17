return {
    "nvim-neo-tree/neo-tree.nvim",
    event = "BufEnter",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
	    {
		    "<leader>e",
		    "<cmd>Neotree<cr>",
		    desc = "Neotree",
	    }
    },
	opts = {
		filesystem = {
            filtered_items = {
                hide_dotfiles = false,
            },
			follow_current_file = {
				enabled = true,
			},
		},
		window = {
            position = "left",
			mappings = {
				["<space>"] = "none",
                ["w"] = "none",
			},
		},
	},
}
