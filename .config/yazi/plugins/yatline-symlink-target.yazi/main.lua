function hovered()
  local hovered = cx.active.current.hovered
  if hovered then
    return hovered
  else
    return ""
  end
end

local function setup(_, options)
  if Yatline == nil then
    return
  end

  options = options or {}

  local config = {
    symlink_target_color = options.symlink_target_color or "cyan",
  }

  function Yatline.coloreds.get:symlink_target()
    local h = hovered()

    if not h.link_to then
      return {}
    end

    local symlink_target = {}
    local linked = " -> " .. tostring(h.link_to)

    table.insert(symlink_target, { linked, config.symlink_target_color })
    return symlink_target
  end
end

return { setup = setup }
