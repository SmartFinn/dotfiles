command -v gem >/dev/null || return 0

export GEM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/gem"
export GEM_SPEC_CACHE="${XDG_DATA_HOME:-$HOME/.local/share}/gem"

# Add `gem: --bindir ~/.local/bin` line to ~/.gemrc instead
#
# gem_user_dir="$(ruby -e 'puts Gem.user_dir')/bin" || return 1
#
# if path_missing "$PATH" "$gem_user_dir"; then
# 	export PATH="$gem_user_dir:$PATH"
# fi
