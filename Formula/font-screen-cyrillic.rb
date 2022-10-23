class FontScreenCyrillic < Formula
  desc "X.Org Fonts: font screen cyrillic"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-screen-cyrillic-1.0.4.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-screen-cyrillic-1.0.4.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-screen-cyrillic-1.0.4.tar.bz2"
  sha256 "824231e8dffe15299454e47259f29d98001c9cf8ad3d6b5171399e4d71705e79"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c983146864430e9f82a2c5833ee5eb296cd931c71f8b5513714a4c8357e2fbc9"
  end

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
