#!/usr/bin/env bash
# --cacheonly option force to use system cache instead of creating a separate
#             cache for each user under which it executes.
#             Requires systemd unit dnf-makecache.timer enabled that also
#             respects metered connection in Network Manager.

mapfile -t -d $'\n' upgradable_packages < <(
	# return app_name,version,repo
	dnf --cacheonly check-update | awk -v OFS=',' 'NR>2 {print $1,$2,$3}'
)

if [ "${#upgradable_packages[@]}" -gt 0 ]; then
	echo "| iconName=software-update-available-symbolic"
	echo "---"
	echo "Refresh | refresh=true"
	echo "---"
	echo "${#upgradable_packages[@]} updates available"
	for i in "${upgradable_packages[@]}"; do
		IFS=',' read -r app_name version _ <<< "$i"
		echo "-- $app_name ($version) | iconName=package-x-generic-symbolic"
	done
else
	echo "---"
fi
