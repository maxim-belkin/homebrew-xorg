class XcbUtilImage < Formula
  desc "Additional extensions to the XCB library"
  homepage "https://xcb.freedesktop.org"
  url "https://xcb.freedesktop.org/dist/xcb-util-image-0.4.0.tar.bz2"
  sha256 "2db96a37d78831d643538dd1b595d7d712e04bdccf8896a5e18ce0f398ea2ffc"
  revision 1

  bottle do
    cellar :any_skip_relocation
  end

  option "without-test", "Skip compile-time tests"
  option "with-docs", "Regenerate documentation (requires doxygen)"

  depends_on "doxygen" => :build if build.with? "docs"
  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libxcb"
  depends_on "linuxbrew/xorg/xcb-util"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-devel-docs=#{build.with?("docs") ? "yes" : "no"}
      --with-doxygen=#{build.with?("docs") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    # Here we deviate from LFS instructions that specify
    # the following command:
    #    LD_LIBRARY_PATH=$XORG_PREFIX/lib make check
    system "make", "check" if build.with? "test"
    system "make", "install"
  end
end
