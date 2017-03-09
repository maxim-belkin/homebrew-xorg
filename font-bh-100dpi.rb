class FontBh100dpi < Formula
  desc "X.Org Fonts: font bh 100dpi"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-bh-100dpi-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-bh-100dpi-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-bh-100dpi-1.0.3.tar.bz2"
  sha256 "23c07162708e4b79eb33095c8bfa62c783717a9431254bbf44863734ea239481"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "3c54560deb82bf754a7ea1cb500a105a021fe7ffc9ec049fc89839a2f28a4b3b" => :x86_64_linux
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
