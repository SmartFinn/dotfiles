table.unpack = table.unpack or unpack -- 5.1 compatibility
local screen_x, screen_y = get_screen_geometry();
local aspect_ratio = screen_x / screen_y;
local wm_class = get_window_class();
local wm_role = get_window_role();
local pip_windows = {"Picture in picture", "Picture-in-picture"};
local pip_preset = "_window";
local wmctrl_mvargs = {
	["_window"] = pip_size({}),
	["_maximized"] = pip_size({size = "small"}),
	["browser"] = pip_size({size = "small"}),
	["Code"] = pip_size({size = "small", offset_y = 24}),
	["Meld"] = pip_size({size = "small", offset_y = 24}),
	["TelegramDesktop"] = pip_size({size = "medium", pos = "tr"}),
	["Inkscape"] = pip_size({size = "xsmall", offset_x = 76, offset_y = 94}),
	["org-openstreetmap-josm-gui-MainApplication"] = pip_size({
		size = "small",
		offset_x = 240
	}),
	["digikam"] = pip_size({pos = "bl", size = "xsmall"}),
	["obsidian"] = pip_size({pos = "br", size = "xsmall", offset_x = 280}),
};

if (get_window_type() == "WINDOW_TYPE_NORMAL") then
	if (wmctrl_mvargs[wm_class] ~= nil) then
		pip_preset = wm_class;
	elseif (wmctrl_mvargs[wm_role] ~= nil) then
		pip_preset = wm_role;
	elseif (get_window_is_maximized()) then
		pip_preset = "_maximized";
	end

	if (aspect_ratio > 1.0 and aspect_ratio < 2.0) then
		-- Disable if ultrawide, ultrahigh, or the second screen is attached
		for _, name in ipairs(pip_windows) do
			os.execute(string.format(
				"wmctrl -r '%s' -e 0,%.0f,%.0f,%d,%d", name,
					table.unpack(wmctrl_mvargs[pip_preset])
			));
		end
	end
end
