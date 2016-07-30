# font-util: Build a bottle for Linuxbrew
class FontUtil < Formula
  desc "X.Org font package creation/installation utilities"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7font.html
  url    "https://www.x.org/pub/individual/font/font-util-1.3.1.tar.bz2"
  mirror "http://xorg.freedesktop.org/archive/individual/font/font-util-1.3.1.tar.bz2"
  mirror "http://ftp.x.org/archive/individual/font/font-util-1.3.1.tar.bz2"
  sha256 "aa7ebdb0715106dd255082f2310dbaa2cd7e225957c2a77d719720c7cc92b921"
  # tag "linuxbrew"

  option "without-test", "Skip compile-time tests"

  depends_on "pkg-config"    =>  :build
  depends_on "util-macros"   =>  :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
