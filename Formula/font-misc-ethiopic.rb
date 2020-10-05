class FontMiscEthiopic < Formula
  desc "X.Org Fonts: font misc ethiopic"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-misc-ethiopic-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-misc-ethiopic-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-misc-ethiopic-1.0.3.tar.bz2"
  sha256 "53cb1fd83afdbe7939c0eac34003676ee0e6023216892d98054db90b703c98a5"
  revision 2
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "f04866931ead9aea5924f41ca48cedbd1dbabbb69b2bd69751ce8b0b0b6c398d" => :x86_64_linux
  end

  keg_only "part of Xorg-fonts package"

  depends_on "font-util" => :build
  depends_on "fontconfig" => :build
  depends_on "linuxbrew/xorg/bdftopcf" => :build
  depends_on "linuxbrew/xorg/mkfontscale" => :build
  depends_on "pkg-config" => :build

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
