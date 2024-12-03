-- local x, y, w, h = get_window_geometry();
local app_name = get_application_name();
local wm_role = get_window_role();
local wm_class = get_window_class();
local inst_name = get_class_instance_name() or "";
local screen_x, screen_y = get_screen_geometry();
local aspect_ratio = screen_x / screen_y;

debug_print("Screen geomentry: " .. screen_x .. ", " .. screen_y)
debug_print("Application name: " .. app_name);
debug_print("Window class: "     .. wm_class);
debug_print("Instance name: "    .. inst_name);
debug_print("Window role: "      .. wm_role);

-- set_window_strut(50, 0, 26, 0)

if (get_window_type() == "WINDOW_TYPE_NORMAL") then
	if (inst_name == 'org.gnome.Nautilus') then
		-- place at top right
		set_window_position(0, 0);
	end

	if (wm_class == 'kitty')
	or (wm_class == 'Alacritty')
	or (wm_class == 'Gnome-terminal')
	then
		-- place at bottom left
		set_window_position(0, screen_y);
	end

	if ((wm_role == 'browser')
	or (wm_role == 'browser-window'))
	and (screen_x <= 1366)
	then
		maximize();
	end

	if ((wm_class == 'Spotify')
	or (wm_class == 'DB Browser for SQLite'))
	and (screen_x <= 1366)
	then
		undecorate_window();
		maximize();
	end

	if (wm_class == 'TelegramDesktop') then
		-- place at bottom right
		set_window_position(screen_x, screen_y);
	end
end

if (app_name == 'Picture in picture' or wm_role == 'PictureInPicture') then
	if (aspect_ratio > 1.0 and aspect_ratio < 2.0) then
		set_window_geometry(screen_x, screen_y, screen_x / 2.72, screen_y / 2.72);
	else
		set_window_geometry(screen_x, screen_y, 480, 320);
	end
	stick_window();
	-- set_skip_tasklist(true);
	set_skip_pager(true);
end

-- if (inst_name == 'mpv-pip') then
-- 	stick_window();
-- 	set_skip_tasklist(true);
-- 	set_skip_pager(true);
-- end
