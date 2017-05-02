class Libdrm < Formula
  desc "libdrm: cross-driver middleware"
  homepage "https://dri.freedesktop.org"
  url "https://dri.freedesktop.org/libdrm/libdrm-2.4.80.tar.bz2"
  sha256 "a82a519601e9cdfad795e760807eb07ac8913b225e25fc8fe9bc03e3be6549f1"

  bottle do
    cellar :any_skip_relocation
    sha256 "0d2ff187d04da630e7672166826c030d5a703c6dd025a0d9828f131d75b04262" => :x86_64_linux
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
