# xdpyinfo: Build a bottle for Linuxbrew
class Xdpyinfo < Formula
  desc "X.Org Applications: xdpyinfo"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/app/xdpyinfo-1.3.2.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/app/xdpyinfo-1.3.2.tar.bz2"
  sha256 "30238ed915619e06ceb41721e5f747d67320555cc38d459e954839c189ccaf51"
  # tag "linuxbrew"


  depends_on "pkg-config" =>  :build
  depends_on "libxext"
  depends_on "libx11"
  depends_on "libxtst"
  depends_on "libxcb"
  depends_on "xproto" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
      #  --without-dga           Disable dga support.                          
      #  --without-xf86misc      Disable xf86misc support.                     
      #  --without-xinerama      Disable xinerama support.                     
      #  --without-dmx           Disable dmx support.

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
