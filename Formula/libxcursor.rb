class Libxcursor < Formula
  desc "X.Org Libraries: libXcursor"
  homepage "https://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://ftp.x.org/pub/individual/lib/libXcursor-1.1.15.tar.bz2"
  sha256 "294e670dd37cd23995e69aae626629d4a2dfe5708851bbc13d032401b7a3df6b"
  # tag "linuxbrew"

  bottle do
    sha256 "b416d2de1edef471cebc301b9865ae1ccd79480a6bae60685b637b2ca65f308a" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "linuxbrew/xorg/libxrender"
  depends_on "linuxbrew/xorg/libxfixes"
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
