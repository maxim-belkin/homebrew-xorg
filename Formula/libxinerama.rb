class Libxinerama < Formula
  desc "X.Org Libraries: libXinerama"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXinerama-1.1.4.tar.bz2"
  sha256 "0008dbd7ecf717e1e507eed1856ab0d9cf946d03201b85d5dcf61489bb02d720"
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
      --enable-static=#{build.with?("static") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
