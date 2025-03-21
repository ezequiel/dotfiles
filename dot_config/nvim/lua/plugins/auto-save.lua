return {
	"okuuva/auto-save.nvim",
	opts = {
		enabled = true,
		trigger_events = {
			immediate_save = {
				"BufLeave",
				"BufWinLeave",
				"CmdlineLeave",
				"CmdwinLeave",
				"FocusLost",
				"QuitPre",
				"VimLeave",
				"VimSuspend",
				"WinLeave",
			},
			defer_save = {
				"TextChanged",
				"TextChangedP",
				"InsertLeave",
			},
			cancel_deferred_save = { "InsertEnter" },
		},
		condition = function()
			return vim.bo.filetype ~= "qf"
		end,
		write_all_buffers = true,
	},
}
