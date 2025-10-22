return {
	"okuuva/auto-save.nvim",
	version = "*", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
	opts = {
		trigger_events = { -- See :h events
			cancel_deferred_save = { "InsertEnter", "CursorMoved" }, -- vim events that cancel a pending deferred save
		},
	},
}
