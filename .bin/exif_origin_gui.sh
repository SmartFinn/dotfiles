#!/usr/bin/env bash

# digikam
# -------
# 0x001a Iptc.Application2.LocationCode               String     UKR
# 0x001b Iptc.Application2.LocationName               String     Ukraine
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
# 0x001b Iptc.Application2.LocationName               String     Пляж 3
# 0x005f Iptc.Application2.ProvinceState              String     Запоріжська область
# 0x0000 Xmp.iptc.Location                            XmpText    Пляж 3

if [ $# -eq 0 ]; then
	zenity --error --text="No files specified."
	exit 2
fi

country=
country_code=
province_state=
city=
sub_location=

IFS=, read -r country country_code province_state city sub_location < <(
	zenity --forms --title="Set origin" \
		--text="Enter information about photo(s) location" \
		--separator="," \
		--add-entry="County" \
		--add-entry="Country code" \
		--add-entry="State/Province" \
		--add-entry="City" \
		--add-entry "Place"
)

exiv2_args=()

[ -n "$country" ] && exiv2_args+=(
	-M"set Iptc.Application2.CountryName $country" \
	-M"set Xmp.photoshop.Country $country" \
)

[ -n "$country_code" ] && exiv2_args+=(
	-M"set Iptc.Application2.CountryCode $country_code" \
	-M"set Xmp.iptc.CountryCode $country_code" \
)

[ -n "$province_state" ] && exiv2_args+=(
	-M"set Iptc.Application2.ProvinceState $province_state" \
	-M"set Xmp.photoshop.State $province_state"
)

[ -n "$city" ] && exiv2_args+=(
	-M"set Iptc.Application2.City $city"
	-M"set Xmp.photoshop.City $city"
)

[ -n "$sub_location" ] && exiv2_args+=(
	-M"set Iptc.Application2.LocationName $sub_location" \
	-M"set Iptc.Application2.SubLocation $sub_location" \
	-M"set Xmp.iptc.Location $sub_location" \
)

if [ "${#exiv2_args[@]}" -gt 0 ]; then
	msg=$(exiv2 "${exiv2_args[@]}" "$@" 2>&1)

	if [ $? -ne 0 ]; then
		zenity --error --text="$msg"
	fi
fi
