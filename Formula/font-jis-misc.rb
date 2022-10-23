class FontJisMisc < Formula
  desc "X.Org Fonts: font jis misc"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-jis-misc-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-jis-misc-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-jis-misc-1.0.3.tar.bz2"
  sha256 "2b18ce10b367ebafe95a17de799b6db9a24e2337188d124adaf68af05b1fac65"
  revision 2

  bottle do
    root_url "https://github.com/maxim-belkin/homebrew-xorg/releases/download/font-jis-misc-1.0.3_2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4c3496d1bf50ce6c45206ab2fe6cdf905907527a86b11c80da7c0e8923b527c4"
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
