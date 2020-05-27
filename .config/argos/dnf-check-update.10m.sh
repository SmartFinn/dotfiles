#!/usr/bin/env bash

mapfile -t -d $'\n' upgradable_packages < <(
	# return app_name,version,repo
	dnf check-update | sed '1,/^$/d' | awk -v OFS=',' '{print $1,$2,$3}'
)

if [ "${#upgradable_packages[@]}" -gt 0 ]; then
	echo "| iconName=software-update-available-symbolic"
	echo "---"
	for i in "${upgradable_packages[@]}"; do
		IFS=',' read -r app_name version _ <<< "$i"
		echo "$app_name ($version) | iconName=package-x-generic-symbolic"
	done
else
	echo "---"
fi
