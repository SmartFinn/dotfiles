if (get_window_class() == "TelegramDesktop")
or (get_window_class() == "Code")
or (get_window_class() == "Meld")
then
	os.execute("wmctrl -r \"Picture in picture\" -e 0,1366,0,420,256");
end
