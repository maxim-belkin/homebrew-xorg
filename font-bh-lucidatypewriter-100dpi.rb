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
    sha256 "59e3b7522f8d014a0ae3f3a764db22a37930abff4da7ec363f68fa9ee4b5885e" => :x86_64_linux
  end

  keg_only "Part of Xorg-fonts package"

  depends_on "pkg-config" =>  :build
  depends_on "font-util"  =>  :build
  depends_on "bdftopcf"   =>  :build
  depends_on "mkfontdir"  =>  :build
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
