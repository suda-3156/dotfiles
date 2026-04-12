-- From: https://github.com/nvim-lua/kickstart.nvim
--       https://github.com/ayamir/nvimdots
---@type LazyPluginSpec
return {
  "https://github.com/nvim-telescope/telescope.nvim",
  event = "VimEnter",
  dependencies = {
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",
    "https://github.com/nvim-telescope/telescope-frecency.nvim",
    "https://github.com/nvim-telescope/telescope-live-grep-args.nvim",
    {
      "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },

  config = function()
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local lga_actions = require("telescope-live-grep-args.actions")

    require("telescope").setup({
      defaults = {
        mappings = {
          n = {
            ["<Esc>"] = actions.close,
          },
          i = {
            ["<Esc>"] = actions.close,
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
          },
        },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--no-ignore",
          "--hidden",
        },
        path_display = { "absolute" },
        color_devicons = true,
        layout_config = {
          width = 0.75,
          height = 0.75,
        },
        file_ignore_patterns = {
          "%.git/",
          "%.jj/",
          "%.venv",
          "%.cache",
          "%.next",
          "node_modules",
          "build/",
        },

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      },
      extensions = {
        fzf = {
          fuzzy = false,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        live_grep_args = {
          auto_quoting = true,
          mappings = { -- extend mappings
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            },
          },
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    -- Enable telescope extensions, if installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "live_grep_args")
    pcall(require("telescope").load_extension, "ui-select")

    -- spellchecker:off
    -- stylua: ignore start
    vim.keymap.set("n", "<leader>sc",  builtin.git_commits,  { desc = "[S]earch Git [C]ommits" })
    vim.keymap.set("n", "<leader>scf", builtin.git_bcommits, { desc = "[S]earch Git [C]ommits for current [F]ile" })
    vim.keymap.set("n", "<leader>sb",  builtin.git_branches, { desc = "[S]earch Git [B]ranches" })
    vim.keymap.set('n', '<leader>sF',  function()
      builtin.find_files({ no_ignore = true, hidden = true })
    end, { desc = 'Search All Files' })
    vim.keymap.set('n', '<leader>sf',  builtin.find_files, { desc = 'Search Files (filtered)' })
    vim.keymap.set("n", "<leader>sh",  builtin.help_tags,    { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sg",  builtin.live_grep,    { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd",  builtin.diagnostics,  { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sr",  builtin.resume,       { desc = "[S]earch [R]resume" })
    vim.keymap.set("n", "<leader>s.",  builtin.oldfiles,     { desc = '[S]earch Recent Files ("." for repeat)' })
    -- stylua: ignore end
    -- spellchecker:on

    vim.keymap.set("n", "<leader>sc", function()
      builtin.find_files({
        cwd = vim.fn.expand("~/dotfiles"),
      })
    end, { desc = "Search dotfiles (config)" })
    vim.keymap.set("n", "<leader>so", function()
      builtin.find_files({
        cwd = vim.fn.expand("~/Documents/Notes/daily"),
      })
    end, { desc = "Search Obsidian daily vault" })
    vim.keymap.set("n", "<leader>sm", function()
      builtin.find_files({
        cwd = vim.fn.expand("~/Documents/Notes/main"),
      })
    end, { desc = "Search Obsidian main vault" })

    -- autocmd LSP Attach
    -- See also: lua/config/lsp.lua
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
      callback = function(event)
        local buf = event.buf

        -- Find references for the word under your cursor.
        -- spellchecker:ignore-next-line
        vim.keymap.set("n", "gR", builtin.lsp_references, { buffer = buf, desc = "[G]oto [R]eferences" })

        -- Fuzzy find all the symbols in your current document.
        -- Symbols are things like variables, functions, types, etc.
        vim.keymap.set("n", "gO", builtin.lsp_document_symbols, { buffer = buf, desc = "Open Document Symbols" })

        -- Fuzzy find all the symbols in your current workspace.
        -- Similar to document symbols, except searches over your entire project.
        vim.keymap.set(
          "n",
          "gW",
          builtin.lsp_dynamic_workspace_symbols,
          { buffer = buf, desc = "Open Workspace Symbols" }
        )

        -- Jump to the type of the word under your cursor.
        -- Useful when you're not sure what type a variable is and you want to see
        -- the definition of its *type*, not where it was *defined*.
        vim.keymap.set("n", "gt", builtin.lsp_type_definitions, { buffer = buf, desc = "[G]oto [T]ype Definition" })
      end,
    })
  end,
}
