return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("render-markdown").setup({
				latex = {
					enabled = true,
				},
				link = {
					-- Turn on / off inline link icon rendering
					enabled = true,
					-- Inlined with 'image' elements
					image = "󰥶 ",
					-- Inlined with 'email_autolink' elements
					email = "󰀓 ",
					-- Fallback icon for 'inline_link' elements
					hyperlink = "󰌹 ",
					-- Applies to the fallback inlined icon
					highlight = "RenderMarkdownLink",
					-- Applies to WikiLink elements
					wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" },
					-- Define custom destination patterns so icons can quickly inform you of what a link
					-- contains. Applies to 'inline_link' and wikilink nodes.
					-- Can specify as many additional values as you like following the 'web' pattern below
					--   The key in this case 'web' is for healthcheck and to allow users to change its values
					--   'pattern':   Matched against the destination text see :h lua-pattern
					--   'icon':      Gets inlined before the link text
					--   'highlight': Highlight for the 'icon'
					custom = {
						web = { pattern = "^http[s]?://", icon = "󰖟 ", highlight = "RenderMarkdownLink" },
					},
				},
			})
		end,
	},
}
