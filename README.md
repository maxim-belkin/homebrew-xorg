# Linuxbrew Xorg

[![Actions Status](https://github.com/maxim-belkin/homebrew-xorg/workflows/Audit/badge.svg)](https://github.com/maxim-belkin/homebrew-xorg/actions)

Additional [Xorg libraries][xorg-libs] for Homebrew on Linux.

## How to use

[Tap](https://docs.brew.sh/Taps#the-brew-tap-command) this repository:

```sh
brew tap maxim-belkin/xorg
```

and install any library you want, for example:

```sh
brew install maxim-belkin/xorg/xrandr
```

## Provided formulae

Most popular Xorg formulae have been migrated to [Homebrew/homebrew-core](https://github.com/Homebrew/homebrew-core).
This tap now provides the following formulae:
<!--
( cd $(brew --repo maxim-belkin/xorg)/Formula; ls *.rb ) | sed 's/\([^.]\+\).rb/* \1/;' | sed 's|^|    |' | column -x -c 120 | expand
-->

    * encodings                             * font-misc-meltho                      * x11perf
    * font-adobe-100dpi                     * font-misc-misc                        * xbacklight
    * font-adobe-75dpi                      * font-mutt-misc                        * xcmsdb
    * font-adobe-utopia-100dpi              * font-schumacher-misc                  * xcursor-themes
    * font-adobe-utopia-75dpi               * font-screen-cyrillic                  * xcursorgen
    * font-adobe-utopia-type1               * font-sony-misc                        * xdriinfo
    * font-alias                            * font-sun-misc                         * xev
    * font-arabic-misc                      * font-winitzki-cyrillic                * xgamma
    * font-bh-100dpi                        * font-xfree86-type1                    * xhost
    * font-bh-75dpi                         * fontcacheproto                        * xkbevd
    * font-bh-lucidatypewriter-100dpi       * iceauth                               * xkbutils
    * font-bh-lucidatypewriter-75dpi        * intel-gmmlib                          * xkill
    * font-bh-ttf                           * intel-media-driver                    * xlsatoms
    * font-bh-type1                         * libevdev                              * xmessage
    * font-bitstream-100dpi                 * libglvnd                              * xorg-apps
    * font-bitstream-75dpi                  * libomxil-bellagio                     * xorg-cf-files
    * font-bitstream-type1                  * libsha1                               * xorg-docs
    * font-cronyx-cyrillic                  * libva-intel-driver                    * xorg-fonts
    * font-cursor-misc                      * libva-utils                           * xorg-sgml-doctools
    * font-daewoo-misc                      * libvdpau-va-gl                        * xpr
    * font-dec-misc                         * libwacom                              * xrandr
    * font-ibm-type1                        * libxfontcache                         * xrefresh
    * font-isas-misc                        * libxxf86misc                          * xset
    * font-jis-misc                         * mtdev                                 * xsetroot
    * font-micro-misc                       * sessreg                               * xvinfo
    * font-misc-cyrillic                    * setxkbmap                             * xwd
    * font-misc-ethiopic                    * smproxy                               * xwud

## How to contribute

We accept all sorts of contributions -- bug fixes, new formulae, formulae updates, etc.

[xorg-libs]: http://www.x.org/wiki/guide/client-ecosystem
