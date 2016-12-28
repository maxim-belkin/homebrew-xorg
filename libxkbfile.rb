class Libxkbfile < Formula
  desc "X.Org Libraries: libxkbfile"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libxkbfile-1.0.9.tar.bz2"
  sha256 "51817e0530961975d9513b773960b4edd275f7d5c72293d5a151ed4f42aeb16a"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "298c6f3d05f92b0b4bc0aebe9c91fede70d5535841114e74a27b835d06dffce5" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build

  depends_on "libx11"
  depends_on "kbproto" => :build

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
