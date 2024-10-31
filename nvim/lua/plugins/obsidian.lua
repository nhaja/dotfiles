return {
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		-- lazy = true,
		-- ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		--   -- refer to `:h file-pattern` for more examples
		--   "BufReadPre path/to/my-vault/*.md",
		--   "BufNewFile path/to/my-vault/*.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		opts = {
			workspaces = {
				{
					name = "notes",
					path = "~/Obsidian/Documents/Notes/",
					overrides = {
						templates = {
							folder = "~/Obsidian/Documents/Notes/99_Meta/00_Templates/",
						},
					},
				},
			},
			ui = {
				enable = false, -- set to false to disable all additional syntax features
			},
		},

		vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", { noremap = true, silent = true }),
		vim.keymap.set("n", "<leader>oo", ":ObsidianOpen<CR>", { noremap = true, silent = true }),
		vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", { noremap = true, silent = true }),
		vim.keymap.set("n", "<leader>ot", ":ObsidianNewFromTemplate<CR>", { noremap = true, silent = true }),
		vim.keymap.set("n", "<leader>oit", ":ObsidianTemplate<CR>", { noremap = true, silent = true }),
	},
}
