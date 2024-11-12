require("lib.getOS")

-- Modifier keys default layout (CTRL, SUPER, ALT)
_G["modifier_left"] = "<C"
_G["modifier_mid"] = "<D"
_G["modifier_right"] = "<M"
-- Modifier keys layout for OSX (CTRL, OPT/ALT, CMD)
if getOS() == "OSX" then
	_G["modifier_left"] = "<C"
	_G["modifier_mid"] = "<M"
	_G["modifier_right"] = "<D"
end

local uv = vim.loop

vim.api.nvim_create_autocmd({ "VimEnter", "VimLeave" }, {
	callback = function()
		if vim.env.TMUX_PLUGIN_MANAGER_PATH then
			uv.spawn(vim.env.TMUX_PLUGIN_MANAGER_PATH .. "/tmux-window-name/scripts/rename_session_windows.py", {})
		end
	end,
})

require("core.options")
require("core.keymaps")
require("core.external")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.neotree"),
	require("plugins.colortheme"),
	require("plugins.harpoon"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
	require("plugins.lsp"),
	require("plugins.autocompletion"),
	require("plugins.null_ls"),
	require("plugins.alpha"),
	require("plugins.indent-blankline"),
	require("plugins.misc"),
	require("plugins.gitsigns"),
	require("plugins.lazygit"),
	require("plugins.obsidian"),
	require("plugins.image"),
	require("plugins.img-clip"),
	require("plugins.render-markdown"),
	require("plugins.markdown-preview"),
	require("plugins.molten"),
	require("plugins.jupytext"),
	require("plugins.remote"),
})
