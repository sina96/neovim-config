# Neovim Config

Personal Neovim configuration built on `lazy.nvim`.

This config is organized around a few shared registry files so it is easier to
move to a new machine and easier to maintain over time.

## Stack

- Plugin manager: `lazy.nvim`
- Theme: `aura-dark`
- LSP: `nvim-lspconfig` + `mason.nvim` + `mason-lspconfig.nvim`
- Completion: `nvim-cmp` + `LuaSnip`
- Treesitter: `nvim-treesitter`
- Formatting / linting: `none-ls.nvim` + `none-ls-extras.nvim`
- Debugging: `nvim-dap` + `nvim-dap-ui` + `mason-nvim-dap.nvim`
- File explorer: `neo-tree.nvim`
- Finder: `telescope.nvim`
- Dashboard: `dashboard-nvim`
- Git: `gitsigns.nvim` + `vim-fugitive` + `lazygit.nvim`
- Keymap discovery: `which-key.nvim`

## Install

1. Install Neovim.
2. Clone this config into `~/.config/nvim`.
3. Start Neovim with:

```sh
nvim
```

`lazy.nvim` will bootstrap itself automatically.

After startup, run:

```vim
:Lazy sync
```

## External Tools

Some plugins only connect Neovim to external binaries. Those tools still need
to exist on your system, either through Mason or your package manager.

Common tools used by this config:

- LSP servers via Mason:
  - `lua_ls`
  - `ts_ls`
  - `pyright`
  - `gopls`
  - `yamlls`
  - `sqls`
- Formatters / linters:
  - `stylua`
  - `prettier`
  - `eslint_d`
  - `black`
  - `isort`
  - `gofumpt`
  - `golangci-lint`
- Debuggers:
  - `delve` / `dlv`
- Git terminal UI:
  - `lazygit`

Useful checks:

- `:Mason`
- `:checkhealth`
- `:DapHealthcheck`

## Entry Points

- [init.lua](/Users/sinabastani/.config/nvim/init.lua)
- [lua/sina96/init.lua](/Users/sinabastani/.config/nvim/lua/sina96/init.lua)
- [lua/sina96/lazy_init.lua](/Users/sinabastani/.config/nvim/lua/sina96/lazy_init.lua)

`init.lua` loads the `sina96` module.

`lua/sina96/init.lua` contains basic editor options like:

- leader key
- line numbers
- 2-space indentation

`lazy_init.lua` bootstraps `lazy.nvim` and loads plugin specs from:

- [lua/sina96/plugins](/Users/sinabastani/.config/nvim/lua/sina96/plugins)

## How It Is Organized

This config separates plugin setup from language and tool registries.

### Plugin Specs

Each plugin area has its own file under:

- [lua/sina96/plugins](/Users/sinabastani/.config/nvim/lua/sina96/plugins)

Examples:

- [aura.lua](/Users/sinabastani/.config/nvim/lua/sina96/plugins/aura.lua)
- [lsp-config.lua](/Users/sinabastani/.config/nvim/lua/sina96/plugins/lsp-config.lua)
- [none-ls.lua](/Users/sinabastani/.config/nvim/lua/sina96/plugins/none-ls.lua)
- [debugging.lua](/Users/sinabastani/.config/nvim/lua/sina96/plugins/debugging.lua)
- [git.lua](/Users/sinabastani/.config/nvim/lua/sina96/plugins/git.lua)

### Shared Registries

These files are the main place to edit supported languages and tools:

- [languages.lua](/Users/sinabastani/.config/nvim/lua/sina96/languages.lua)
- [formatters.lua](/Users/sinabastani/.config/nvim/lua/sina96/formatters.lua)
- [debuggers.lua](/Users/sinabastani/.config/nvim/lua/sina96/debuggers.lua)

They work like this:

- `languages.lua`
  - controls Treesitter parsers
  - controls enabled LSP servers
  - LSP server configs live in `lua/sina96/lsp/`
- `formatters.lua`
  - controls `none-ls` formatting and diagnostics sources
  - keeps `formatting` and `diagnostics` separate
- `debuggers.lua`
  - controls DAP adapters to install through Mason
  - points to language-specific DAP setup modules in `lua/sina96/dap/`

### Language-Specific Modules

LSP modules live here:

- [lua/sina96/lsp](/Users/sinabastani/.config/nvim/lua/sina96/lsp)

Examples:

- [lua_ls.lua](/Users/sinabastani/.config/nvim/lua/sina96/lsp/lua_ls.lua)
- [ts_ls.lua](/Users/sinabastani/.config/nvim/lua/sina96/lsp/ts_ls.lua)
- [pyright.lua](/Users/sinabastani/.config/nvim/lua/sina96/lsp/pyright.lua)
- [gopls.lua](/Users/sinabastani/.config/nvim/lua/sina96/lsp/gopls.lua)

DAP modules live here:

- [lua/sina96/dap](/Users/sinabastani/.config/nvim/lua/sina96/dap)

Current example:

- [go.lua](/Users/sinabastani/.config/nvim/lua/sina96/dap/go.lua)

## Theme Notes

The config uses `aura-dark` and applies extra highlight overrides so some
plugins visually match the theme better:

- Neo-tree popup input
- Dashboard
- `nvim-cmp`
- `nvim-dap-ui`
- Git signs
- LazyGit float window

## Keymaps

Leader is:

```text
Space
```

Keymaps are discoverable through `which-key.nvim`.

Current top-level groups:

- `<leader>c` code
- `<leader>d` debug
- `<leader>f` file
- `<leader>g` git
- `<leader>p` project

Examples:

- `<leader>ff` format file
- `<leader>ca` code action
- `<leader>gg` open LazyGit
- `<leader>gs` Git status
- `<leader>dc` debug continue
- `<leader>dh` DAP healthcheck
- `<leader>pf` find files

## Common Maintenance

### Add a New Language

1. Edit [languages.lua](/Users/sinabastani/.config/nvim/lua/sina96/languages.lua)
2. Add the Treesitter parser and/or LSP server
3. If using LSP, add a matching file in `lua/sina96/lsp/`

Example:

```lua
python = {
    treesitter = "python",
    lsp = "pyright",
}
```

### Add a New Formatter or Linter

1. Edit [formatters.lua](/Users/sinabastani/.config/nvim/lua/sina96/formatters.lua)
2. Add it under `formatting` or `diagnostics`
3. If it comes from `none-ls-extras.nvim`, use the metadata table form

Example:

```lua
javascript = {
    formatting = { "prettier" },
    diagnostics = {
        { name = "eslint", extras = true, command = "eslint_d" },
    },
}
```

### Add a New Debugger

1. Edit [debuggers.lua](/Users/sinabastani/.config/nvim/lua/sina96/debuggers.lua)
2. Add the Mason adapter name
3. If needed, add a setup module under `lua/sina96/dap/`

Example:

```lua
go = {
    adapter = "delve",
    setup = "go",
}
```

## Git / Moving Machines

This config is designed to be pushed to GitHub and reused on a new machine.

Suggested flow on a new Mac:

1. Install Neovim
2. Clone this repo to `~/.config/nvim`
3. Start `nvim`
4. Run `:Lazy sync`
5. Install missing external tools through Mason and your package manager

If something looks installed but does not work, first check:

- `:Mason`
- `:checkhealth`
- `:messages`
- `:DapHealthcheck`
