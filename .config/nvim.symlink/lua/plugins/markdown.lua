return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ft = { 'markdown' },
  keys = {
    { '<leader>md', ':RenderMarkdown toggle<CR>' },
  },
  opts = {},
}
