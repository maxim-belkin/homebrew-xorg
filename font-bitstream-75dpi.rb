# font-bitstream-75dpi: Build a bottle for Linuxbrew
# font-bitstream-75dpi: Build a bottle for Linuxbrew
class FontBitstream75dpi < Formula
  desc "X.Org Fonts: font bitstream 75dpi"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-bitstream-75dpi-1.0.3.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-bitstream-75dpi-1.0.3.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-bitstream-75dpi-1.0.3.tar.bz2"
  sha256 "ba3f5e4610c07bd5859881660753ec6d75d179f26fc967aa776dbb3d5d5cf48e"
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

    prefix.install "README" => "font-bitstream-75dpi.md"
  end
end
