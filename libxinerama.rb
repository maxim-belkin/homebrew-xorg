# libxinerama: Build a bottle for Linuxbrew
class Libxinerama < Formula
  desc "X.Org Libraries: libXinerama"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libXinerama-1.1.3.tar.bz2"
  sha256 "7a45699f1773095a3f821e491cbd5e10c887c5a5fce5d8d3fced15c2ff7698e2"
  # tag "linuxbrew"

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" =>  :build

  depends_on "libx11"
  depends_on "libxext"
  depends_on "xextproto"  =>  :build
  depends_on "xineramaproto" =>  :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--disable-static" if !build.with?("static")

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
