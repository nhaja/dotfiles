-- Set lualine as statusline
return {
	"nvim-lualine/lualine.nvim",
	config = function()
		-- Adapted from: https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/themes/onedark.lua
		local colors = {
			blue = "#6cb6ff",
			green = "#7ee787",
			purple = "#d2a8ff",
			cyan = "#a5d6ff",
			red = "#f47067",
			orange = "#ffa657",
			yellow = "#d29922",
			fg = "#e1e3e8",
			bg = "#1d2124",
			gray1 = "#828997",
			gray2 = "#2c323c",
			gray3 = "#3e4452",
		}

		local github_theme = {
			normal = {
				a = { fg = colors.bg, bg = colors.red, gui = "bold" },
				b = { fg = colors.fg, bg = colors.gray2 },
				c = { fg = colors.fg, bg = colors.bg },
			},
			command = { a = { fg = colors.bg, bg = colors.orange, gui = "bold" } },
			insert = { a = { fg = colors.bg, bg = colors.green, gui = "bold" } },
			visual = { a = { fg = colors.bg, bg = colors.blue, gui = "bold" } },
			terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = "bold" } },
			replace = { a = { fg = colors.bg, bg = colors.red, gui = "bold" } },
			inactive = {
				a = { fg = colors.gray1, bg = colors.bg, gui = "bold" },
				b = { fg = colors.gray1, bg = colors.bg },
				c = { fg = colors.gray1, bg = colors.gray2 },
			},
		}

		-- Define a table of themes
		local themes = {
			github = github_theme,
		}

		local mode = {
			"mode",
			fmt = function(str)
				-- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
				return str
			end,
		}

		local filename = {
			"filename",
			file_status = true, -- displays file status (readonly status, modified status)
			path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
		}

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 100
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			colored = false,
			update_in_insert = false,
			always_visible = false,
			cond = hide_in_width,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			cond = hide_in_width,
		}

		local lsp_servers = {
			function()
				local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
				if #buf_clients == 0 then
					return "LSP Inactive"
				end

				local buf_ft = vim.bo.filetype
				local buf_client_names = {}

				-- add client
				for _, client in pairs(buf_clients) do
					if client.name ~= "copilot" and client.name ~= "null-ls" then
						table.insert(buf_client_names, client.name)
					end
				end

				-- Generally, you should use either null-ls or nvim-lint + formatter.nvim, not both.

				-- Add sources (from null-ls)
				-- null-ls registers each source as a separate attached client, so we need to filter for unique names down below.
				local null_ls_s, null_ls = pcall(require, "null-ls")
				if null_ls_s then
					local sources = null_ls.get_sources()
					for _, source in ipairs(sources) do
						if source._validated then
							for ft_name, ft_active in pairs(source.filetypes) do
								if ft_name == buf_ft and ft_active then
									table.insert(buf_client_names, source.name)
								end
							end
						end
					end
				end

				-- Add linters (from nvim-lint)
				local lint_s, lint = pcall(require, "lint")
				if lint_s then
					for ft_k, ft_v in pairs(lint.linters_by_ft) do
						if type(ft_v) == "table" then
							for _, linter in ipairs(ft_v) do
								if buf_ft == ft_k then
									table.insert(buf_client_names, linter)
								end
							end
						elseif type(ft_v) == "string" then
							if buf_ft == ft_k then
								table.insert(buf_client_names, ft_v)
							end
						end
					end
				end

				-- Add formatters (from formatter.nvim)
				local formatter_s, _ = pcall(require, "formatter")
				if formatter_s then
					local formatter_util = require("formatter.util")
					for _, formatter in ipairs(formatter_util.get_available_formatters_for_ft(buf_ft)) do
						if formatter then
							table.insert(buf_client_names, formatter)
						end
					end
				end

				-- This needs to be a string only table so we can use concat below
				local unique_client_names = {}
				for _, client_name_target in ipairs(buf_client_names) do
					local is_duplicate = false
					for _, client_name_compare in ipairs(unique_client_names) do
						if client_name_target == client_name_compare then
							is_duplicate = true
						end
					end
					if not is_duplicate then
						table.insert(unique_client_names, client_name_target)
					end
				end

				local client_names_str = table.concat(unique_client_names, "│")
				local language_servers = string.format("%s", client_names_str)

				return language_servers
			end,
			color = {
				gui = "bold",
			},
		}

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = themes["github"], -- Set theme based on environment variable
				-- Some useful glyphs:
				-- https://www.nerdfonts.com/cheat-sheet
				--        
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "neo-tree", "Avante" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { "branch" },
				lualine_c = {
					filename,
					diagnostics,
				},
				lualine_x = {
					lsp_servers,
					diff,
					{ "filetype", cond = hide_in_width },
				},
				lualine_y = { "location" },
				lualine_z = { "progress" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { { "location", padding = 0 } },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {
				"fugitive",
				"lazy",
			},
		})
	end,
}
