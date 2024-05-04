#!/usr/bin/env python
import os
from powerline.lib.unicode import out_u
from powerline.theme import requires_segment_info


@requires_segment_info
def poetry_virtualenv(
    pl,
    segment_info,
    ignore_venv=False,
    ignore_conda=False,
    ignored_names=("venv", ".venv"),
):
    if not ignore_venv:
        cands = reversed(segment_info["environ"].get("VIRTUAL_ENV", "").split(os.sep))
        for cand in cands:
            if cand == "" or cand in ignored_names:
                continue
            sps = [x for x in cand.split("-") if x != ""]
            if len(sps) > 2:
                cand = "-".join(sps[:-2])
            if cand.endswith("-"):
                cand = cand[:-1]
            return [
                {
                    "contents": cand,
                    "highlight_groups": ["virtualenv"],
                }
            ]
    if not ignore_conda:
        cands = reversed(
            segment_info["environ"].get("CONDA_DEFAULT_ENV", "").split(os.sep)
        )
        for cand in cands:
            if cand == "" or cand in ignored_names:
                continue
            return [
                {
                    "contents": cand,
                    "highlight_groups": ["virtualenv"],
                }
            ]
    return None


@requires_segment_info
def project_cwd(
    pl,
    segment_info,
    project_dir="~/Projects",
    project_depth=2,
    dir_shorten_len=3,
    dir_limit_depth=3,
    home_str="~",
    project_str="",
    ellipsis="...",
):
    is_project = False
    shift_root = False
    try:
        path = out_u(segment_info["getcwd"]())
    except OSError as e:
        if e.errno == 2:
            pl.warn("Current directory not found")
            return "[not found]"
        else:
            raise e
    home = segment_info["home"]
    if home:
        home = out_u(home)
        if path.startswith(home):
            path = "~" + path[len(home) :]
    if path.startswith(project_dir):
        tmp_path = path[len(project_dir) + 1 :]
        tmp_dirs = tmp_path.split(os.sep)
        if len(tmp_dirs) >= project_depth:
            path = os.sep.join(tmp_dirs[project_depth - 1 :])
            is_project = True
    dirs = path.split(os.sep)
    if len(dirs) == 0 or (len(dirs) == 1 and dirs[0] == ""):
        dirs = [os.sep]
    elif dirs[0] == "":
        dirs = dirs[1:]
    if not is_project and len(dirs) > dir_limit_depth:
        dirs = [x[:dir_shorten_len] for x in dirs[:-dir_limit_depth]] + dirs[
            -dir_limit_depth:
        ]
        if len(dirs) > (2 * dir_limit_depth + 1):
            dirs = dirs[:dir_limit_depth] + [ellipsis] + dirs[-dir_limit_depth:]
    if dirs[0] == "~":
        dirs[0] = home_str
        shift_root = True
    if is_project:
        dirs[0] = project_str + dirs[0]
        shift_root = True
    return [
        {
            "contents": x,
            "highlight_groups": (
                ["cwd:current_folder"] if (i == 0 and shift_root) else ["cwd"]
            ),
            "draw_inner_divider": True,
        }
        for i, x in enumerate(dirs)
    ]
