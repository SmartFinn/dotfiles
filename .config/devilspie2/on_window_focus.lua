local wm_class = get_window_class();
local pip_windows = {"Picture in picture", "Picture-in-picture"};
local pip_preset = "_window";
local wmctrl_mvargs = {
	["_window"] = {screen_x, screen_y, 500, 282},
	["_maximized"] = {screen_x, screen_y, 320, 180},
	["Code"] = {screen_x, 180, 320, 180},
	["Meld"] = {screen_x, screen_y - 210, 320, 180},
	["TelegramDesktop"] = {screen_x, 0, 400, 226},
	["Inkscape"] = {screen_x - 340, screen_y - 240, 280, 158},
	["firefox"] = {screen_x, screen_y, 320, 180},
	["org-openstreetmap-josm-gui-MainApplication"] = {
		screen_x - 520, screen_y, 320, 180
	},
	["digikam"] = {0, screen_y, 320, 180},
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
