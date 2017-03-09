class FontSunMisc < Formula
  desc "X.Org Fonts: font sun misc"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-sun-misc-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-sun-misc-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-sun-misc-1.0.3.tar.bz2"
  sha256 "481f4fcbbf7005658b080b3cf342c8c76de752e77f47958b2b383de73266d2e0"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "c516e800165641ab852931d59a63d01cf2ce411fc6bdbac362bb06edf83ca855" => :x86_64_linux
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
