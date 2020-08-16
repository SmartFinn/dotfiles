#!/bin/bash

array_join() { local IFS="$1"; shift; echo "$*"; }

lf_icons_array=(
	# generic
	'tw=' 'st=' 'ow=' 'dt=' 'di=' 'fi=' 'ln=' 'or=' 'ex='

	# code
	'*.c=' '*.cc=' '*.clj=' '*.coffee=' '*.cpp=' '*.css=' '*.d='
	'*.dart=' '*.erl=' '*.exs=' '*.fs=' '*.go=' '*.h=' '*.hh='
	'*.hpp=' '*.hs=' '*.html=' '*.java=' '*.jl=' '*.js=' '*.json='
	'*.lua=' '*.md=' '*.php=' '*.pl=' '*.pro=' '*.py=' '*.rb='
	'*.rs=' '*.scala=' '*.ts=' '*.vim=' '*.cmd=' '*.ps1=' '*.sh='
	'*.bash=' '*.zsh=' '*.fish=' '*.nix=' '*Makefile=' '*.mk='

	# archives
	'*.tar=' '*.tgz=' '*.arc=' '*.arj=' '*.taz=' '*.lha=' '*.lz4='
	'*.lzh=' '*.lzma=' '*.tlz=' '*.txz=' '*.tzo=' '*.t7z=' '*.zip='
	'*.z=' '*.dz=' '*.gz=' '*.lrz=' '*.lz=' '*.lzo=' '*.xz='
	'*.zst=' '*.tzst=' '*.bz2=' '*.bz=' '*.tbz=' '*.tbz2=' '*.tz='
	'*.deb=' '*.rpm=' '*.jar=' '*.war=' '*.ear=' '*.sar=' '*.rar='
	'*.alz=' '*.ace=' '*.zoo=' '*.cpio=' '*.7z=' '*.rz=' '*.cab='
	'*.wim=' '*.swm=' '*.dwm=' '*.esd='

	# images
	'*.jpg=' '*.jpeg=' '*.mjpg=' '*.mjpeg=' '*.gif=' '*.bmp='
	'*.pbm=' '*.pgm=' '*.ppm=' '*.tga=' '*.xbm=' '*.xpm=' '*.tif='
	'*.tiff=' '*.png=' '*.svg=' '*.svgz=' '*.mng=' '*.pcx='

	# video
	'*.mov=' '*.mpg=' '*.mpeg=' '*.m2v=' '*.mkv=' '*.webm='
	'*.ogm=' '*.mp4=' '*.m4v=' '*.mp4v=' '*.vob=' '*.qt=' '*.nuv='
	'*.wmv=' '*.asf=' '*.rm=' '*.rmvb=' '*.flc=' '*.avi=' '*.fli='
	'*.flv=' '*.gl=' '*.dl=' '*.xcf=' '*.xwd=' '*.yuv=' '*.cgm='

	# audio
	'*.emf=' '*.ogv=' '*.ogx=' '*.aac=' '*.au=' '*.flac=' '*.m4a='
	'*.mid=' '*.midi=' '*.mka=' '*.mp3=' '*.mpc=' '*.ogg=' '*.ra='
	'*.wav=' '*.oga=' '*.opus=' '*.spx=' '*.xspf='

	# documents
	'*.chm=' '*.djvu=' '*.doc=' '*.docm=' '*.docx=' '*.dot='
	'*.dotx=' '*.odb=' '*.odf=' '*.odg=' '*.odp=' '*.ods='
	'*.odt=' '*.pdf=' '*.PDF=' '*.pps=' '*.ppt=' '*.ppts='
	'*.pptx=' '*.rtf=' '*.xls=' '*.xlsx='
)


# archives=(
# 	.7z .a .ar .ace .alz .arc .ark .ARC .ARK .arj .ARJ
# 	.bz .bz2 .cpio .dz .gz .lha .lzh .lrz .lrzip .rz .lz
# 	.lz4 .lzma .lzo .rar .RAR .xz .Z .zip .ZIP .zst .zoo
# 	.tar .gtar .t7z .tbz .tbz2 .tb2 .tz2 .tgz .tlz .tlzma
# 	.tzo .txz .tZ .taZ .tzst
# )
#
# packages=(
# 	.apk .cab .CAB .deb .exe .EXE .gem .ipk .jar .msi .rpm
# 	.spm .udeb .war .xpi
# )
#
# disk_images=(
# 	.bin .dmg .img .iso .qcow .qcow2 .vdi .vmdk
# 	.nes .sfc .smc
# )
#
# media_video=(
# 	.anx .asf .avi .axv .divx .fla .flc .fli .flv .gl
# 	.m2v .m4v .mkv .mov .MOV .mp4 .mp4v .mpe .mpeg .mpg
# 	.nuv .ogm .ogv .ogx .qt .rm .rmvb .swf .vob .VOB
# 	.webm .wmv
# )
#
# media_audio=(
# 	.aac .au .axa .fla .flac .m4a .mid .midi .mka .mp3
# 	.mpa .mpc .oga .ogg .ra .spx .wav .wma .xspf
# )
#
# media_playlists=(
# 	.asx .bio .cue .fpl .kpl .m3u .m3u8 .pla .plc .pls
# 	.smil .srt .sub .torrent .vlc .wpl .xspf .zpl
# )
#
# images=(
# 	.ai .bmp .cgm .dl .dvi .emf .eps .gif .ico .jpeg
# 	.jpg .JPG .mng .pbm .pcx .pgm .png .ppm .pps .ppsx
# 	.ps .psd .svg .svgz .tga .tif .tiff .xbm .xcf .xpm
# 	.xwd .yuv
# )
#
# docs=(
# 	.chm .djvu .doc .docm .docx .dot .dotx .odb .odf
# 	.odg .odp .ods .odt .pdf .PDF .pps .ppt .ppts .pptx
# 	.rtf .xls .xlsx
# )
#
# fonts=(
# 	.afm .fnt .fon .otf .pfb .pfm .ttf .woff .woff2
# )


export LF_ICONS=$(array_join : "${lf_icons_array[@]}")

unset lf_icons_array
unset -f array_join
