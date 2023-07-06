#!/usr/bin/env sh
# shellcheck disable=3010,3028,3030,3054,3044

################################################################################
# DESCRIPTION
# 
################################################################################


print_help () {
	cat <<-USAGE
		Usage:
	
	
	USAGE
}

set_env() {
	# Setup
	script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

	name="outpost_2_divided_destiny-opu"
	script_name="$name.yml"

	script_file="$script_dir/$script_name"

	config_dir=$XDG_CONFIG_HOME/lutris/games

	GAMEDIR="$XDG_DATA_HOME/games/gog/outpost-2-divided-destiny"
	WINEDIR="drive_c/GOG Games/Outpost 2"

	install_dir="$GAMEDIR/$WINEDIR"

	saves_dir="$XDG_CONFIG_HOME/games/saves/opu"
}

get_config_file() {
	config_name="$(basename \
		"$(find "$config_dir" \
			-regextype egrep \
			-regex ".*/.*opu[^.]+.yml" \
			-print -quit)"\
		)"
	
	echo "$config_dir/${config_name:=$script_name}"
}

install() {
	lutris -i "$script_file"
	
	# TODO: run under inotifywait autostop for config_file creation
	# TODO: just brute replacing since this file isn't used by installer
	cat <<-END_COMMENT
	yq ".game = .script.game | 
			.wine = .script.wine | 
			.game.working_dir = \"$install_dir\" | .game.exe = \"$install_dir/Outpost2.exe\" |
			with_entries(select(.key != \"script\"))" \
			"$script_file" -P > "$config_file"
	END_COMMENT
	
	# reestore saves
	cp -r "$saves_dir/" "$install_dir/OPU/saves"
}

uninstall() {
	# TODO: read from installer?
	config_file=$(get_config_file)
	echo "$config_file"

	# TODO: Uninstall/remove lutris
	# lutris -u "$script_dir/$script_name"

	cp -r "$install_dir/OPU/saves" "$saves_dir/" 

	rm -r "$install_dir/OPU"
}

remove() {
	uninstall "$@"
}

main () {
	action=${1:-"print_help"}

	if [ "$action" = "help" ]; then
		action="print_help"
	fi

	set_envs

	mapfile -t cg < <(compgen -A function)

	if [[ " ${cg[*]} " =~ " $action " ]]; then
  	"$action"
	else
		echo "Invalid subcommand $action" >&2
		exit 1
	fi
}

main "$@"
