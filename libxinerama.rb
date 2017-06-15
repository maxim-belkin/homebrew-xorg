class Libxinerama < Formula
  desc "X.Org Libraries: libXinerama"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "http://ftp.x.org/pub/individual/lib/libXinerama-1.1.3.tar.bz2"
  sha256 "7a45699f1773095a3f821e491cbd5e10c887c5a5fce5d8d3fced15c2ff7698e2"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "a3ee24b79619182dc6eb91705e6b5ae2eb87f68cf2b02c15513f3734c5a89b13" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build

  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/xextproto" => :build
  depends_on "linuxbrew/xorg/xineramaproto" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--disable-static" if build.without?("static")

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
