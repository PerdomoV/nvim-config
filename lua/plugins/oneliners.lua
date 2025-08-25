return {
    { -- To copy to clippboard within an SSH tunnel
	"ojroques/nvim-oscyank",
    },
    { -- Git plugin
	"tpope/vim-fugitive",
    },
    { -- Show css colors
	"brenoprata10/nvim-highlight-colors",
	config = function()
	    require("nvim-highlight-colors").setup({})
	end
    },
    { -- Surround
	"kylechui/nvim-surround",
	version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
	    require("nvim-surround").setup({
		-- Configuration here, or leave empty to use defaults
	    })
	end
    }
}



