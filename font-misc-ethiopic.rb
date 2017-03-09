class FontMiscEthiopic < Formula
  desc "X.Org Fonts: font misc ethiopic"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-misc-ethiopic-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-misc-ethiopic-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-misc-ethiopic-1.0.3.tar.bz2"
  sha256 "53cb1fd83afdbe7939c0eac34003676ee0e6023216892d98054db90b703c98a5"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "0d5247e5301246e6d86f50d73901d952d76bc58f9e88973340d61d6d51530557" => :x86_64_linux
  end

  keg_only "Part of Xorg-fonts package"

  depends_on "pkg-config" =>  :build
  depends_on "linuxbrew/xorg/font-util"  =>  :build
  depends_on "linuxbrew/xorg/bdftopcf"   =>  :build
  depends_on "linuxbrew/xorg/mkfontdir"  =>  :build
  depends_on "fontconfig" =>  :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-fontrootdir=#{share}/fonts/X11
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
