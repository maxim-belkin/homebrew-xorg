# Linuxbrew Xorg

[![Actions Status](https://github.com/Linuxbrew/homebrew-xorg/workflows/Audit/badge.svg)](https://github.com/Linuxbrew/homebrew-xorg/actions)

Additional [Xorg libraries][xorg-libs] for Homebrew on Linux.

## How to use

[Tap](https://docs.brew.sh/Taps#the-brew-tap-command) this repository:

```sh
brew tap linuxbrew/xorg
```

and install any library you want, for example:

```sh
brew install linuxbrew/xorg/xrandr
```

## Provided formulae

Most popular Xorg formulae have been migrated to [Homebrew/linuxbrew-core](https://github.com/Homebrew/linuxbrew-core).
This tap now provides the following formulae:
<!-- 
( cd $(brew --repo linuxbrew/xorg)/Formula; ls *.rb ) | sed 's/\([^.]\+\).rb/* \1/;' | sed 's|^|    |' | column -x -c 120 | expand
-->

    * bdftopcf                              * encodings                             * font-adobe-100dpi
    * font-adobe-75dpi                      * font-adobe-utopia-100dpi              * font-adobe-utopia-75dpi
    * font-adobe-utopia-type1               * font-alias                            * font-arabic-misc
    * font-bh-100dpi                        * font-bh-75dpi                         * font-bh-lucidatypewriter-100dpi
    * font-bh-lucidatypewriter-75dpi        * font-bh-ttf                           * font-bh-type1
    * font-bitstream-100dpi                 * font-bitstream-75dpi                  * font-bitstream-type1
    * font-cronyx-cyrillic                  * font-cursor-misc                      * font-daewoo-misc
    * font-dec-misc                         * font-ibm-type1                        * font-isas-misc
    * font-jis-misc                         * font-micro-misc                       * font-misc-cyrillic
    * font-misc-ethiopic                    * font-misc-meltho                      * font-misc-misc
    * font-mutt-misc                        * font-schumacher-misc                  * font-screen-cyrillic
    * font-sony-misc                        * font-sun-misc                         * font-winitzki-cyrillic
    * font-xfree86-type1                    * fontcacheproto                        * iceauth
    * intel-gmmlib                          * intel-media-driver                    * libevdev
    * libglvnd                              * libgudev                              * libomxil-bellagio
    * libsha1                               * libva-intel-driver                    * libva-utils
    * libvdpau-va-gl                        * libwacom                              * libxfont2
    * libxfontcache                         * libxxf86misc                          * luit
    * mkfontscale                           * mtdev                                 * pciutils
    * sessreg                               * setxkbmap                             * smproxy
    * umockdev                              * x11perf                               * xauth
    * xbacklight                            * xcmsdb                                * xcursor-themes
    * xcursorgen                            * xdriinfo                              * xev
    * xgamma                                * xhost                                 * xkbcomp
    * xkbevd                                * xkbutils                              * xkill
    * xlsatoms                              * xlsclients                            * xmessage
    * xmodmap                               * xorg-apps                             * xorg-cf-files
    * xorg-docs                             * xorg-fonts                            * xorg-sgml-doctools
    * xpr                                   * xprop                                 * xrandr
    * xrdb                                  * xrefresh                              * xset
    * xsetroot                              * xvinfo                                * xwd
    * xwininfo                              * xwud


## How to contribute

We accept all sorts of contributions -- bug fixes, new formulae, formulae updates, etc.

[xorg-libs]: http://www.x.org/wiki/guide/client-ecosystem
