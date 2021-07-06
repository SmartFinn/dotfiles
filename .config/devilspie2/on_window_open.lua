local x, y, w, h = get_window_geometry();
local app_name = get_application_name();
local wm_role = get_window_role();
local wm_class = get_window_class();
local inst_name = get_class_instance_name() or "";

debug_print("Application name: " .. app_name);
debug_print("Window class: "     .. wm_class);
debug_print("Instance name: "    .. inst_name);
debug_print("Window role: "      .. wm_role);

-- set_window_strut(50, 0, 26, 0)

if (wm_class == 'kitty')
or (wm_class == 'Alacritty')
-- or (wm_class == 'Gnome-terminal')
then
	set_window_position(0, screen_y);
end

if (wm_role == 'browser')
or (wm_role == 'browser-window')
or (wm_class == 'Spotify')
then
	undecorate_window();
	maximize();
end

if (wm_class == 'TelegramDesktop') then
	set_window_position(screen_x, screen_y);
end

if (app_name == 'Picture in picture' or wm_role == 'PictureInPicture') then
	set_window_geometry(screen_x, screen_y, 520, 286);
	stick_window();
	set_skip_tasklist(true);
	set_skip_pager(true);
end

if (inst_name == 'mpv-pip') then
	stick_window();
	set_skip_tasklist(true);
	set_skip_pager(true);
end