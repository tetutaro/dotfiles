# Prints current branch in a VCS directory if it could be detected.

# Source lib to get the function get_tmux_pwd
source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

TMUX_POWERLINE_SEG_VCS_BRANCH_MAX_LEN_DEFAULT=24


generate_segmentrc() {
	read -d '' rccontents  << EORC
# Max length of the branch name.
export TMUX_POWERLINE_SEG_VCS_BRANCH_MAX_LEN="${TMUX_POWERLINE_SEG_VCS_BRANCH_MAX_LEN_DEFAULT}"
EORC
	echo "$rccontents"
}


run_segment() {
	__process_settings
	tmux_path=$(get_tmux_cwd)
	cd "$tmux_path"
	branch=""
	if [ -n "${git_branch=$(__parse_git_branch)}" ]; then
		branch="$git_branch"
	fi
	if [ -n "$branch" ]; then
		echo "${branch}"
	fi
	return 0
}


# Show git banch.
__parse_git_branch() {
	type git >/dev/null 2>&1
	if [ "$?" -ne 0 ]; then
		return
	fi

	#git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'

	# Quit if this is not a Git repo.
	branch=$(git symbolic-ref HEAD 2> /dev/null)
	if [[ -z $branch ]] ; then
		# attempt to get short-sha-name
		branch=":$(git rev-parse --short HEAD 2> /dev/null)"
	fi
	if [ "$?" -ne 0 ]; then
		# this must not be a git repo
		return
	fi

	# Clean off unnecessary information.
	branch=${branch#refs\/heads\/}
	branch=$(__truncate_branch_name $branch)

	echo -n "${branch}"
}


__truncate_branch_name() {
	trunc_symbol="…"
	branch=$(echo $1 | sed "s/\(.\{$TMUX_POWERLINE_SEG_VCS_BRANCH_MAX_LEN\}\).*/\1$trunc_symbol/")
	echo -n $branch
}


__process_settings() {
	if [ -z "$TMUX_POWERLINE_SEG_VCS_BRANCH_MAX_LEN" ]; then
		export TMUX_POWERLINE_SEG_VCS_BRANCH_MAX_LEN="${TMUX_POWERLINE_SEG_VCS_BRANCH_MAX_LEN_DEFAULT}"
	fi
}
