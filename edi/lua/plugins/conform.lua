return {
	{
		"stevearc/conform.nvim",
		lazy = false,
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
				},
				default_format_opts = {
					lsp_format = "fallback",
				},
			})
		end,
	},
}
