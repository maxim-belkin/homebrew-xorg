class Libxres < Formula
  desc "Xorg Libraries: libXres"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/lib/libXres-1.0.7.tar.bz2"
  sha256 "26899054aa87f81b17becc68e8645b240f140464cf90c42616ebb263ec5fa0e5"
  # tag "linuxbrew"

  option "with-check",  "Run a check before install"
  option "with-static", "Build static libraries"

  depends_on "pkg-config" =>  :build
  depends_on "fontconfig" =>  :build

  depends_on "libx11"
  depends_on "libxext"
  depends_on "xextproto" =>  :build
  depends_on "resourceproto" =>  :build

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
