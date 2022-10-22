class FontBitstream100dpi < Formula
  desc "X.Org Fonts: font bitstream 100dpi"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-bitstream-100dpi-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-bitstream-100dpi-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-bitstream-100dpi-1.0.3.tar.bz2"
  sha256 "ebe0d7444e3d7c8da7642055ac2206f0190ee060700d99cd876f8fc9964cb6ce"
  revision 2

  keg_only "part of Xorg-fonts package"

  depends_on "bdftopcf" => :build
  depends_on "bzip2" => [:build, :recommended]
  depends_on "font-util" => :build
  depends_on "fontconfig" => :build
  depends_on "mkfontscale" => :build
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
