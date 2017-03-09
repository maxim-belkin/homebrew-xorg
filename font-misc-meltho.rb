class FontMiscMeltho < Formula
  desc "X.Org Fonts: font misc meltho"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-misc-meltho-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-misc-meltho-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-misc-meltho-1.0.3.tar.bz2"
  sha256 "3721323f13855cf7ca609115a1f7b182491e9b2b9c6e01eb1a2c7f8edd480791"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "fde87b8065adb016d78cf6b9b16fa4eface5109cc75269a3008135dfe4ad991d" => :x86_64_linux
  end

  keg_only "Part of Xorg-fonts package"

  depends_on "pkg-config" =>  :build
  depends_on "linuxbrew/xorg/font-util"  =>  :build
  depends_on "linuxbrew/xorg/bdftopcf"   =>  :build
  depends_on "linuxbrew/xorg/mkfontdir"  =>  :build
  depends_on "fontconfig" =>  :build

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
