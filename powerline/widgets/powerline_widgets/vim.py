#!/usr/bin/env python
# -*- coding:utf-8 -*-
try:
    import vim
except ImportError:
    vim = object
from powerline.theme import requires_segment_info


@requires_segment_info
def simple_string(
    pl,
    segment_info,
    contents='',
    highlight_group=''
):
    return [{
        'contents': contents,
        'highlight_groups': [highlight_group],
    }]
