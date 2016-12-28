class Libxv < Formula
  desc "X.Org Libraries: libXv"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "http://ftp.x.org/pub/individual/lib/libXv-1.0.10.tar.bz2"
  sha256 "55fe92f8686ce8612e2c1bfaf58c057715534419da700bda8d517b1d97914525"
  # tag "linuxbrew"

  bottle do
    cellar :any
    sha256 "42d55fb18f9626930bca219df54d20b016c2931696d8bbb1d26ad75f8eedbb28" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build

  depends_on "libx11"
  depends_on "libxext"

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
