class Libdrm < Formula
  desc "libdrm: cross-driver middleware"
  homepage "http://dri.freedesktop.org"
  url "https://dri.freedesktop.org/libdrm/libdrm-2.4.68.tar.bz2"
  sha256 "5b4bd9a5922929bc716411cb74061fbf31b06ba36feb89bc1358a91a8d0ca9df"

  option "without-test", "Skip compile-time tests"
  option "with-static",   "Build static libraries (not recommended)"
  option "with-valgrind", "Build libdrm with valgrind support"

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libpciaccess" => :build

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

    ## Get rid of dependency on libpthread-stubs
    inreplace "configure.ac", /PKG_CHECK_MODULES\(PTHREADSTUBS\, pthread-stubs\)/, ""

    ENV["ACLOCAL"] = "aclocal -I #{HOMEBREW_PREFIX}/share/aclocal"
    system "autoreconf", "-fiv"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
