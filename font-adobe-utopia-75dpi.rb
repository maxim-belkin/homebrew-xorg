class FontAdobeUtopia75dpi < Formula
  desc "X.Org Fonts: font adobe utopia 75dpi"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-adobe-utopia-75dpi-1.0.4.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-adobe-utopia-75dpi-1.0.4.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-adobe-utopia-75dpi-1.0.4.tar.bz2"
  sha256 "8732719c61f3661c8bad63804ebfd54fc7de21ab848e9a26a19b1778ef8b5c94"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "293b881efa2650c70d603725b62beef60a99c15037617b5666622267d111fada" => :x86_64_linux
  end

  keg_only "Part of Xorg-fonts package"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/font-util"  => :build
  depends_on "linuxbrew/xorg/bdftopcf"   => :build
  depends_on "linuxbrew/xorg/mkfontdir"  => :build
  depends_on "fontconfig" => :build
  depends_on "bzip2"      => [:build, :recommended]

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-fontrootdir=#{share}/fonts/X11
    ]
    args << "--with-compression=bzip2" if build.with?("bzip2")

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
