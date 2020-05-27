#!/usr/bin/env bash

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

## If the option `use_preview_script` is set to `true`,
## then this script will be called and its output will be displayed in ranger.
## ANSI color codes are supported.
## STDIN is disabled, so interactive scripts won't work properly

## This script is considered a configuration file and must be updated manually.
## It will be left untouched if you upgrade ranger.

## Because of some automated testing we do on the script #'s for comments need
## to be doubled up. Code that is commented out, because it's an alternative for
## example, gets only one #.

## Meanings of exit codes:
## code | meaning    | action of ranger
## -----+------------+-------------------------------------------
## 0    | success    | Display stdout as preview
## 1    | no preview | Display no preview at all
## 2    | plain text | Display the plain content of the file
## 3    | fix width  | Don't reload when width changes
## 4    | fix height | Don't reload when height changes
## 5    | fix both   | Don't ever reload
## 6    | image      | Display the image `$IMAGE_CACHE_PATH` points to as an image preview
## 7    | image      | Display the file directly as an image

## Script arguments
FILE_PATH="${1}"          # Full path of the highlighted file
PV_WIDTH="${2-}"          # Width of the preview pane (number of fitting characters)
# shellcheck disable=SC2034 # PV_HEIGHT is provided for convenience and unused
PV_HEIGHT="${3-}"         # Height of the preview pane (number of fitting characters)
IMAGE_CACHE_PATH="${4-}"  # Full path that should be used to cache image preview
PV_IMAGE_ENABLED="${5-}"  # 'True' if image previews are enabled, 'False' otherwise.

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_SIZE="$(stat --printf='%s' -- "$FILE_PATH")"

## Settings
HIGHLIGHT_SIZE_MAX=262143  # 256KiB
HIGHLIGHT_TABWIDTH=4
HIGHLIGHT_STYLE='molokai'

ARCHIVE_SIZE_MAX=67108864 # 64MiB

do_hightlight() {
	## Syntax highlight
	local highlight_format='ansi'

	## Fallback to plain text if the file is large
	(( FILE_SIZE < HIGHLIGHT_SIZE_MAX )) || return 1

	if [[ "$(tput colors)" -ge 256 ]]; then
		highlight_format='xterm256'
	fi

	highlight \
		--replace-tabs="$HIGHLIGHT_TABWIDTH" \
		--out-format="$highlight_format" \
		--style="$HIGHLIGHT_STYLE" \
		--force -- "$1"
}

do_bat() {
	## Syntax highlight with bat

	## Fallback to plain text if the file is large
	(( FILE_SIZE < HIGHLIGHT_SIZE_MAX )) || return 1

	env COLORTERM=8bit bat \
		--color=always \
		--style=plain \
		--map-syntax=conf:ini \
		--map-syntax=rsc:ini \
		--map-syntax=theme:ini \
		--tabs 4 \
		--pager=never -- "$1"
}

