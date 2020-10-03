class FontDaewooMisc < Formula
  desc "X.Org Fonts: font daewoo misc"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-daewoo-misc-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-daewoo-misc-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-daewoo-misc-1.0.3.tar.bz2"
  sha256 "bc65de70bee12698caa95b523d3b652c056347e17b68cc8b5d6bbdff235c4be8"
  revision 2
  # tag "linuxbrew"

  bottle do
  end

  keg_only "part of Xorg-fonts package"

  depends_on "bzip2" => [:build, :recommended]
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
    args << "--with-compression=bzip2" if build.with? "bzip2"

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
