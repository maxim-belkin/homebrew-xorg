# font-bh-type1: Build a bottle for Linuxbrew
class FontBhType1 < Formula
  desc "X.Org Fonts: font bh type1"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-bh-type1-1.0.3.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-bh-type1-1.0.3.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-bh-type1-1.0.3.tar.bz2"
  sha256 "761455a297486f3927a85d919b5c948d1d324181d4bea6c95d542504b68a63c1"
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

    prefix.install "README" => "font-bh-type1.md"
  end
end
