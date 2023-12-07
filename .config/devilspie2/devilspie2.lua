screen_x, screen_y = get_screen_geometry();

if (screen_x <= 1366) then
	pip_width_full, pip_height_full = 500, 282;
elseif (screen_x <= 1920) then
	pip_width_full, pip_height_full = 720, 405;
else
	pip_width_full, pip_height_full = 960, 540;
end

pip_width_medium = string.format("%.0f", pip_width_full / 1.25);
pip_height_medium = string.format("%.0f", pip_height_full / 1.25);

pip_width_small = string.format("%.0f", pip_width_full / 1.5625);
pip_height_small = string.format("%.0f", pip_height_full / 1.5625);

pip_width_very_small = string.format("%.0f", pip_width_full / 1.785);
pip_height_very_small = string.format("%.0f", pip_height_full / 1.785);

scripts_window_open = {
	"on_window_open.lua"
}
scripts_window_blur = {
	"on_window_blur.lua"
}
scripts_window_focus = {
	"on_window_focus.lua"
}
