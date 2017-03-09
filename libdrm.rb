class Libdrm < Formula
  desc "libdrm: cross-driver middleware"
  homepage "http://dri.freedesktop.org"
  url "https://dri.freedesktop.org/libdrm/libdrm-2.4.68.tar.bz2"
  sha256 "5b4bd9a5922929bc716411cb74061fbf31b06ba36feb89bc1358a91a8d0ca9df"

  bottle do
    cellar :any_skip_relocation
    sha256 "0d2ff187d04da630e7672166826c030d5a703c6dd025a0d9828f131d75b04262" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static",   "Build static libraries (not recommended)"
  option "with-valgrind", "Build libdrm with valgrind support"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "linuxbrew/xorg/libpciaccess"
  depends_on "linuxbrew/xorg/libpthread-stubs" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-udev
    ]

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    ENV["ACLOCAL"] = "aclocal -I #{HOMEBREW_PREFIX}/share/aclocal"
    system "autoreconf", "-fiv"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
