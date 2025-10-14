# Morpheus.nvim

**Disclaimer:** This is a personal Neovim configuration and is not intended to be a distributable framework. It is tailored to my specific workflow and preferences.

This configuration, codenamed "Morpheus", is a modern Neovim setup built around the lightweight and powerful `mini.nvim` ecosystem. It aims for a fast, beautiful, and highly functional editing experience with a strong focus on AI-assisted development, robust language support, and an intuitive keybinding system.

## Core Philosophy

The configuration is built on a few key principles:

- **Lightweight Core:** Leverages the `mini.nvim` suite for essential functionalities like startup, file management, comments, pairs, and surrounds. This keeps the core fast and minimal.
- **Modular Design:** Plugins and their configurations are organized by feature area (e.g., `core`, `ui`, `code`, `ai`) using `lazy.nvim`'s import feature.
- **Integrated Tooling:** Aims to provide a seamless experience for common development tasks, including debugging, testing, version control, and AI interaction, directly within the editor.
- **Clear and Consistent Keybindings:** Employs a structured keybinding system to make commands easily discoverable and memorable.

## Key Features

- **Plugin Management:** Uses `lazy.nvim` for declarative plugin management.
- **AI Integration:**
    - **`codecompanion.nvim`:** Central hub for interacting with various LLMs (Gemini, Claude, GPT models).
    - **`copilot.lua`:** Integrated as a completion source.
    - **`VectorCode`:** For Retrieval-Augmented Generation (RAG) capabilities.
- **Modern UI:**
    - **Theme:** `catppuccin` (Mocha/Latte).
    - **Statusline:** `lualine.nvim` with integrations for LSP, Git, and AI status.
    - **File Explorer:** `oil.nvim`.
    - **Symbol Outline:** `aerial.nvim` for a code overview.
    - **Dashboard:** `mini.starter` provides a clean start screen.
- **Editing & Completion:**
    - **`mini.nvim` Suite:** Powers most editing enhancements (brackets, comments, pairs, etc.).
    - **`blink.cmp`:** A fast and lightweight completion engine.
    - **`nvim-treesitter`:** For advanced syntax highlighting, indentation, and text objects.
- **Language Support & LSP:**
    - **`mason.nvim`:** Manages LSP servers, DAP adapters, and linters.
    - **`nvim-lspconfig`:** Configures language servers.
    - **Debugging:** A full `nvim-dap` setup with `nvim-dap-ui` and language-specific adapters for Go, Ruby, Scala, and Lua.
    - **Testing:** `neotest` framework with adapters for Go, Ruby (RSpec/Minitest), and Scala.
- **Integrated Tools:**
    - **Git:** `neogit` provides a Magit-like interface, with `gitsigns.nvim` for hunk management.
    - **Terminal:** `toggleterm.nvim` for a floating terminal.
    - **Secrets:** `op.nvim` for 1Password integration.
    - **Markdown:** Live preview and enhanced rendering.

## Keybinding Philosophy

The keybinding system is designed to be ergonomic and easy to discover using `which-key.nvim`. It follows a clear, hierarchical pattern.

- **Global Leader (`<Space>`)**: Used for global actions that are available across all file types.
    - `f`: **Find** (files, grep, buffers, etc.)
    - `a`: **AI** (open chat, select model)
    - `v`: **Version Control** (open Neogit)
    - `e`: **Explorer** (open Oil file manager)
    - `i`: **Imenu** (toggle Aerial symbol outline)
    - `\`: **Terminal** (toggle floating terminal)

- **Local Leader (`,`)**: Used for contextual actions that are specific to the current buffer, filetype, or plugin.
    - `d`: **Debug** (toggle breakpoints, continue, step over, etc.)
    - `t`: **Test** (run nearest test, debug test, view output)
    - `,`: **"At Point" Actions** (LSP code actions, references, definitions)
    - Language-specific commands (e.g., `,m` for Metals/Scala commands).

- **Other Prefixes**:
    - `g`: **Goto** (definition, references, etc.)
    - `[` and `]`: **Previous/Next** (move between functions, classes, and other text objects via Treesitter).
