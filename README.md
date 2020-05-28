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
brew install linuxbrew/xorg/libx11 linuxbrew/xorg/libxcb
```

## About this tap

Installation proceeds according to the instructions from [Linux From Scratch][lfs].

### Provided formulae

    * bdftopcf                     * encodings                    * glu                          * iceauth
    * intel-gmmlib                 * intel-media-driver           * libdmx                       * libdrm
    * libevdev                     * libfontenc                   * libfs                        * libglvnd
    * libgudev                     * libice                       * libomxil-bellagio            * libpciaccess
    * libpthread-stubs             * libsha1                      * libsm                        * libva
    * libva-intel-driver           * libva-utils                  * libvdpau                     * libvdpau-va-gl
    * libwacom                     * libx11                       * libxau                       * libxaw
    * libxaw3d                     * libxcb                       * libxcomposite                * libxcursor
    * libxdamage                   * libxdmcp                     * libxext                      * libxfixes
    * libxfont                     * libxfont2                    * libxfontcache                * libxft
    * libxi                        * libxinerama                  * libxkbfile                   * libxmu
    * libxpm                       * libxrandr                    * libxrender                   * libxres
    * libxscrnsaver                * libxshmfence                 * libxt                        * libxtst
    * libxv                        * libxvmc                      * libxxf86dga                  * libxxf86misc
    * libxxf86vm                   * luit                         * mesa                         * mkfontscale
    * mtdev                        * pciutils                     * sessreg                      * setxkbmap
    * smproxy                      * umockdev                     * util-macros                  * wayland
    * wayland-protocols            * x11perf                      * xauth                        * xbacklight
    * xbitmaps                     * xcb-proto                    * xcb-util                     * xcb-util-cursor
    * xcb-util-image               * xcb-util-keysyms             * xcb-util-renderutil          * xcb-util-wm
    * xcmsdb                       * xcursor-themes               * xcursorgen                   * xdpyinfo
    * xdriinfo                     * xev                          * xgamma                       * xhost
    * xinput                       * xkbcomp                      * xkbevd                       * xkbutils
    * xkeyboardconfig              * xkill                        * xlsatoms                     * xlsclients
    * xmessage                     * xmodmap                      * xorg                         * xorg-cf-files
    * xorg-docs                    * xorg-sgml-doctools           * xorgproto                    * xpr
    * xprop                        * xrandr                       * xrdb                         * xrefresh
    * xset                         * xsetroot                     * xtrans                       * xvinfo
    * xwd                          * xwininfo                     * xwud

And a number of font formulae.

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
