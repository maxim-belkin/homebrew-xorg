# Linuxbrew Xorg

[![Actions Status](https://github.com/Linuxbrew/homebrew-xorg/workflows/Audit/badge.svg)](https://github.com/Linuxbrew/homebrew-xorg/actions)


[Xorg libraries][xorg-libs] for Homebrew on Linux.

## How to use

First, you need to "tap" this repository with

```sh
brew tap linuxbrew/xorg
```

and then you can either install the entire suite of libraries (not recommended) with:

```sh
brew install linuxbrew/xorg/xorg
```

or install individual libraries, for example:

```sh
brew install linuxbrew/xorg/xrandr linuxbrew/xorg/xvinfo
```

## About this tap

Installation proceeds according to the instructions from [Linux From Scratch][lfs].

### Provided formulae

Most of the main xorg formulae are provided by homebrew-core. This tap provides the following ones:

    * bdftopcf                       * encodings                * font-adobe-100dpi        * font-adobe-75dpi
    * font-adobe-utopia-100dpi       * font-adobe-utopia-75dpi  * font-adobe-utopia-type1  * font-alias
    * font-arabic-misc               * font-bh-100dpi           * font-bh-75dpi            * font-bh-lucidatypewriter-100dpi
    * font-bh-lucidatypewriter-75dpi * font-bh-ttf              * font-bh-type1            * font-bitstream-100dpi
    * font-bitstream-75dpi           * font-bitstream-type1     * font-cronyx-cyrillic     * font-cursor-misc
    * font-daewoo-misc               * font-dec-misc            * font-ibm-type1           * font-isas-misc
    * font-jis-misc                  * font-micro-misc          * font-misc-cyrillic       * font-misc-ethiopic
    * font-misc-meltho               * font-misc-misc           * font-mutt-misc           * font-schumacher-misc
    * font-screen-cyrillic           * font-sony-misc           * font-sun-misc            * font-winitzki-cyrillic
    * font-xfree86-type1             * fontcacheproto           * iceauth                  * intel-gmmlib
    * intel-media-driver             * libevdev                 * libglvnd                 * libgudev
    * libomxil-bellagio              * libsha1                  * libva-intel-driver       * libva-utils
    * libvdpau-va-gl                 * libwacom                 * libxfont2                * libxfontcache
    * libxxf86misc                   * luit                     * mkfontscale              * mtdev
    * pciutils                       * sessreg                  * setxkbmap                * smproxy
    * umockdev                       * x11perf                  * xauth                    * xbacklight
    * xcmsdb                         * xcursor-themes           * xcursorgen               * xdriinfo
    * xev                            * xgamma                   * xhost                    * xkbcomp
    * xkbevd                         * xkbutils                 * xkill                    * xlsatoms
    * xlsclients                     * xmessage                 * xmodmap                  * xorg-apps
    * xorg-cf-files                  * xorg-docs                * xorg-fonts               * xorg-sgml-doctools
    * xpr                            * xprop                    * xrandr                   * xrdb
    * xrefresh                       * xset                     * xsetroot                 * xvinfo
    * xwd                            * xwininfo                 * xwud

## How to contribute

### Out-of-date formula

Submit a Pull Request!

If you have `hub` installed (`brew install hub` if you don't) and set up,
you can do this in one step:

```sh
brew bump-formula-pr --url=NEW-URL linuxbrew/xorg/FORMULA
```

### No formula

Submit a Pull Request!

Please feel free to submit pull requests to add new formulae to this tap.
The goal of this repo is to be a one-stop shop for all X11-related needs of Homebrew on Linux.

### Incomplete Documentation

Submit a Pull Request!

### Something else

Please report any issues using... well, GitHub Issues!

[lfs]: http://www.linuxfromscratch.org/blfs/view/stable/x/x7lib.html
[xorg-libs]: http://www.x.org/wiki/guide/client-ecosystem
