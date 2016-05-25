# font-adobe-75dpi: Build a bottle for Linuxbrew
class FontAdobe75dpi < Formula
  desc "X.Org Fonts: font adobe 75dpi"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-adobe-75dpi-1.0.3.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-adobe-75dpi-1.0.3.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-adobe-75dpi-1.0.3.tar.bz2"
  sha256 "c6024a1e4a1e65f413f994dd08b734efd393ce0a502eb465deb77b9a36db4d09"
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

    prefix.install "README" => "font-adobe-75dpi.md"
  end
end
