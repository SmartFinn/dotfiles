function pip_size(t)
	local screen_x, screen_y = get_screen_geometry();
	local size = t.size or 'large'; -- large, medium, small, xsmall
	local position = t.pos or 'br'; -- tl, tr, br, bl
	local offset_x = t.offset_x or 0;
	local offset_y = t.offset_y or 0;
	local width, height, x, y;

	if size == 'medium' then
		width = math.floor(screen_x / 3.252380952);
		height = math.floor(screen_y / 3.252380952);
	elseif size == 'small' then
		width = math.floor(screen_x / 4.26875);
		height = math.floor(screen_y / 4.26875);
	elseif size == 'xsmall' then
		width = math.floor(screen_x / 4.878571429);
		height = math.floor(screen_y / 4.878571429);
	else
		-- large
		width = math.floor(screen_x / 2.72);
		height = math.floor(screen_y / 2.72);
	end

	if position == 'tr' then
		-- top-right
		x = screen_x - width - offset_x;
		y = 0 + offset_y;
	elseif position == 'tl' then
		-- top-left
		x = 0 + offset_x;
		y = 0 + offset_y;
	elseif position == 'bl' then
		-- bottom-left
		x = 0 + offset_x;
		y = screen_y - offset_y - height;
	else
		-- bottom-right
		x = screen_x - offset_x - width;
		y = screen_y - offset_y - height;
	end

	return {
		string.format("%.0f", x),
		string.format("%.0f", y),
		string.format("%.0f", width),
		string.format("%.0f", height)
	};
end

scripts_window_open = {
	"on_window_open.lua"
}
scripts_window_blur = {
	"on_window_blur.lua"
}
scripts_window_focus = {
	"on_window_focus.lua"
}
