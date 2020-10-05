class FontMiscMeltho < Formula
  desc "X.Org Fonts: font misc meltho"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-misc-meltho-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-misc-meltho-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-misc-meltho-1.0.3.tar.bz2"
  sha256 "3721323f13855cf7ca609115a1f7b182491e9b2b9c6e01eb1a2c7f8edd480791"
  revision 2
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "209f4a6865d133d2ee5812705792f75fecfb2d099ae3a4a01c7057e27d6cb02a" => :x86_64_linux
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
