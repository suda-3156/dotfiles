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
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
          },
        },
        path_display = { "absolute" },
        color_devicons = true,
        layout_config = {
          width = 0.75,
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
        frecency = {
          show_scores = true,
          show_unindexed = true,
          ignore_patterns = {
            "*.git/*",
            "*.jj/*",
            "*.venv/*",
            "*.cache/*",
            "*.next/*",
            "node_modules/*",
            "build/*",
          },
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
    pcall(require("telescope").load_extension, "frecency")
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "live_grep_args")
    pcall(require("telescope").load_extension, "ui-select")

    -- spellchecker:off
    -- stylua: ignore start
    vim.keymap.set("n", "<leader>sb",  builtin.buffers,      { desc = "[S]earch existing [B]uffers" })
    vim.keymap.set("n", "<leader>sc",  builtin.git_commits,  { desc = "[S]earch Git [C]ommits" })
    vim.keymap.set("n", "<leader>scf", builtin.git_bcommits, { desc = "[S]earch Git [C]ommits for current [F]ile" })
    vim.keymap.set("n", "<leader>sb",  builtin.git_branches, { desc = "[S]earch Git [B]ranches" })
    vim.keymap.set("n", "<leader>ss",  builtin.git_status,   { desc = "[S]earch Git [S]tatus (diff view)" })
    vim.keymap.set("n", "<leader>sf",  builtin.find_files,   { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>sh",  builtin.help_tags,    { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sw",  builtin.grep_string,  { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg",  builtin.live_grep,    { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd",  builtin.diagnostics,  { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sr",  builtin.resume,       { desc = "[S]earch [R]resume" })
    vim.keymap.set("n", "<leader>s.",  builtin.oldfiles,     { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set("n", "<leader>s/", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "[S]earch [/] in Open Files" })
    vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        previewer = false,
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })
    -- stylua: ignore end
    -- spellchecker:on

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
