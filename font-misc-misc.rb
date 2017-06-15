class FontMiscMisc < Formula
  desc "X.Org Fonts: font misc misc"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url "https://www.x.org/pub/individual/font/font-misc-misc-1.1.2.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-misc-misc-1.1.2.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-misc-misc-1.1.2.tar.bz2"
  sha256 "b8e77940e4e1769dc47ef1805918d8c9be37c708735832a07204258bacc11794"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "bf3f1917f6e6f3c944d88b68e356c48206349c477a4d2fde5758587d3c1d8f16" => :x86_64_linux
  end

  keg_only "Part of Xorg-fonts package"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/font-util"  => :build
  depends_on "linuxbrew/xorg/bdftopcf"   => :build
  depends_on "linuxbrew/xorg/mkfontdir"  => :build
  depends_on "fontconfig" => :build
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
