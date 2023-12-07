table.unpack = table.unpack or unpack -- 5.1 compatibility
local wm_class = get_window_class();
local pip_windows = {"Picture in picture", "Picture-in-picture"};
local pip_preset = "_window";
local wmctrl_mvargs = {
	["_window"] = {screen_x, screen_y, pip_width_full, pip_height_full},
	["_maximized"] = {screen_x, screen_y, pip_width_small, pip_height_small},
	["Code"] = {
		screen_x, screen_y - pip_height_small - 30, pip_width_small, pip_height_small
	},
	["Meld"] = {
		screen_x, screen_y - pip_height_small - 30, pip_width_small, pip_height_small
	},
	["TelegramDesktop"] = {screen_x, 0, pip_width_medium, pip_height_medium},
	["Inkscape"] = {
		screen_x - string.format("%.0f", pip_width_full / 1.785) - 76,
		screen_y - string.format("%.0f", pip_height_full / 1.785) - 94,
		string.format("%.0f", pip_width_full / 1.785),
		string.format("%.0f", pip_height_full / 1.785),
	},
	["org-openstreetmap-josm-gui-MainApplication"] = {
		screen_x - 520, screen_y, pip_width_small, pip_height_small
	},
	["digikam"] = {0, screen_y, pip_width_small, pip_height_small},
};

if (get_window_type() == "WINDOW_TYPE_NORMAL") then
	if (wmctrl_mvargs[wm_class] ~= nil) then
		pip_preset = wm_class;
	elseif (get_window_is_maximized()) then
		pip_preset = "_maximized";
	end

	for _, name in ipairs(pip_windows) do
		os.execute(string.format(
			"wmctrl -r '%s' -e 0,%.0f,%.0f,%d,%d", name,
				table.unpack(wmctrl_mvargs[pip_preset])
		));
	end
end
