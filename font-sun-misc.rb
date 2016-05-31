# font-sun-misc: Build a bottle for Linuxbrew
class FontSunMisc < Formula
  desc "X.Org Fonts: font sun misc"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-sun-misc-1.0.3.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-sun-misc-1.0.3.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-sun-misc-1.0.3.tar.bz2"
  sha256 "481f4fcbbf7005658b080b3cf342c8c76de752e77f47958b2b383de73266d2e0"
  # tag "linuxbrew"

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
    ]
    args << "--with-compression=bzip2" if build.with?("bzip2")

    system "./configure", *args
    system "make"
    system "make", "install"

    prefix.install "README" => "font-sun-misc.md"
  end
end
