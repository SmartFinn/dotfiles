local function setup(_)
  if Yatline == nil then
    return
  end

  function Yatline.string.get:modified_time()
    local hovered = cx.active.current.hovered

    if not hovered then
      return
    end

    return os.date("%Y-%m-%d %H:%M", hovered.cha.mtime // 1)
  end
end

return { setup = setup }
