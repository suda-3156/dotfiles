return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {},
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    -- Usage:
    -- Before        Input         After
    -- ------------------------------------
    -- <div           >              <div></div>
    -- <div></div>    ciwspan<esc>   <span></span>
    -- ------------------------------------
  },
}
