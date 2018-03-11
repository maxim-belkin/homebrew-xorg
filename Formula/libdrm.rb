class Libdrm < Formula
  desc "Library for accessing the direct rendering manager"
  homepage "https://dri.freedesktop.org"
  url "https://dri.freedesktop.org/libdrm/libdrm-2.4.82.tar.bz2"
  sha256 "43fa2dbd422d6d41ac141272cc9855360ce4d08c7cf7f2c7bb55dfe449c4ce1c"

  bottle do
    sha256 "6993d092717699c084bb6723576475183c675f9f19aa9c4e051ee19bfa892cf5" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-valgrind", "Build libdrm with valgrind support"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libpciaccess"
  depends_on "cunit" => :build if build.with? "test"
  depends_on "cairo" => :build if build.with? "test"
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
