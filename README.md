# Nested

A Yazi plugin that recursively lists all files in the current directory in a virtual directory view.

Based on [modif.yazi](https://github.com/Shallow-Seek/modif.yazi).

## Requirements

- [`fd`](https://github.com/sharkdp/fd) - A simple, fast and user-friendly alternative to 'find'

## Installation

Add this plugin to your Yazi config:

1. Copy to `~/.config/yazi/plugins/`:

```sh
git clone https://github.com/jlledo/nested.yazi ~/.config/yazi/plugins/nested.yazi
```

2. Add a keybinding to `~/.config/yazi/keymap.toml`:

```toml
[[manager.prepend_keymap]]
on = "<C-n>"
run = "plugin nested.yazi"
desc = "List all nested files"
```

or

```sh
ya pkg add jlledo/nested
```

3. Restart Yazi

## Usage

1. Press the keybind (e.g. `<C-n>`) in the manager view to open a virtual directory listing all files in the current directory, recursively.

2. Navigate, operate, and preview the files as you would in any regular directory. Quit the view by press `Esc`.
