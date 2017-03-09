class FontMuttMisc < Formula
  desc "X.Org Fonts: font mutt misc"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-mutt-misc-1.0.3.tar.bz2"
  mirror "https://xorg.freedesktop.org/archive/individual/font/font-mutt-misc-1.0.3.tar.bz2"
  mirror "https://ftp.x.org/archive/individual/font/font-mutt-misc-1.0.3.tar.bz2"
  sha256 "bd5f7adb34367c197773a9801df5bce7b019664941900b2a31fbfe1ff2830f8f"
  revision 1
  # tag "linuxbrew"

  bottle do
    sha256 "6375fb662f3f8892cceb5e82779a74038479816fce9fd44920c72804248a366c" => :x86_64_linux
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
