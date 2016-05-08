# libxscrnsaver: Build a bottle for Linuxbrew
class Libxscrnsaver < Formula
  desc "X.Org Libraries: libXScrnSaver"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libXScrnSaver-1.2.2.tar.bz2"
  sha256 "8ff1efa7341c7f34bcf9b17c89648d6325ddaae22e3904e091794e0b4426ce1d"
  # tag "linuxbrew"

  option "with-check",  "Run a check before install"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" =>  :build

  depends_on "libx11"
  depends_on "libxext"
  depends_on "xextproto" =>  :build
  depends_on "scrnsaverproto" =>  :build

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
