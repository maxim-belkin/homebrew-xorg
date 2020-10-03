class FontCronyxCyrillic < Formula
  desc "X.Org Fonts: font cronyx cyrillic"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-cronyx-cyrillic-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-cronyx-cyrillic-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-cronyx-cyrillic-1.0.3.tar.bz2"
  sha256 "6e8631936157677c77ba032b5c7b1fb3cb2ee872dbcea0444f12cd602cd9212a"
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