handle_archive() {
	(( FILE_SIZE < ARCHIVE_SIZE_MAX )) || return 0

	case "$FILE_PATH" in
		## Tarballs
		*.tar|*.gtar|*.gem)
			## Tar archive
			tar --list --file "$FILE_PATH" && exit 5
			;;
		*.tar.bz|*.tbz| \
		*.tar.bz2|*.tbz2|*.tb2|*.tz2)
			## Tar archive (bzip-compressed)
			tar -j --list --file "$FILE_PATH" && exit 5
			;;
		*.tar.gz|*.tgz)
			## Tar archive (gzip-compressed)
			tar -z --list --file "$FILE_PATH" && exit 5
			;;
		*.tar.lz)
			## Tar archive (lzip-compressed)
			tar --lzop --list --file "$FILE_PATH" && exit 5
			;;
		*.tar.lzma|*.tlz|*.tlzma)
			## Tar archive (LZMA-compressed)
			tar --lzma --list --file "$FILE_PATH" && exit 5
			;;
		*.tar.lzo|*.tzo)
			## Tar archive (LZO-compressed)
			tar --lzop --list --file "$FILE_PATH" && exit 5
			;;
		*.tar.xz|*.txz)
			## Tar archive (XZ-compressed)
			tar -J --list --file "$FILE_PATH" && exit 5
			;;
		*.tar.[zZ]|*.t[zZ]|*.ta[zZ])
			## Tar archive (compressed)
			tar -Z --list --file "$FILE_PATH" && exit 5
			;;
		*.tar.zst|*.tzst)
			## Tar archive (Zstandard-compressed)
			tar --zstd --list --file "$FILE_PATH" && exit 5
			;;
		## Archives
		*.7[zZ]|*.7za|*.tar.7z|*.t7z)
			## 7-zip archive
			## Avoid password prompt by providing empty password
			7z  l -y -p -- "$FILE_PATH" && exit 5
			7za l -y -p -- "$FILE_PATH" && exit 5
			;;
		*.a|*.ar)
			## AR archive
			ar t -- "$FILE_PATH" && exit 5
			;;
		*.ace)
			## ACE archive
			unace l -- "$FILE_PATH" && exit 5
			;;
		*.alz)
			## Alzip archive
			unalz -l -- "$FILE_PATH" && exit 5
			;;
		*.arc|*.ark|*.ARC|*.ARK)
			## ARC archive
			nomarch -l -- "$FILE_PATH" && exit 5
			;;
		*.arj|*.ARJ)
			## ARJ archive
			arj l -y -r "$FILE_PATH" && exit 5
			;;
		*.bz|*.bz2)
			## Bzip archive
			bzcat "$FILE_PATH" && exit 5
			;;
		*.cab|*.CAB)
			## Microsoft Cabinet archive
			cabextract -l "$FILE_PATH" && exit 5
			;;
		*.cpio)
			## CPIO archive
			cpio -i -t -F "$FILE_PATH" && exit 5
			;;
		*.deb|*.udeb)
			## Debian package
			dpkg --contents -- "$FILE_PATH" && exit 5
			;;
		*.gz)
			## Gzip archive
			zcat  "$FILE_PATH" && exit 5
			;;
		*.lha|*.lzh)
			## LHA archive
			lha l "$FILE_PATH" && exit 5
			;;
		*.lrz|*.lrzip|*.rz)
			## Lrzip archive
			lrzcat "$FILE_PATH" && exit 5
			;;
		*.lz)
			## Lzip archive
			lzip --decompress --stdout -- "$FILE_PATH" && exit 5
			;;
		*.lz4)
			## LZ4 archive
			lz4cat -- "$FILE_PATH" && exit 5
			;;
		*.lzma)
			## LZMA archive
			lzcat -- "$FILE_PATH" && exit 5
			xzcat --format=lzma -- "$FILE_PATH" && exit 5
			;;
		*.lzo)
			## LZO archive
			lzop --list "$FILE_PATH" && exit 5
			;;
		*.rar|*.RAR)
			## RAR archive
			## Avoid password prompt by providing empty password
			unrar l -p- -- "$FILE_PATH" && exit 5
			;;
		*.src.rpm|*.rpm|*.spm)
			## RPM package
			rpm -qlp -- "$FILE_PATH" && exit 5
			;;
		*.xz)
			## XZ archive
			xzcat -- "$FILE_PATH" && exit 5
			;;
		*.[zZ])
			## UNIX-compressed file
			zcat  "$FILE_PATH" && exit 5
			;;
		*.zip|*.ZIP)
			## Zip archive
			unzip -l -- "$FILE_PATH" && exit 5
			;;
		*.zst)
			## Zstandard archive
			zstdcat "$FILE_PATH" && exit 5
			;;
	esac
}

handle_extension() {
	case "${FILE_EXTENSION,,}" in
		1|2|3|4|5|6|7|8|9)
			nroff -man "$FILE_PATH" && exit 5
			;;
		deb)
			dpkg --field -- "$FILE_PATH" && exit 5
			;;
		rpm)
			rpm -qip -- "$FILE_PATH" && exit 5
			;;
		svg)
			do_bat        "$FILE_PATH" && exit 5
			do_hightlight "$FILE_PATH" && exit 5
			exit 2
			;;
		gpx)
			gpxinfo "$FILE_PATH" && exit 5
			exit 2
			;;
		pdf)
			## Preview as text conversion
			pdftotext -l 10 -nopgbrk -q -- "$FILE_PATH" - | \
				fmt -w "$PV_WIDTH" && exit 5
			mutool draw -F txt -i -- "$FILE_PATH" 1-10 | \
				fmt -w "$PV_WIDTH" && exit 5
			exiftool "$FILE_PATH" && exit 5
			;;
		torrent)
			transmission-show -- "$FILE_PATH" && exit 5
			;;
		odt|ods|odp|sxw)
			## Preview OpenDocument as text conversion
			odt2txt "$FILE_PATH" && exit 5
			pandoc -s -t markdown -- "$FILE_PATH" && exit 5
			;;
		htm|html|xhtml)
			## Preview HTML as text conversion
			w3m -dump "$FILE_PATH" && exit 5
			lynx -dump -- "$FILE_PATH" && exit 5
			elinks -dump "$FILE_PATH" && exit 5
			pandoc -s -t markdown -- "$FILE_PATH" && exit 5
			;;
		json)
			jq --color-output . "$FILE_PATH" && exit 5
			python -m json.tool -- "$FILE_PATH" && exit 5
			;;
		dff|dsf|wv|wvc)
			## Direct Stream Digital/Transfer (DSDIFF) and wavpack aren't detected
			## by file(1).
			mediainfo "$FILE_PATH" && exit 5
			exiftool "$FILE_PATH" && exit 5
			;; # Continue with next handler on failure
	esac
}

