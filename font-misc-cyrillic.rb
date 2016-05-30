# font-misc-cyrillic: Build a bottle for Linuxbrew
class FontMiscCyrillic < Formula
  desc "X.Org Fonts: font misc cyrillic"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-misc-cyrillic-1.0.3.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-misc-cyrillic-1.0.3.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-misc-cyrillic-1.0.3.tar.bz2"
  sha256 "e40fe3e3323c62b738550795457ad555c70c008aa91b5912dfd46f8e745f5e60"
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

    prefix.install "README" => "font-misc-cyrillic.md"
  end
end
