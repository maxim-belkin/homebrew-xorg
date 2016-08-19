class FontBitstreamType1 < Formula
  desc "X.Org Fonts: font bitstream type1"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-bitstream-type1-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-bitstream-type1-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-bitstream-type1-1.0.3.tar.bz2"
  sha256 "c6ea0569adad2c577f140328dc3302e729cb1b1ea90cd0025caf380625f8a688"
  revision 2
  # tag "linuxbrew"

  keg_only "Part of Xorg-fonts package"

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
      --with-fontrootdir=#{share}/fonts/X11
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
