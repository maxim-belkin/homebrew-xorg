class FontAdobeUtopiaType1 < Formula
  desc "X.Org Fonts: font adobe utopia type1"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-adobe-utopia-type1-1.0.4.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-adobe-utopia-type1-1.0.4.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-adobe-utopia-type1-1.0.4.tar.bz2"
  sha256 "979435105f897a70f8993fa02c8362160b0513366c2ab896965416f96dbb8077"
  revision 2

  keg_only "part of Xorg-fonts package"

  depends_on "bdftopcf" => :build
  depends_on "font-util" => :build
  depends_on "fontconfig" => :build
  depends_on "mkfontscale" => :build
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
