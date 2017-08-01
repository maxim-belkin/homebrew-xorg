class Libdrm < Formula
  desc "Library for accessing the direct rendering manager"
  homepage "https://dri.freedesktop.org"
  url "https://dri.freedesktop.org/libdrm/libdrm-2.4.82.tar.bz2"
  sha256 "43fa2dbd422d6d41ac141272cc9855360ce4d08c7cf7f2c7bb55dfe449c4ce1c"

  bottle do
    sha256 "f16f0b130bb765d8fe39400b4a32ca2aa955594538f1c7184f636231f9139124" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-valgrind", "Build libdrm with valgrind support"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libpciaccess"
  depends_on "cunit" if build.with? "test"
  depends_on "cairo" if build.with? "test"
  depends_on "valgrind" => :optional

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-udev
    ]
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
