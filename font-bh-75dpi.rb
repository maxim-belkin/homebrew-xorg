class FontBh75dpi < Formula
  desc "X.Org Fonts: font bh 75dpi"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-bh-75dpi-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-bh-75dpi-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-bh-75dpi-1.0.3.tar.bz2"
  sha256 "3486aa51ac92c646a448fe899c5c3dae0024b1fef724d5100d52640d1cac721c"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "608037ec9689715468ff01fcbc2c3489643967b61ed55caf05a10c59ab20515e" => :x86_64_linux
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
