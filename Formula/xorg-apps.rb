class XorgApps < Formula
  desc "X.Org Applications"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://gist.githubusercontent.com/maxim-belkin/6916a35b777799d4e71b213eaae8a980/raw/974f263825c96a43310fca7a8106d0c7c015b681/README.md"
  version  "20160522"
  sha256   "d6f8969d76bd3236c40e57fc3f498c43341f3f1e9ae01c4c2bca11876f07adc6"
  revision 1
  # tag "linuxbrew"

  livecheck do
    skip "Formula only installs other formulae"
  end

  bottle :unneeded

  depends_on "linuxbrew/xorg/bdftopcf"
  depends_on "linuxbrew/xorg/iceauth"
  depends_on "linuxbrew/xorg/luit"
  depends_on "linuxbrew/xorg/mkfontscale"
  depends_on "linuxbrew/xorg/sessreg"
  depends_on "linuxbrew/xorg/setxkbmap"
  depends_on "linuxbrew/xorg/smproxy"
  depends_on "linuxbrew/xorg/x11perf"
  depends_on "linuxbrew/xorg/xauth"
  depends_on "linuxbrew/xorg/xbacklight"
  depends_on "linuxbrew/xorg/xcmsdb"
  depends_on "linuxbrew/xorg/xcursorgen"
  depends_on "linuxbrew/xorg/xdriinfo"
  depends_on "linuxbrew/xorg/xev"
  depends_on "linuxbrew/xorg/xgamma"
  depends_on "linuxbrew/xorg/xhost"
  depends_on "linuxbrew/xorg/xinput"
  depends_on "linuxbrew/xorg/xkbcomp"
  depends_on "linuxbrew/xorg/xkbevd"
  depends_on "linuxbrew/xorg/xkbutils"
  depends_on "linuxbrew/xorg/xkill"
  depends_on "linuxbrew/xorg/xlsatoms"
  depends_on "linuxbrew/xorg/xlsclients"
  depends_on "linuxbrew/xorg/xmessage"
  depends_on "linuxbrew/xorg/xmodmap"
  depends_on "linuxbrew/xorg/xpr"
  depends_on "linuxbrew/xorg/xprop"
  depends_on "linuxbrew/xorg/xrandr"
  depends_on "linuxbrew/xorg/xrdb"
  depends_on "linuxbrew/xorg/xrefresh"
  depends_on "linuxbrew/xorg/xset"
  depends_on "linuxbrew/xorg/xsetroot"
  depends_on "linuxbrew/xorg/xvinfo"
  depends_on "linuxbrew/xorg/xwd"
  depends_on "linuxbrew/xorg/xwininfo"
  depends_on "linuxbrew/xorg/xwud"
  depends_on "xdpyinfo"

  def install
    ohai "Xorg Applications have been installed!"
    prefix.install "README.md" => "xorg-apps.md"
  end
end
