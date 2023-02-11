local wm_class = get_window_class();
local pip_windows = {"Picture in picture", "Picture-in-picture"};
local wmctrl_mvargs = {
	["Code"] = {screen_x, 180, 320, 180},
	["Meld"] = {screen_x, screen_y - 210, 320, 180},
	["TelegramDesktop"] = {screen_x, 0, 400, 226},
	["Inkscape"] = {screen_x - 340, screen_y - 240, 280, 158},
};

if (get_window_type() == "WINDOW_TYPE_NORMAL") then
	if (wmctrl_mvargs[wm_class] ~= nil) then
		for _, name in ipairs(pip_windows) do
			os.execute(string.format(
				"wmctrl -r '%s' -e 0,%.0f,%.0f,%d,%d", name,
					table.unpack(wmctrl_mvargs[wm_class])
			));
		end
	else
		for _, name in ipairs(pip_windows) do
			os.execute(string.format(
				"wmctrl -r '%s' -e 0,%.0f,%.0f,500,282", name, screen_x, screen_y
			));
		end
	end
end
