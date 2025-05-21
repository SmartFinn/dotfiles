---@sync entry

return {
  entry = function()
    rt.mgr.show_symlink = not rt.mgr.show_symlink
    ya.render()
  end,
}
