#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os.path
import shutil
import yaml


class ColorSchemeCleaner(object):
    """clean color schemes"""

    def __init__(self):
        with open('sources.yaml', 'r') as rf:
            self.sources_ = yaml.load(rf.read(), Loader=yaml.SafeLoader)
            self.outputs_ = self._read_templates()
        return

    def _read_templates(self):
        outputs = list()
        for name in self.sources_.get('applications'):
            config_yaml = '/'.join([
                'applications', name, 'templates', 'config.yaml'
            ])
            assert(os.path.isfile(config_yaml))
            with open(config_yaml, 'r') as cf:
                config = yaml.load(cf, Loader=yaml.SafeLoader)
            for pattern, options in config.items():
                outputs.append('/'.join([
                    'applications', name, options['output']]) + '/'
                )
        return outputs

    def clean(self):
        for o in self.outputs_:
            shutil.rmtree(o)
        return


if __name__ == "__main__":
    cleaner = ColorSchemeCleaner()
    cleaner.clean()
