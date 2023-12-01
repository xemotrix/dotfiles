require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  sync_install = false,
  auto_install = true,
  -- ignore_install = { "javascript" },
  highlight = {
    enable = true,
    -- disable = { "go", "heex", "eex" },
    disable = { "go" },
  },
}
