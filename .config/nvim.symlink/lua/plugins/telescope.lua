-- From: kickstart.nvim
---@type LazyPluginSpec
return {
  "https://github.com/nvim-telescope/telescope.nvim",
  event = "VimEnter",
  dependencies = {
    "https://github.com/nvim-lua/plenary.nvim",
    {
      "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    -- "https://github.com/nvim-telescope/telescope-frecency.nvim",
    {
      "Allianaab2m/telescope-kensaku.nvim",
      config = function()
        require("telescope").load_extension("kensaku") -- :Telescope kensaku
        vim.keymap.set("n", "<leader>ng", "<cmd>Telescope kensaku<cr>", { desc = "[N]ihongo [G]rep" })
      end,
    },
  },

  config = function()
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    -- require("telescope").load_extension("frecency")
    --
    -- require("frecency.config").setup({
    --   auto_validate = true,
    --   ignore_patterns = { "*/.git", "*/.git/*", "*/.jj", "*/.jj/*", "*/.DS_Store" },
    --   matcher = "fuzzy",
    -- })

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
        layout_config = {
          width = 0.75,
        },
        file_ignore_patterns = {
          "%.git/",
          "%.jj/",
          "%.venv",
          "%.next",
          "node_modules",
          "%vendor",
        },
      },

      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
        },

        buffers = {
          initial_mode = "normal",
          sort_lastused = true,
        },
      },

      live_grep = {
        additional_args = function(_)
          return { "--hidden" }
        end,
      },

      path_display = {
        filename_first = {
          reverse_directories = true,
        },
      },

      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },

      git_files = {
        previewer = false,
        git_command = { "git", "ls-files", "--exclude-standard", "--cached", "--others" },
      },
    })

    -- Enable telescope fzf native, if installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
    vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch existing [B]uffers" })
    vim.keymap.set("n", "<leader>sc", builtin.git_commits, { desc = "[S]earch Git [C]ommits" })
    vim.keymap.set("n", "<leader>scf", builtin.git_bcommits, { desc = "[S]earch Git [C]ommits for current [F]ile" })
    vim.keymap.set("n", "<leader>sb", builtin.git_branches, { desc = "[S]earch Git [B]ranches" })
    vim.keymap.set("n", "<leader>ss", builtin.git_status, { desc = "[S]earch Git [S]tatus (diff view)" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]resume" })
    vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
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

    -- autocmd LSP Attach
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
      callback = function(event)
        local buf = event.buf

        -- Find references for the word under your cursor.
        vim.keymap.set("n", "grr", builtin.lsp_references, { buffer = buf, desc = "[G]oto [R]eferences" })

        -- Jump to the implementation of the word under your cursor.
        -- Useful when your language has ways of declaring types without an actual implementation.
        vim.keymap.set("n", "gri", builtin.lsp_implementations, { buffer = buf, desc = "[G]oto [I]mplementation" })

        -- Jump to the definition of the word under your cursor.
        -- This is where a variable was first declared, or where a function is defined, etc.
        -- To jump back, press <C-t>.
        vim.keymap.set("n", "grd", builtin.lsp_definitions, { buffer = buf, desc = "[G]oto [D]efinition" })

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
        vim.keymap.set("n", "grt", builtin.lsp_type_definitions, { buffer = buf, desc = "[G]oto [T]ype Definition" })
      end,
    })
  end,
}
