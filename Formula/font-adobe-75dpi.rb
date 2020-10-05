class FontAdobe75dpi < Formula
  desc "X.Org Fonts: font adobe 75dpi"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-adobe-75dpi-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-adobe-75dpi-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-adobe-75dpi-1.0.3.tar.bz2"
  sha256 "c6024a1e4a1e65f413f994dd08b734efd393ce0a502eb465deb77b9a36db4d09"
  revision 2
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "448fbcf2dd37b83aa4f96f5fd7690c0228f3d28d258148764eaf3def5f3d3297" => :x86_64_linux
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
