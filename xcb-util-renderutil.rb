class XcbUtilRenderutil < Formula
  desc "Additional extensions to the XCB library."
  homepage "http://xcb.freedesktop.org"
  url "https://xcb.freedesktop.org/dist/xcb-util-renderutil-0.3.9.tar.bz2"
  sha256 "c6e97e48fb1286d6394dddb1c1732f00227c70bd1bedb7d1acabefdd340bea5b"

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
    system "make", "install"
  end
end
