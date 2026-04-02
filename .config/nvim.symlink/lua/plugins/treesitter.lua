return {
  {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
      local parsers = {
        "lua",
        "luadoc",
        "query",
        "bash",
        "c",
        "diff",
        "python",
        "javascript",
        "typescript",
        "vimdoc",
        "vim",
        "regex",
        "terraform",
        "sql",
        "dockerfile",
        "toml",
        "json",
        "json5",
        "go",
        "gitignore",
        "graphql",
        "yaml",
        "make",
        "cmake",
        "markdown",
        "markdown_inline",
        "bash",
        "tsx",
        "css",
        "html",
      }
      require("nvim-treesitter").install(parsers)

      -- Highlighting
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          -- check if parser exists and load it
          if not vim.treesitter.language.add(language) then
            return
          end
          -- enables syntax highlighting and other treesitter features
          vim.treesitter.start(buf, language)

          -- enables treesitter based indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Register additional file extensions
      vim.filetype.add({ extension = { tf = "terraform" } })
      vim.filetype.add({ extension = { tfvars = "terraform" } })
    end,
  },
  {
    "https://github.com/andymass/vim-matchup",
    ---@type matchup.Config
    opts = {
      treesitter = {
        stopline = 500,
      },
    },
  },
}
