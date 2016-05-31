# font-winitzki-cyrillic: Build a bottle for Linuxbrew
class FontWinitzkiCyrillic < Formula
  desc "X.Org Fonts: font winitzki cyrillic"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-winitzki-cyrillic-1.0.3.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-winitzki-cyrillic-1.0.3.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-winitzki-cyrillic-1.0.3.tar.bz2"
  sha256 "abd13b63d02fcaec488686c23683e5cf640b43bd32f8ca22eeae6f84df0a36a0"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
  depends_on "font-util"  =>  :build
  depends_on "bdftopcf"   =>  :build
  depends_on "mkfontdir"  =>  :build
  depends_on "fontconfig" =>  :build
  depends_on "bzip2"      => [:build, :recommended]

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--with-compression=bzip2" if build.with?("bzip2")

    system "./configure", *args
    system "make"
    system "make", "install"

    prefix.install "README" => "font-winitzki-cyrillic.md"
  end
end
