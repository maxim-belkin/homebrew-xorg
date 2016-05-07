# libxfixes: Build a bottle for Linuxbrew
class Libxfixes < Formula
  desc "X.Org Libraries: libXfixes"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libXfixes-5.0.1.tar.bz2"
  sha256 "63bec085084fa3caaee5180490dd871f1eb2020ba9e9b39a30f93693ffc34767"
  # tag "linuxbrew"

  option "with-check",  "Run a check before install"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" =>  :build

  depends_on "xproto"     =>  :build
  depends_on "fixesproto" =>  :build
  depends_on "xextproto"  =>  :build
  depends_on "libx11"

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
    system "make", "check" if build.with?("check")
    system "make", "install"
  end
end
