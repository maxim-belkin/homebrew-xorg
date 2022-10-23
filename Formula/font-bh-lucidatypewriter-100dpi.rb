class FontBhLucidatypewriter100dpi < Formula
  desc "X.Org Fonts: font bh lucidatypewriter 100dpi"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-bh-lucidatypewriter-100dpi-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-bh-lucidatypewriter-100dpi-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-bh-lucidatypewriter-100dpi-1.0.3.tar.bz2"
  sha256 "62a83363c2536095fda49d260d21e0847675676e4e3415054064cbdffa641fbb"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b678930a864d1c8bbb24c66f4fc0e20e1b5375272d9a1b3a1962e5d1213d1405"
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
