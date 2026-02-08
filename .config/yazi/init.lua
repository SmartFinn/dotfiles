---@diagnostic disable: undefined-global

require("yatline"):setup({
  style_a = { fg = "black", bg_mode = {
    normal = "#3daee9",
    select = "#fdbc4b",
    un_set = "#fdbc4b",
  } },
  style_b = { bg = "#4d4d4d", fg = "#eff0f1" },
  style_c = { bg = "#31363b", fg = "#95a5a6" },

  selected = { icon = "󰻭", fg = "yellow" },
  copied = { icon = "", fg = "green" },
  cut = { icon = "", fg = "red" },

  total = { icon = "󰮍", fg = "yellow" },
  succ = { icon = "", fg = "green" },
  fail = { icon = "", fg = "red" },
  found = { icon = "󰮕", fg = "blue" },
  processed = { icon = "󰐍", fg = "green" },

  show_background = false,

  header_line = {
    left = {
      section_a = {
        {type = "line", custom = false, name = "tabs", params = {"left"}},
      },
      section_b = {
      },
      section_c = {
      }
    },
    right = {
      section_a = {
      },
      section_b = {
      },
      section_c = {
        {type = "coloreds", custom = false, name = "task_states"},
        {type = "coloreds", custom = false, name = "count"},
      }
    }
  },

  status_line = {
    left = {
      section_a = {
        {type = "string", custom = false, name = "tab_mode"},
      },
      section_b = {
      },
      section_c = {
        {type = "coloreds", custom = false, name = "symlink_target"}
      }
    },
    right = {
      section_a = {
        {type = "string", custom = false, name = "cursor_percentage"},
      },
      section_b = {
        {type = "string", custom = false, name = "cursor_position"},
      },
      section_c = {
        {type = "coloreds", custom = false, name = "permissions"},
        {type = "string", custom = false, name = "hovered_ownership"},
        {type = "string", custom = false, name = "modified_time"},
        {type = "string", custom = false, name = "hovered_size"},
      }
    }
  },
})

require("yatline-modified-time"):setup()
require("yatline-symlink-target"):setup()
require("folder-rules"):setup()
