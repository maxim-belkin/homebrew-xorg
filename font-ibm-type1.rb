class FontIbmType1 < Formula
  desc "X.Org Fonts: font ibm type1"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-ibm-type1-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-ibm-type1-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-ibm-type1-1.0.3.tar.bz2"
  sha256 "fddb28d3db5a07f4b4ca15388488a9680a10e1367a18f358f903b2a608a5d2df"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "e5557df70a617f487529147dd44834abcc8ee20e364f9ff558adcb0ec38b40b2" => :x86_64_linux
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
