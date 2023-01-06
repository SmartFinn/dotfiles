#!/usr/bin/env bash

if ! command -v zenity >/dev/null; then
	echo "Error: Please install zenity first!" >&2
	exit 2
fi

xdg-open "https://www.strava.com/heatmap" 2>/dev/null

IFS='|' read -r pair_id policy signature < <(zenity --forms --title="Paste cookie values" \
	--text="Using a browser paste items with appropriate cookie values for the following:" \
	--add-entry="CloudFront-Key-Pair-Id" \
	--add-entry="CloudFront-Policy" \
	--add-entry="CloudFront-Signature")

TMP_FILE="$(mktemp -u)"


printf '\nStrava cycling heatmap:\n' | tee -a "$TMP_FILE" >/dev/null
printf 'tms[3,15]:https://heatmap-external-{switch:a,b,c}.strava.com/tiles-auth/ride/hot/{zoom}/{x}/{y}.png?Key-Pair-Id=%s&Policy=%s&Signature=%s\n' \
	"${pair_id}" "${policy}" "${signature}" | tee -a "$TMP_FILE" >/dev/null

printf '\nStrava ride and run heatmap:\n' | tee -a "$TMP_FILE" >/dev/null
printf 'tms[3,15]:https://heatmap-external-{switch:a,b,c}.strava.com/tiles-auth/both/hot/{zoom}/{x}/{y}.png?Key-Pair-Id=%s&Policy=%s&Signature=%s\n' \
	"${pair_id}" "${policy}" "${signature}" | tee -a "$TMP_FILE" >/dev/null

zenity --text-info \
	--title="Copy result to JOSM" \
	--filename="$TMP_FILE"

[ -f "$TMP_FILE" ] && rm -f "$TMP_FILE"
