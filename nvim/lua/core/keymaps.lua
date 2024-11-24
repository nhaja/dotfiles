-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable spacebar default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local opts = { noremap = false, silent = true }

-- save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- close file
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", opts)
-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>x", ":Bdelete!<CR>", opts)   -- close buffer
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts) -- new buffer
vim.keymap.set("n", "<C-o>", "<C-o>", opts)
vim.keymap.set("n", "<C-i>", "<C-i>", opts)

-- Increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>", opts) -- increment
vim.keymap.set("n", "<leader>-", "<C-x>", opts) -- decrement

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts)      -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts)      -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts)     -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts) -- close current split window

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts)   -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts)     --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts)     --  go to previous tab

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move text up and down
vim.keymap.set("v", "<C-j>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<C-k>", ":m .-2<CR>==", opts)

-- Redo
vim.keymap.set("n", "<C-r>", "<C-r>", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Explicitly yank to system clipboard (highlighted and entire row)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Toggle diagnostics
local diagnostics_active = true

vim.keymap.set("n", "<leader>do", function()
	diagnostics_active = not diagnostics_active

	if diagnostics_active then
		vim.diagnostic.enable(true)
	else
		vim.diagnostic.enable(false)
	end
end)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Save and load session
vim.keymap.set("n", "<leader>ss", ":mksession! .session.vim<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>sl", ":source .session.vim<CR>", { noremap = true, silent = false })

-- Move up and down in commandline suggestions
vim.keymap.set("c", "<C-j>", "<C-n>", opts)
vim.keymap.set("c", "<C-k>", "<C-p>", opts)
