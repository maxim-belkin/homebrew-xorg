class FontDaewooMisc < Formula
  desc "X.Org Fonts: font daewoo misc"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-daewoo-misc-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-daewoo-misc-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-daewoo-misc-1.0.3.tar.bz2"
  sha256 "bc65de70bee12698caa95b523d3b652c056347e17b68cc8b5d6bbdff235c4be8"
  revision 2

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/font-daewoo-misc-1.0.3_2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0ac5ae39f4e2833f3d72c45347fcd3bd22681f6d8488a4064529e9d1d53e2ff1"
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
