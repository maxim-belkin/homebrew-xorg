class FontMiscMisc < Formula
  desc "X.Org Fonts: font misc misc"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-misc-misc-1.1.2.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-misc-misc-1.1.2.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-misc-misc-1.1.2.tar.bz2"
  sha256 "b8e77940e4e1769dc47ef1805918d8c9be37c708735832a07204258bacc11794"
  revision 2

  keg_only "part of Xorg-fonts package"

  depends_on "bdftopcf" => :build
  depends_on "bzip2" => [:build, :recommended]
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
    args << "--with-compression=bzip2" if build.with? "bzip2"

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
