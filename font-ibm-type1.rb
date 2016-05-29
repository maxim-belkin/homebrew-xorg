# font-ibm-type1: Build a bottle for Linuxbrew
class FontIbmType1 < Formula
  desc "X.Org Fonts: font ibm type1"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-ibm-type1-1.0.3.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-ibm-type1-1.0.3.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-ibm-type1-1.0.3.tar.bz2"
  sha256 "fddb28d3db5a07f4b4ca15388488a9680a10e1367a18f358f903b2a608a5d2df"
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

    prefix.install "README" => "font-ibm-type1.md"
  end
end
