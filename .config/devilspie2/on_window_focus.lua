if (get_window_class() == "TelegramDesktop")
or (get_window_class() == "Code")
or (get_window_class() == "Meld")
then
	os.execute(string.format(
		"wmctrl -r \"Picture in picture\" -e 0,%.0f,0,420,256", screen_x
	));
	os.execute(string.format(
		"wmctrl -r \"Picture-in-picture\" -e 0,%.0f,0,420,256", screen_x
	));
end
