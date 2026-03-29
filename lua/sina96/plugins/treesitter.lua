return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- Treesitter parsers are managed from `lua/sina96/languages.lua`.
		local languages = require("sina96.languages")
		local parsers = {}

		for _, language in pairs(languages) do
			if language.treesitter then
				table.insert(parsers, language.treesitter)
			end
		end

		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = parsers,
			callback = function(args)
				vim.treesitter.start(args.buf)
			end,
		})
	end,
}
