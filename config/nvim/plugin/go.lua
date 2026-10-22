vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		local client = vim.lsp.get_clients({ bufnr = 0, name = "gopls" })[1]
		if not client then
			return
		end
		local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
		params.context = { only = { "source.organizeImports" } }
		local res = client:request_sync("textDocument/codeAction", params, 3000, 0)
		for _, r in pairs(res and res.result or {}) do
			if r.edit then
				vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
			end
		end
	end,
})

vim.cmd([[
	" nnoremap <leader>tc <cmd>GoCoverageToggle<CR>
	let g:go_gopls_enabled = 0
	let g:go_def_mapping_enabled = 0

	let g:go_fmt_autosave = 1
	let g:go_mod_fmt_autosave = 1
	let g:go_imports_autosave = 1

	let g:go_highlight_array_whitespace_error = 1
	let g:go_highlight_chan_whitespace_error = 1
	let g:go_highlight_extra_types = 1
	let g:go_highlight_space_tab_error = 1
	let g:go_highlight_trailing_whitespace_error = 1
	let g:go_highlight_operators = 1
	let g:go_highlight_functions = 1
	let g:go_highlight_function_parameters = 1
	let g:go_highlight_function_calls = 1
	let g:go_highlight_types = 1
	let g:go_highlight_fields = 1
	let g:go_highlight_build_constraints = 1
	let g:go_highlight_generate_tags = 1
	let g:go_highlight_format_strings = 1
	let g:go_highlight_variable_declarations = 1
	let g:go_highlight_variable_assignments = 1
	let g:go_highlight_diagnostic_errors = 1
	let g:go_highlight_diagnostic_warnings = 1
]])
