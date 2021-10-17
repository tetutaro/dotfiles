#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import colorsys
import glob
import os.path
from jinja2 import Environment, select_autoescape
import yaml

COLOR_NAMES = [
    'BG', 'Bg', 'Bf', 'BF', 'FG', 'Fg',
    'B1', 'B2', 'B3', 'B4', 'B5',
    'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7',
]


class ColorSchemeBuilder(object):
    """color scheme builder"""
    rgb_base = (255.0, 255.0, 255.0)
    hsv_base = (360.0, 100.0, 100.0)

    def __init__(self):
        with open('sources.yaml', 'r') as rf:
            self.sources_ = yaml.load(rf.read(), Loader=yaml.SafeLoader)
        self.env_ = Environment(
            autoescape=select_autoescape()
        )
        self.schemes_ = self._read_schemes()
        self.templates_ = self._read_templates()
        return

    def _set_scheme_color(self, scheme, c, chex):
        scheme['base%s_hex' % c] = chex
        assert(len(chex) == 6)
        rgb = dict()
        for j, t in enumerate('rgb'):
            thex = chex[j * 2: (j + 1) * 2]
            scheme['base%s_hex_%s' % (c, t)] = thex
            scheme[
                'base%s_hex_%s_pad' % (c, t)
            ] = thex.rjust(3)
            trgb = int(thex, 16)
            scheme['base%s_rgb_%s' % (c, t)] = str(trgb)
            scheme[
                'base%s_rgb_%s_pad' % (c, t)
            ] = str(trgb).rjust(3)
            tdec = float(trgb) / self.rgb_base[j]
            rgb[t] = tdec
            scheme['base%s_dec_%s' % (c, t)] = str(tdec)
            scheme[
                'base%s_dec_%s_pad' % (c, t)
            ] = str(round(tdec, 4)).ljust(6)
        hsv = colorsys.rgb_to_hsv(rgb['r'], rgb['g'], rgb['b'])
        for j, t in enumerate('hsv'):
            thsv = int(round(hsv[j] * self.hsv_base[j]))
            scheme['base%s_hsv_%s' % (c, t)] = str(thsv)
            scheme[
                'base%s_hsv_%s_pad' % (c, t)
            ] = str(thsv).rjust(3)
        return

    def _check_scheme(self, given, fname):
        scheme = dict()
        assert(given.get('scheme'))
        scheme['scheme_name'] = given.get('scheme')
        assert(given.get('author'))
        scheme['scheme_author'] = given.get('author')
        scheme['scheme_slug'] = os.path.splitext(os.path.basename(
            fname
        ))[0].replace(' ', '_')
        for c in COLOR_NAMES:
            assert(given.get('base%s' % c))
            chex = given.get('base%s' % c).lower()
            self._set_scheme_color(scheme, c, chex)
        return scheme

    def _read_schemes(self):
        schemes = list()
        for name in self.sources_.get('schemes'):
            for slug_yaml in glob.glob(
                'schemes/%s/*.yaml' % name
            ):
                assert(os.path.isfile(slug_yaml))
                with open(slug_yaml, 'r') as rf:
                    scheme = yaml.load(rf, Loader=yaml.SafeLoader)
                schemes.append(
                    self._check_scheme(scheme, slug_yaml)
                )
        return schemes

    def _check_template(self, options, name, pattern, mustache):
        assert(options.get('extension'))
        assert(options.get('output'))
        options['application'] = name
        options['pattern'] = pattern
        options['mustache'] = mustache
        return options

    def _read_templates(self):
        templates = list()
        for name in self.sources_.get('applications'):
            config_yaml = '/'.join([
                'applications', name, 'templates', 'config.yaml'
            ])
            assert(os.path.isfile(config_yaml))
            with open(config_yaml, 'r') as cf:
                config = yaml.load(cf, Loader=yaml.SafeLoader)
            for pattern, options in config.items():
                template_mustache = '/'.join([
                    'applications', name, 'templates', pattern + '.mustache'
                ])
                assert(os.path.isfile(template_mustache))
                with open(template_mustache, 'r') as rf:
                    mustache = rf.read()
                templates.append(
                    self._check_template(options, name, pattern, mustache)
                )
        return templates

    def build(self):
        for t in self.templates_:
            for s in self.schemes_:
                buffer_name = '/'.join([
                    'applications',
                    t['application'],
                    t['output'],
                    s['scheme_slug'] + t['extension']
                ])
                dname = os.path.dirname(buffer_name)
                if not os.path.isdir(dname):
                    os.makedirs(dname)
                blank = self.env_.from_string(t['mustache'])
                filled = blank.render(s)
                with open(buffer_name, 'w') as wf:
                    wf.write(filled)
        return


if __name__ == "__main__":
    builder = ColorSchemeBuilder()
    builder.build()