handle_image() {
	local mimetype="$1"

	case "$mimetype" in
		image/svg+xml)
			convert "$FILE_PATH" "$IMAGE_CACHE_PATH" && exit 6
			;;
		image/*)
			local orientation
			orientation="$(identify -format '%[EXIF:Orientation]\n' -- "$FILE_PATH")"
			## If orientation data is present and the image actually
			## needs rotating ("1" means no rotation)...
			if [[ -n "$orientation" && "$orientation" != 1 ]]; then
				## ...auto-rotate the image according to the EXIF data.
				convert -- "$FILE_PATH" -auto-orient "$IMAGE_CACHE_PATH" && exit 6
			fi

			## `w3mimgdisplay` will be called for all images (unless overriden as above),
			## but might fail for unsupported types.
			exit 7
			;;
		video/*)
			## Thumbnail
			ffmpegthumbnailer -i "$FILE_PATH" -o "$IMAGE_CACHE_PATH" -s 0 && exit 6
			ffmpeg -an -i "$FILE_PATH" -vframes 1 -ss 10 "$IMAGE_CACHE_PATH" && exit 6
			;;
		audio/*)
			## Album cover
			ffmpeg -i "$FILE_PATH" "$IMAGE_CACHE_PATH" -y && exit 6
			;;
		application/pdf)
			pdftoppm -f 1 -l 1 \
				-scale-to-x 1920 \
				-scale-to-y -1 \
				-singlefile \
				-jpeg -tiffcompression jpeg \
				-- "$FILE_PATH" "${IMAGE_CACHE_PATH%.*}" \
				&& exit 6
			;;
		application/font*|application/*opentype|font/*)
			## Font
			convert -size 380x400 xc:"#cecece" \
				-gravity center \
				-pointsize 36 \
				-font "${FILE_PATH}" \
				-fill "#000000" \
				-annotate +0+0 "ABCDEFGHIJKLM\nNOPQRSTUVWXYZ\nabcdefghijklm\nnopqrstuvwxyz\n1234567890\n!@$\%(){}[]" \
				-flatten "${IMAGE_CACHE_PATH}" && exit 6
			preview_png="/tmp/$(basename "${IMAGE_CACHE_PATH%.*}").png"
			if fontimage -o "${preview_png}" \
				--pixelsize "120" \
				--fontname \
				--pixelsize "80" \
				--text "  ABCDEFGHIJKLMNOPQRSTUVWXYZ  " \
				--text "  abcdefghijklmnopqrstuvwxyz  " \
				--text "  0123456789.:,;(*!?') ff fl fi ffi ffl  " \
				--text "  The quick brown fox jumps over the lazy dog.  " \
				"${FILE_PATH}";
			then
				convert -- "${preview_png}" "${IMAGE_CACHE_PATH}" \
					&& rm "${preview_png}" \
					&& exit 6
			else
				exit 1
			fi
			;;
	esac
}

handle_mime() {
	local mimetype="$1"

	case "$mimetype" in
		application/x-iso9660-image)
			isoinfo -lR -i "$FILE_PATH" && exit 5
			;;
		text/rtf|*msword)
			## Preview as text conversion
			## note: catdoc does not always work for .doc files
			## catdoc: http://www.wagner.pp.ru/~vitus/software/catdoc/
			catdoc -- "$FILE_PATH" && exit 5
			unrtf --text "$FILE_PATH" && exit 5
			return 0
			;;
		*ms-excel)
			## Preview as csv conversion
			## xls2csv comes with catdoc:
			##   http://www.wagner.pp.ru/~vitus/software/catdoc/
			xls2csv -- "$FILE_PATH" && exit 5
			return 0
			;;
		*wordprocessingml.document|*/epub+zip|*/x-fictionbook+xml)
			## DOCX, ePub, FB2 (using markdown)
			## You might want to remove "|epub" and/or "|fb2" below if you have
			## uncommented other methods to preview those formats
			pandoc -s -t markdown -- "$FILE_PATH" && exit 5
			return 0
			;;
		text/* | */xml | *\+xml | */json)
			do_bat        "$FILE_PATH" && exit 5
			do_hightlight "$FILE_PATH" && exit 5
			exit 2
			;;
		image/vnd.djvu)
			## Preview DjVu as text conversion (requires djvulibre)
			djvutxt "$FILE_PATH" | fmt -w "$PV_WIDTH" && exit 5
			exiftool "$FILE_PATH" && exit 5
			return 0
			;;
		image/*)
			## Preview as text conversion
			img2txt --gamma=0.6 --width="$PV_WIDTH" -- "$FILE_PATH" && exit 4
			exiftool "$FILE_PATH" && exit 5
			mediainfo "$FILE_PATH" && exit 5
			;;
		video/* | audio/*)
			mediainfo "$FILE_PATH" && exit 5
			exiftool "$FILE_PATH" && exit 5
			;;
	esac
}

handle_fallback() {
	echo '----- File Type Classification -----' \
		&& file --dereference --brief -- "$FILE_PATH" \
		&& exit 5
	exit 1
}


MIMETYPE="$(file --dereference --brief --mime-type -- "$FILE_PATH")"

if [[ "$PV_IMAGE_ENABLED" == 'True' ]]; then
	handle_image "$MIMETYPE"
fi
handle_extension
handle_archive
handle_mime "$MIMETYPE"
handle_fallback

exit 1
