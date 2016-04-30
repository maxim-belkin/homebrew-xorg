class XcbUtilImage < Formula
  desc "Additional extensions to the XCB library."
  homepage "http://xcb.freedesktop.org"
  url "http://xcb.freedesktop.org/dist/xcb-util-image-0.4.0.tar.bz2"
  sha256 "2db96a37d78831d643538dd1b595d7d712e04bdccf8896a5e18ce0f398ea2ffc"

  option "with-static", "Build static libraries"

  depends_on "pkg-config" => :build
  depends_on "libxcb"
  depends_on "xcb-util"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]
    args << "--disable-static" if !build.with?("static")

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
