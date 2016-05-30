# font-misc-ethiopic: Build a bottle for Linuxbrew
class FontMiscEthiopic < Formula
  desc "X.Org Fonts: font misc ethiopic"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-misc-ethiopic-1.0.3.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-misc-ethiopic-1.0.3.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-misc-ethiopic-1.0.3.tar.bz2"
  sha256 "53cb1fd83afdbe7939c0eac34003676ee0e6023216892d98054db90b703c98a5"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
  depends_on "font-util"  =>  :build
  depends_on "bdftopcf"   =>  :build
  depends_on "mkfontdir"  =>  :build
  depends_on "fontconfig" =>  :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"

    prefix.install "README" => "font-misc-ethiopic.md"
  end
end
