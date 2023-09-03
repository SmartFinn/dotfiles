-- Single tabpage interface for easily cycling through diffs for all
-- modified files for any git rev
-- https://github.com/sindrets/diffview.nvim

return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy',
  cmd = {
    'DiffviewOpen',
    'DiffviewClose',
    'DiffviewToggleFiles',
    'DiffviewFocusFiles',
    'DiffviewRefresh',
    'DiffviewFileHistory',
  },
  opts = {
    -- See ':h diffview-config-enhanced_diff_hl'
    enhanced_diff_hl = true,
    view = {
      merge_tool = {
        layout = 'diff3_mixed',
      },
    },
  },
}
