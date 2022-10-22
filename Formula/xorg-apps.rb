class XorgApps < Formula
  desc "X.Org Applications"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://gist.githubusercontent.com/maxim-belkin/6916a35b777799d4e71b213eaae8a980/raw/974f263825c96a43310fca7a8106d0c7c015b681/README.md"
  version  "20160522"
  sha256   "d6f8969d76bd3236c40e57fc3f498c43341f3f1e9ae01c4c2bca11876f07adc6"
  revision 2

  livecheck do
    skip "Formula only installs other formulae"
  end

  depends_on "bdftopcf"
  depends_on "luit"
  depends_on "maxim-belkin/xorg/iceauth"
  depends_on "maxim-belkin/xorg/sessreg"
  depends_on "maxim-belkin/xorg/setxkbmap"
  depends_on "maxim-belkin/xorg/smproxy"
  depends_on "maxim-belkin/xorg/x11perf"
  depends_on "maxim-belkin/xorg/xbacklight"
  depends_on "maxim-belkin/xorg/xcmsdb"
  depends_on "maxim-belkin/xorg/xcursorgen"
  depends_on "maxim-belkin/xorg/xdriinfo"
  depends_on "maxim-belkin/xorg/xev"
  depends_on "maxim-belkin/xorg/xgamma"
  depends_on "maxim-belkin/xorg/xhost"
  depends_on "maxim-belkin/xorg/xkbevd"
  depends_on "maxim-belkin/xorg/xkbutils"
  depends_on "maxim-belkin/xorg/xkill"
  depends_on "maxim-belkin/xorg/xlsatoms"
  depends_on "maxim-belkin/xorg/xlsclients"
  depends_on "maxim-belkin/xorg/xmessage"
  depends_on "maxim-belkin/xorg/xmodmap"
  depends_on "maxim-belkin/xorg/xpr"
  depends_on "maxim-belkin/xorg/xprop"
  depends_on "maxim-belkin/xorg/xrandr"
  depends_on "maxim-belkin/xorg/xrdb"
  depends_on "maxim-belkin/xorg/xrefresh"
  depends_on "maxim-belkin/xorg/xset"
  depends_on "maxim-belkin/xorg/xsetroot"
  depends_on "maxim-belkin/xorg/xvinfo"
  depends_on "maxim-belkin/xorg/xwd"
  depends_on "maxim-belkin/xorg/xwininfo"
  depends_on "maxim-belkin/xorg/xwud"
  depends_on "mkfontscale"
  depends_on "xauth"
  depends_on "xdpyinfo"
  depends_on "xinput"
  depends_on "xkbcomp"

  def install
    ohai "Xorg Applications have been installed!"
    prefix.install "README.md" => "xorg-apps.md"
  end
end
