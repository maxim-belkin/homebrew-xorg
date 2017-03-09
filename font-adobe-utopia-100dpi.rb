class FontAdobeUtopia100dpi < Formula
  desc "X.Org Fonts: font adobe utopia 100dpi"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-adobe-utopia-100dpi-1.0.4.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-adobe-utopia-100dpi-1.0.4.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-adobe-utopia-100dpi-1.0.4.tar.bz2"
  sha256 "d16f5e3f227cc6dd07a160a71f443559682dbc35f1c056a5385085aaec4fada5"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "3d01428b722e9f7e9212957ee6bcce9c7d890fe118f8b483f43370728cead900" => :x86_64_linux
  end

  keg_only "Part of Xorg-fonts package"

  depends_on "pkg-config" =>  :build
  depends_on "linuxbrew/xorg/font-util"  =>  :build
  depends_on "linuxbrew/xorg/bdftopcf"   =>  :build
  depends_on "linuxbrew/xorg/mkfontdir"  =>  :build
  depends_on "fontconfig" =>  :build
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
