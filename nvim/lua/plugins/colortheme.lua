return {
	"projekt0n/github-nvim-theme",
	name = "github-theme",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		local bg_transparency = false

		local toggle_transparency = function()
			bg_transparency = not bg_transparency
			require("github-theme").setup({
				options = {
					transparent = bg_transparency,
				},
			})
			vim.cmd("colorscheme github_dark")
		end

		require("github-theme").setup({
			groups = {
				all = {
					RenderMarkdownLink = { fg = "#58a6ff", bg = "" },
					RenderMarkdownMath = { fg = "#d2a8ff", bg = "" },
				},
			},

			specs = {
				all = {
					bg1 = "#24292e",
					bg3 = "#2b3036",
				},
			},
		})

		vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = true })
		vim.cmd("colorscheme github_dark")
	end,
	-- init = function()
	-- 	vim.cmd.colorscheme("github_dark")
	-- 	vim.api.nvim_create_autocmd("FileType", {
	-- 		pattern = "markdown",
	-- 		callback = function()
	-- 			vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = "#58a6ff", bg = "", bold = true })
	-- 		end,
	-- 	})
	-- end,
}
