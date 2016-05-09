# libxft: Build a bottle for Linuxbrew
class Libxft < Formula
  desc "X.Org Libraries: libXft"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libXft-2.3.2.tar.bz2"
  sha256 "f5a3c824761df351ca91827ac221090943ef28b248573486050de89f4bfcdc4c"
  # tag "linuxbrew"

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-brewed-bzip2", "Use brewed bzip2"
  option "with-brewed-zlib", "Use brewed zlib"

  depends_on "pkg-config" =>  :build
  depends_on "fontconfig" =>  :build

  depends_on "libxrender" =>  :build
  depends_on "libx11"
  depends_on "bzip2"      if build.with?("brewed-bzip2")
  depends_on "zlib"       if build.with?("brewed-zlib")

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
