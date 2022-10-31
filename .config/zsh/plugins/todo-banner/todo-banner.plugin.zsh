# file: todo-banner.plugin.zsh

if (( ! $+commands[t] )) return 0

_todo_banner() {
	local state_dir state_file
	local hr task_id task_text
	local -A tasks

	state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/todo-banner"
	state_file="$state_dir/last_time"

	[ -d "$state_dir" ] || mkdir -p "$state_dir"

	# run every 5 minutes
	if [ -z "$state_file"(#qN.mm-5) ]; then
		printf -v hr '%*s' "$termcap[cols]"

		while read -r task_id _ task_text; do
			tasks[$task_id]="$task_text"
		done < <(t)

		[[ $#tasks > 0 ]] || return 0

		print -P "%F{8}${hr// /─}%f"
		for task_id task_text ("${(@kv)tasks}"); do
			print -Pn -- "%F{8}- [%f%F{5}$task_id%f%F{8}]%f" $'\t'
			print "$task_text"
		done
		print -P "%F{8}${hr// /─}%f"

		touch "$state_file"
	fi
}

_todo_banner
