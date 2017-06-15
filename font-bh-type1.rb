class FontBhType1 < Formula
  desc "X.Org Fonts: font bh type1"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-bh-type1-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-bh-type1-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-bh-type1-1.0.3.tar.bz2"
  sha256 "761455a297486f3927a85d919b5c948d1d324181d4bea6c95d542504b68a63c1"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "f2661f4b46de64ac5cbeb5de96a4b520e02b9a6c49fb05d340d96d571d5479d8" => :x86_64_linux
  end

  keg_only "Part of Xorg-fonts package"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/font-util"  => :build
  depends_on "linuxbrew/xorg/bdftopcf"   => :build
  depends_on "linuxbrew/xorg/mkfontdir"  => :build
  depends_on "fontconfig" => :build

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
