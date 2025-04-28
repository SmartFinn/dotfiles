---@diagnostic disable: undefined-global
-- https://github.com/sxyazi/yazi/blob/main/yazi-plugin/preset/components/status.lua

-- Show user and hostname in top bar
Header:children_add(function()
  if ya.target_family() ~= "unix" then
    return ui.Line({})
  end
  return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("green"):bold(true)
end, 500, Header.LEFT)

-- Remove filesize from the status line
Status:children_remove(2, Status.LEFT)

-- Remove percentage from the status line
Status:children_remove(5, Status.RIGHT)

-- Remove separator from begining and add it to the end
function Status:mode()
  local mode = tostring(cx.active.mode):upper()

  local style = self:style()
  return ui.Line {
    ui.Span(" " .. mode .. " "):style(style.main),
  }
end

-- Remove separator from the end and add it to the begin
function Status:position()
  local cursor = cx.active.current.cursor
  local length = #cx.active.current.files

  local style = self:style()
  return ui.Line {
    ui.Span(string.format(" %2d/%-2d ", cursor + 1, length)):style(style.main),
  }
end

-- Show symlink path in status bar instead of filename
function Status:name()
  local h = cx.active.current.hovered
  if not h then
    return ui.Span({})
  end

  local linked = h.link_to ~= nil and  " -> " .. tostring(h.link_to) or ""
  return ui.Span(linked):fg("cyan")
end

-- Show user/group of files in status bar
Status:children_add(function()
  local h = cx.active.current.hovered

  if h == nil or ya.target_family() ~= "unix" then
    return ui.Line({})
  end

  local uid_color = h.cha.uid == 0 and "red" or (
    h.cha.uid == ya.uid() and "green" or "yellow"
  )
  local gid_color = h.cha.gid == 0 and "red" or (
    h.cha.gid == ya.gid() and "green" or "yellow"
  )

  return ui.Line({
    ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg(uid_color),
    ui.Span(":"),
    ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg(gid_color),
    ui.Span(" "),
  })
end, 100, Status.RIGHT)

-- Add item modified time to the status line
Status:children_add(function()
  local h = cx.active.current.hovered
  if not h then
    return ui.Line({})
  end

  ---@diagnostic disable-next-line: unsupport-symbol
  local time = (h.cha.mtime or 0) // 1
  return ui.Line({
    ui.Span(" " .. (time ~= 0 and os.date("%d/%m/%Y %H:%M", time) or "") .. " ")
      :fg("blue")
  })
end, 2000, Status.RIGHT)
