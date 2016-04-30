class Libfontenc < Formula
  desc "Xorg Libraries: libfontenc"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libfontenc-1.1.3.tar.bz2"
  sha256 "70588930e6fc9542ff38e0884778fbc6e6febf21adbab92fd8f524fe60aefd21"
  # tag "linuxbrew"

  option "with-check",  "Run a check before install"
  option "with-static", "Build static libraries"

  depends_on "pkg-config" =>  :build
  depends_on "fontconfig" =>  :build
  depends_on "xproto"     =>  :build

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
