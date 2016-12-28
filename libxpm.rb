class Libxpm < Formula
  desc "X.Org Libraries: libXpm"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "http://ftp.x.org/pub/individual/lib/libXpm-3.5.12.tar.bz2"
  sha256 "fd6a6de3da48de8d1bb738ab6be4ad67f7cb0986c39bd3f7d51dd24f7854bdec"
  # tag "linuxbrew"

  bottle do
    sha256 "a9b2986ef5078c882eee59116658484bf61fdd13d8d1d61b737ff26445d8c8f2" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "gettext" => :build
  depends_on "xproto" => :build
  depends_on "libx11"

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
