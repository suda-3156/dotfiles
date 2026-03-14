return {
  {
    "https://github.com/windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {},
  },
  {
    "https://github.com/windwp/nvim-ts-autotag",
    event = "InsertEnter",
    -- Usage:
    -- Before        Input         After
    -- ------------------------------------
    -- <div           >              <div></div>
    -- <div></div>    ciwspan<esc>   <span></span>
    -- ------------------------------------
  },
}
