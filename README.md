# Homebrew Xorg

[![Actions Status](https://github.com/maxim-belkin/homebrew-xorg/workflows/Audit/badge.svg)](https://github.com/maxim-belkin/homebrew-xorg/actions)

X.org libraries, fonts, and utilities for [Homebrew on Linux](https://docs.brew.sh/Homebrew-on-Linux).

## Why use this tap?

Homebrew/core provides essential X.org libraries (`libx11`, `libxcb`, `libxrandr`, etc.) but not the full X.org ecosystem. This tap fills the gaps:

- **X11 bitmap fonts** -- the complete set of classic X11 fonts (Adobe, Bitstream, BH Lucida, international character sets). Needed by legacy X applications, terminal emulators, and remote X11 sessions that expect these fonts to be available.
- **X11 utilities** -- tools like `xrandr`, `xev`, `xhost`, `xset`, `xbacklight`, and `setxkbmap` that aren't in homebrew/core. Essential for display configuration, keyboard mapping, and X server debugging.
- **Intel VAAPI hardware video acceleration** -- `intel-media-driver` and `intel-gmmlib` for GPU-accelerated video encode/decode on Intel hardware.
- **GL vendor-neutral dispatch** -- `libglvnd` provides the GPU-agnostic OpenGL dispatch layer used by modern Linux graphics stacks.
- **Input device libraries** -- `libevdev`, `libwacom`, and `mtdev` for evdev input handling, Wacom tablet support, and multitouch protocol translation.

## How to use

[Tap](https://docs.brew.sh/Taps#the-brew-tap-command) this repository:

```sh
brew tap maxim-belkin/xorg
```

Install individual formulas:

```sh
brew install maxim-belkin/xorg/xrandr
brew install maxim-belkin/xorg/intel-media-driver
```

Or install everything in a category:

```sh
brew install maxim-belkin/xorg/xorg-apps   # all X.org utilities
brew install maxim-belkin/xorg/xorg-fonts   # all X.org fonts
```

## Provided formulas

### X.org Fonts (36)

All classic X11 bitmap and outline fonts, plus encodings and the `xorg-fonts` meta-package:

    * encodings                             * font-misc-meltho
    * font-adobe-100dpi                     * font-misc-misc
    * font-adobe-75dpi                      * font-mutt-misc
    * font-adobe-utopia-100dpi              * font-schumacher-misc
    * font-adobe-utopia-75dpi               * font-screen-cyrillic
    * font-adobe-utopia-type1               * font-sony-misc
    * font-alias                            * font-sun-misc
    * font-arabic-misc                      * font-winitzki-cyrillic
    * font-bh-100dpi                        * font-xfree86-type1
    * font-bh-75dpi                         * fontcacheproto
    * font-bh-lucidatypewriter-100dpi       * xorg-fonts
    * font-bh-lucidatypewriter-75dpi
    * font-bh-ttf
    * font-bh-type1
    * font-bitstream-100dpi
    * font-bitstream-75dpi
    * font-bitstream-type1
    * font-cronyx-cyrillic
    * font-cursor-misc
    * font-daewoo-misc
    * font-dec-misc
    * font-ibm-type1
    * font-isas-misc
    * font-jis-misc
    * font-micro-misc
    * font-misc-cyrillic
    * font-misc-ethiopic

### X.org Utilities (31)

Display, keyboard, and window management tools, plus the `xorg-apps` meta-package:

    * iceauth          * xcursorgen        * xkbutils
    * sessreg          * xdriinfo          * xkill
    * setxkbmap        * xev               * xlsatoms
    * smproxy          * xeyes             * xmessage
    * x11perf          * xgamma            * xorg-apps
    * xbacklight       * xhost             * xpr
    * xcalc            * xkbevd            * xrandr
    * xclipboard       * xrefresh          * xvinfo
    * xcmsdb           * xset              * xwd
    * xcompmgr         * xsetroot          * xwud
    * xcursor-themes

### Libraries (10)

    * libevdev             * libvdpau-va-gl        * libxxf86misc
    * libglvnd             * libwacom              * mtdev
    * libomxil-bellagio    * libxfontcache
    * libsha1              * libva-intel-driver

### Intel GPU / Media (2)

    * intel-gmmlib         * intel-media-driver

### Build & Documentation Tools (3)

    * xorg-cf-files        * xorg-docs             * xorg-sgml-doctools

### Also available in homebrew/core

Many X.org packages have been migrated to [homebrew/core](https://github.com/Homebrew/homebrew-core) and are available directly via `brew install` without this tap. These include: `libx11`, `libxcb`, `libxrandr`, `libxrender`, `libxext`, `libxfixes`, `libxft`, `libxi`, `libxinerama`, `libxmu`, `libxpm`, `libxt`, `libxv`, `xorgproto`, `xcb-proto`, `xcb-util`, `xauth`, `xdpyinfo`, `xinput`, `xkbcomp`, `xmodmap`, `xprop`, `xrdb`, `xwininfo`, `wayland`, and many more.

## How to contribute

Please follow the [general Homebrew contribution guidelines](https://github.com/Homebrew/brew/blob/master/CONTRIBUTING.md).

[xorg-libs]: http://www.x.org/wiki/guide/client-ecosystem
