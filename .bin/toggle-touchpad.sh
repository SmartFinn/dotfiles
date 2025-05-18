#!/usr/bin/env bash

# Get current touchpad state
current_state=$(gsettings get org.gnome.desktop.peripherals.touchpad send-events)

# Toggle the state
if [ "$current_state" = "'disabled'" ]; then
	gsettings set org.gnome.desktop.peripherals.touchpad send-events 'enabled'
	notify-send -e -i touchpad-enabled-symbolic "Touchpad Enabled" \
		"The touchpad has been enabled."
else
	gsettings set org.gnome.desktop.peripherals.touchpad send-events 'disabled'
	notify-send -e -i touchpad-disabled-symbolic "Touchpad Disabled" \
		"The touchpad has been disabled."
fi
