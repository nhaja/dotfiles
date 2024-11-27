return {
	require("latex").setup({
		conceals = {
			enabled = {
				"greek",
				"math",
				"script",
				"delim",
				"font",
			},
			add = {},
		},
		imaps = {
			enabled = true,
			add = {},
			default_leader = "`",
		},
		surrounds = {
			enabled = false,
			command = "c",
			environment = "e",
		},
	}),
}
