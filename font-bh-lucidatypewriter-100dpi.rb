class FontBhLucidatypewriter100dpi < Formula
  desc "X.Org Fonts: font bh lucidatypewriter 100dpi"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-bh-lucidatypewriter-100dpi-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-bh-lucidatypewriter-100dpi-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-bh-lucidatypewriter-100dpi-1.0.3.tar.bz2"
  sha256 "62a83363c2536095fda49d260d21e0847675676e4e3415054064cbdffa641fbb"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "1acd5d3c7eb230a2cf8fe4d125522f3893cbb4691eb5d31740965135a3a9e564" => :x86_64_linux
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
