class Libxkbfile < Formula
  desc "X.Org Libraries: libxkbfile"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libxkbfile-1.1.0.tar.bz2"
  sha256 "758dbdaa20add2db4902df0b1b7c936564b7376c02a0acd1f2a331bd334b38c7"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "298c6f3d05f92b0b4bc0aebe9c91fede70d5535841114e74a27b835d06dffce5" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build

  depends_on "linuxbrew/xorg/libx11"

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
