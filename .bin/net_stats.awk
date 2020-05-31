#!/usr/bin/awk -f

function human_readable(num) {
	symbols[0] = "B  "
	symbols[1] = "KiB"
	symbols[2] = "MiB"
	symbols[3] = "GiB"
	symbols[4] = "TiB"
	symbols[5] = "PiB"
	symbols[6] = "EiB"
	symbols[7] = "ZiB"

	i = 0

	while (num >= 1024) {
		num = num / 1024
		i++
	}

	return sprintf("%.2f %s", num, symbols[i])
}

BEGIN {
	printf "%16s %14s %14s\n", "Interface", "Download", "Upload"
	printf "%16s %14s %14s\n", "--------------", "------------", "------------"
	while ((getline < "/proc/net/dev") > 0) {
		if ($1 !~ "Inter|face") {
			# Comment the statment to hide interfaces with zero traffic:
			if ($2 + $10 == 0)
				continue
			printf "%16s %14s %14s\n", $1, human_readable($2), human_readable($10)
		}
	}

	close("/proc/net/dev")
}
