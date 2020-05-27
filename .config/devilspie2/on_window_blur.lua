local wm_class = get_window_class();

-- if (wm_class == "keepassxc") then
-- 	minimize();
-- end

if (wm_class == 'TelegramDesktop')
or (wm_class == 'Code')
or (wm_class == 'Meld')
then
	os.execute("wmctrl -r \"Picture in picture\" -e 0,1366,768,520,286");
end
