class FontAdobeUtopia75dpi < Formula
  desc "X.Org Fonts: font adobe utopia 75dpi"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-adobe-utopia-75dpi-1.0.4.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-adobe-utopia-75dpi-1.0.4.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-adobe-utopia-75dpi-1.0.4.tar.bz2"
  sha256 "8732719c61f3661c8bad63804ebfd54fc7de21ab848e9a26a19b1778ef8b5c94"
  revision 2
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "6c7f87758cd0ca6c36c74cec3d2c3ecf9eff4ab90096b33c93f03fbc867c4583" => :x86_64_linux
  end

  keg_only "part of Xorg-fonts package"

  depends_on "bzip2" => [:build, :recommended]
  depends_on "font-util" => :build
  depends_on "fontconfig" => :build
  depends_on "linuxbrew/xorg/bdftopcf" => :build
  depends_on "linuxbrew/xorg/mkfontscale" => :build
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
