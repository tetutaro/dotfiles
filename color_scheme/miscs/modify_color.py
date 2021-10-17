#!/usr/bin/env python3
# -*- coding:utf-8 -*-
from typing import List
import sys
import colorsys


def usage(prog: str):
    print("Usage: %s color1[,color2[...]] [modify1 [modify2 [...]]]" % prog)
    args = """Arguments:
    colorX: hex color code (eg. 3a2f12)
    modifyX: how to change color
        modifyX[0]:
            r, g, b: red, green, blue (0-255)
            h, s, v: hue(0-360), saturatoin, value(0-100)
        modifyX[1]:
            +: increase
            =: set to given value
            -: decrease
        modifyX[2:]:
            integer: value
            decimal: rate
        eg. g=125  set green to 125
            s+0.1  increase saturation by 10%
            v-10   decrease value by 10 """
    print(args)
    sys.exit(1)


class ColorSpace(object):
    rgb_base = (255.0, 255.0, 255.0)
    hsv_base = (360.0, 100.0, 100.0)

    def __init__(self, given: str) -> None:
        self.rgb_int = [None, None, None]
        self.rgb_dec = [None, None, None]
        self.hsv_int = [None, None, None]
        self.hsv_dec = [None, None, None]
        if given.startswith('#'):
            given = given[1:]
        if len(given) != 6:
            raise ValueError("length of hex != 6")
        self.hex = given
        self.arrange_all()
        return

    def arrange_all(self) -> None:
        for i, n in enumerate('rgb'):
            try:
                c_int = int(self.hex[i * 2: (i + 1) * 2], 16)
            except Exception:
                raise ValueError("hex is not base16 at %s" % n)
            c_dec = float(c_int) / self.rgb_base[i]
            self.rgb_int[i] = c_int
            self.rgb_dec[i] = c_dec
        self.hsv_dec = list(colorsys.rgb_to_hsv(*self.rgb_dec))
        for i, n in enumerate('hsv'):
            self.hsv_int[i] = int(round(self.hsv_dec[i] * self.hsv_base[i]))
        return

    def __str__(self) -> str:
        return "HEX: %s R: %s G: %s B: %s H: %s S: %s V: %s" % (
            self.hex,
            str(self.rgb_int[0]).rjust(3),
            str(self.rgb_int[1]).rjust(3),
            str(self.rgb_int[2]).rjust(3),
            str(self.hsv_int[0]).rjust(3),
            str(self.hsv_int[1]).rjust(3),
            str(self.hsv_int[2]).rjust(3)
        )

    def arrange_hex(self) -> None:
        self.hex = "{:02X}{:02X}{:02X}".format(*self.rgb_int)
        return

    def arrange_rgb(self) -> None:
        self.rgb_dec = list(colorsys.hsv_to_rgb(*self.hsv_dec))
        for i, n in enumerate('rgb'):
            self.rgb_int[i] = int(round(self.rgb_dec[i] * self.rgb_base[i]))
        self.arrange_hex()
        return

    def arrange_hsv(self) -> None:
        self.hsv_dec = list(colorsys.rgb_to_hsv(*self.rgb_dec))
        for i, n in enumerate('hsv'):
            self.hsv_int[i] = int(round(self.hsv_dec[i] * self.hsv_base[i]))
        self.arrange_hex()
        return


class ColorModifier(object):
    def __init__(self, mod: str) -> None:
        if len(mod) <= 2:
            raise ValueError("length of modify(%s) is too short" % mod)
        what = mod[0]
        how = mod[1]
        much = mod[2:]
        if what not in 'rgbhsv':
            raise ValueError("modify(%s)[0] not in [rgbhsv]" % mod)
        self.what = what
        if how not in '+-=':
            raise ValueError("modify(%s)[1] not in [+-=]" % mod)
        self.how = how
        try:
            much = float(much)
        except Exception:
            raise ValueError("modify(%s)[2:] is not numerical" % mod)
        if much < 0:
            raise ValueError("modify(%s)[2:] must be positive" % mod)
        if much >= 1:
            much = int(round(much))
        self.much = much
        return

    def _modify_value(
        self,
        where: int,
        ints: List[int],
        decs: List[float],
        base: List[float]
    ) -> None:
        if self.much >= 1:
            if self.how == '=':
                ints[where] = self.much
            elif self.how == '+':
                ints[where] += self.much
            else:
                ints[where] -= self.much
            if ints[where] < 0 or ints[where] > base[where]:
                raise ValueError("exceeds")
            decs[where] = float(ints[where]) / base[where]
        else:
            if self.how == '=':
                raise ValueError("invalid operation")
            elif self.how == '+':
                decs[where] *= (1.0 + self.much)
            else:
                decs[where] *= (1.0 - self.much)
            if decs[where] < 0 or decs[where] > 1:
                raise ValueError("exceeds")
            ints[where] = int(round(decs[where] * base[where]))
        return

    def _modify_rgb(self, color: ColorSpace) -> None:
        for i, n in enumerate('rgb'):
            if self.what == n:
                where = i
                break
        ints = color.rgb_int
        decs = color.rgb_dec
        base = color.rgb_base
        self._modify_value(where, ints, decs, base)
        color.arrange_hsv()
        return

    def _modify_hsv(self, color: ColorSpace) -> None:
        for i, n in enumerate('hsv'):
            if self.what == n:
                where = i
                break
        ints = color.hsv_int
        decs = color.hsv_dec
        base = color.hsv_base
        self._modify_value(where, ints, decs, base)
        color.arrange_rgb()
        return

    def modify(self, color: ColorSpace):
        if self.what in 'rgb':
            self._modify_rgb(color)
        else:
            self._modify_hsv(color)
        return


if __name__ == "__main__":
    if len(sys.argv) == 1:
        usage(sys.argv[0])
    for argc in range(1, len(sys.argv)):
        if sys.argv[argc] == 'help':
            usage(sys.argv[0])
    colors = list()
    try:
        for color_hex in sys.argv[1].split(','):
            color = ColorSpace(color_hex)
            print(color)
            colors.append(color)
    except Exception as e:
        print(e)
        usage(sys.argv[0])
    if len(sys.argv) == 2:
        sys.exit(0)
    print("=== modified ===")
    try:
        for i in range(2, len(sys.argv)):
            modifier = ColorModifier(sys.argv[i])
            for color in colors:
                modifier.modify(color)
    except Exception as e:
        print(e)
        usage(sys.argv[0])
    for color in colors:
        color.arrange_all()
        print(color)
