class XcbUtilKeysyms < Formula
  desc "Additional extensions to the XCB library."
  homepage "http://xcb.freedesktop.org"
  url "https://xcb.freedesktop.org/dist/xcb-util-keysyms-0.4.0.tar.bz2"
  sha256 "0ef8490ff1dede52b7de533158547f8b454b241aa3e4dcca369507f66f216dd9"

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-docs", "Regenerate documentation (requires doxygen)"

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "doxygen" => :build if build.with?("docs")
  depends_on "libxcb"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"
    args << "--enable-devel-docs=#{build.with?("docs") ? "yes" : "no"}"
    args << "--with-doxygen=#{build.with?("docs") ? "yes" : "no"}"

    system "./configure", *args
    system "make"
    # Here we deviate from LFS instructions that specify
    # the following command:
    #    LD_LIBRARY_PATH=$XORG_PREFIX/lib make check
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
