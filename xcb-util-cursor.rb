class XcbUtilCursor < Formula
  desc "XCB cursor library (replacement for libXcursor)"
  homepage "https://xcb.freedesktop.org"
  url "https://xcb.freedesktop.org/dist/xcb-util-cursor-0.1.3.tar.bz2"
  sha256 "05a10a0706a1a789a078be297b5fb663f66a71fb7f7f1b99658264c35926394f"

  option "with-static", "Build static libraries (not recommended)"
  option "with-docs", "Regenerate documentation (requires doxygen)"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/util-macros" => :build
  depends_on "doxygen" => :build if build.with? "docs"
  depends_on "linuxbrew/xorg/libxcb"
  depends_on "linuxbrew/xorg/xcb-util-image"
  depends_on "linuxbrew/xorg/xcb-util-renderutil"

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
    system "make", "install"
  end
end
