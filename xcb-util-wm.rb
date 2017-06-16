class XcbUtilWm < Formula
  desc "Client and window-manager helpers for EWMH and ICCCM"
  homepage "https://xcb.freedesktop.org"
  url "https://xcb.freedesktop.org/dist/xcb-util-wm-0.4.1.tar.bz2"
  sha256 "28bf8179640eaa89276d2b0f1ce4285103d136be6c98262b6151aaee1d3c2a3f"

  bottle do
    cellar :any_skip_relocation
    sha256 "86fd71256a1ba514acfb1f4018bdb797b8035d45427305d2a6e4f14576fa8e96" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static",  "Build static libraries (not recommended)"
  option "with-docs",    "Regenerate documentation (requires doxygen)"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "doxygen" => :build if build.with?("docs")
  depends_on "linuxbrew/xorg/libxcb"

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
