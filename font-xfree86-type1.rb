# font-xfree86-type1: Build a bottle for Linuxbrew
class FontXfree86Type1 < Formula
  desc "X.Org Fonts: font xfree86 type1"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-xfree86-type1-1.0.4.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-xfree86-type1-1.0.4.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-xfree86-type1-1.0.4.tar.bz2"
  sha256 "caebf42aec7be7f3bd40e0f232d6f34881b853dc84acfcdf7458358701fbe34a"
  # tag "linuxbrew"

  depends_on "pkg-config" =>  :build
  depends_on "font-util"  =>  :build
  depends_on "bdftopcf"   =>  :build
  depends_on "mkfontdir"  =>  :build
  depends_on "fontconfig" =>  :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--with-compression=bzip2" if build.with?("bzip2")

    system "./configure", *args
    system "make"
    system "make", "install"

    prefix.install "README" => "font-xfree86-type1.md"
  end
end
