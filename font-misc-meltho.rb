# font-misc-meltho: Build a bottle for Linuxbrew
class FontMiscMeltho < Formula
  desc "X.Org Fonts: font misc meltho"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-misc-meltho-1.0.3.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-misc-meltho-1.0.3.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-misc-meltho-1.0.3.tar.bz2"
  sha256 "3721323f13855cf7ca609115a1f7b182491e9b2b9c6e01eb1a2c7f8edd480791"
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

    prefix.install "README" => "font-misc-meltho.md"
  end
end
