vim.cmd("syntax off")

vim.api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	command = "wincmd =",
})

local commands = {
	E = "e",
	W = "w",
	Wq = "wq",
	WQ = "wq",
	Wa = "wa",
	WA = "wa",
	WAq = "waq",
	WAQ = "waq",
	Waq = "waq",
	WQa = "wqa",
	Wqa = "wqa",
	WQA = "wqa",
	Q = "q",
	QA = "qa",
	Qa = "qa",
}

for cmd, action in pairs(commands) do
	vim.api.nvim_create_user_command(cmd, action .. "<bang> <args>", {
		bang = true,
		nargs = "?",
		complete = "file",
	})
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "Avante", "trouble", "norg" },
	callback = function()
		vim.opt.conceallevel = 3
	end,
})

vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
	desc = "Highlight the cursor line in the active window",
	pattern = "*",
	command = "setlocal cursorline",
})

vim.api.nvim_create_autocmd("WinLeave", {
	desc = "Clear the cursor line highlight when leaving a window",
	pattern = "*",
	command = "if &bt != 'quickfix' | setlocal nocursorline | endif",
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "VimEnter", "WinEnter", "BufWinEnter" }, {
	command = "checktime",
	pattern = "*",
})
