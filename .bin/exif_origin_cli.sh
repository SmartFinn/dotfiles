#!/usr/bin/env bash

# digikam
# -------
# 0x001a Iptc.Application2.LocationCode               String     UKR
# 0x005a Iptc.Application2.City                       String     Berdyansk
# 0x005c Iptc.Application2.SubLocation                String     Bitch 3
# 0x005f Iptc.Application2.ProvinceState              String     Zaporizhya
# 0x0064 Iptc.Application2.CountryCode                String     UKR
# 0x0065 Iptc.Application2.CountryName                String     Ukraine
# 0x0000 Xmp.photoshop.City                           XmpText    Бердянськ
# 0x0000 Xmp.photoshop.State                          XmpText    Запоріжська область
# 0x0000 Xmp.photoshop.Country                        XmpText    Ukraine
# 0x0000 Xmp.iptc.Location                            XmpText    Пляж 3
# 0x0000 Xmp.iptc.CountryCode                         XmpText    UKR
#
# gthumb
# ------
# 0x005a Iptc.Application2.City                       String     Бердянськ
# 0x0064 Iptc.Application2.CountryCode                String     UKR
# 0x0065 Iptc.Application2.CountryName                String     Ukraine
# 0x005f Iptc.Application2.ProvinceState              String     Запоріжська область
# 0x0000 Xmp.iptc.Location                            XmpText    Пляж 3

exiv2_args=()

params="$(getopt -o c:d:n:s:l: -l city:,code:,country:,state:,location: --name "$0" -- "$@")"

eval set -- "$params"

while true; do
	case "$1" in
	-c|--city)
		# city="$2"
		exiv2_args+=(
			-M"set Iptc.Application2.City $2"
			-M"set Xmp.photoshop.City $2"
		)
		shift 2
		;;
	-d|--code)
		# country_code="$2"
		exiv2_args+=(
			-M"set Iptc.Application2.CountryCode $2" \
			-M"set Xmp.iptc.CountryCode $2" \
		)
		shift 2
		;;
	-n|--country)
		# country="$2"
		exiv2_args+=(
			-M"set Iptc.Application2.CountryName $2" \
			-M"set Xmp.photoshop.Country $2" \
		)
		shift 2
		;;
	-s|--state)
		# province_state="$2"
		exiv2_args+=(
			-M"set Iptc.Application2.ProvinceState $2" \
			-M"set Xmp.photoshop.State $2"
		)
		shift 2
		;;
	-l|--location)
		# sub_location="$2"
		exiv2_args+=(
			-M"set Iptc.Application2.SubLocation $2" \
			-M"set Xmp.iptc.Location $2" \
		)
		shift 2
		;;
	--)
		shift 1
		break
		;;
	*)
		echo "Not implemented: $1" >&2
		exit 1
		;;
	esac
done

if [ "${#exiv2_args[@]}" -eq 0 ] || [ $# -eq 0 ]; then
	cat <<-USAGE_MESSAGE
	usage: $0 <options> <files>
	options:
	  -c --city       City
	  -d --code       CountryCode
	  -n --country    Country
	  -s --state      ProvinceState
	  -l --location   SubLocation
	USAGE_MESSAGE
	exit 2
fi

exiv2 -n "UTF-8" "${exiv2_args[@]}" "$@"
