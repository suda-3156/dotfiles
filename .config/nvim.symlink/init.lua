require 'core.options'
require 'core.keymaps'
require 'core.snippets'
require 'config.lazy'

require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
}
