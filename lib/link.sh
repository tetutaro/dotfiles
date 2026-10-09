# shellcheck shell=sh
# safe_link SRC DST
#   Create the symbolic link DST -> SRC without destroying anything.
#   - DST already links to SRC  : nothing to do
#   - DST is another symlink    : replace the link itself (never follow it)
#   - DST is a file/directory   : move it to DST.bak.<timestamp> first
safe_link() {
    src=$1
    dst=$2
    if [ ! -e "${src}" ] && [ ! -L "${src}" ]; then
        echo "safe_link: source not found: ${src}" >&2
        return 1
    fi
    mkdir -p "$(dirname "${dst}")" || return 1
    if [ -L "${dst}" ]; then
        if [ "$(readlink "${dst}")" = "${src}" ]; then
            return 0
        fi
        # -n: replace the link itself even if it points to a directory
        ln -sfn "${src}" "${dst}"
        return $?
    fi
    if [ -e "${dst}" ]; then
        bak="${dst}.bak.$(date +%Y%m%d%H%M%S)"
        echo "safe_link: ${dst} already exists, moved to ${bak}" >&2
        mv "${dst}" "${bak}" || return 1
    fi
    ln -s "${src}" "${dst}"
}
