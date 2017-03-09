class XcbUtilImage < Formula
  desc "Additional extensions to the XCB library."
  homepage "https://xcb.freedesktop.org"
  url "https://xcb.freedesktop.org/dist/xcb-util-image-0.4.0.tar.bz2"
  sha256 "2db96a37d78831d643538dd1b595d7d712e04bdccf8896a5e18ce0f398ea2ffc"

  bottle do
    cellar :any_skip_relocation
    sha256 "894626a6f578dbbae9b0d314e38afbabb1506125ffbafaa4411e5a13408052b3" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static",  "Build static libraries (not recommended)"
  option "with-docs",    "Regenerate documentation (requires doxygen)"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "doxygen" => :build if build.with?("docs")
  depends_on "linuxbrew/xorg/libxcb"
  depends_on "linuxbrew/xorg/xcb-util"

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
