# Morpheus NVIM

This is my neovim configuration which I started with the awesome kickstart.nvim packaged and configured it to what I need.

## Decisions

0. It's about using the editor, not about the configuration
1. Limit the number of plugins to the ones I really need
2. Keybindings are only used for the most commonly used commands (the rest will be done via the command bar)

### Keybindings

Everyone comes up with their own keybindings schemes, that make sense to them.
I'm not different I employ the following principles

1. Global commands are availabe via `<leader>`
2. Mode specific global commands are available via `<localleader>` (sometimes more than one mode is present in which I case I make a judgement call)
3. Commands at point are available via `<localleader>,`
4. Minimize usage of the g prefix, since it's used by many builtins and plugins

There are some groups that are shared between the at_point commands and the global commands which I tend to re-use.
Most notably for `goto`, `search`, `ai` etc.
