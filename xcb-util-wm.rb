class XcbUtilWm < Formula
  desc "Libraries which provide client and window-manager helpers for EWMH and ICCCM"
  homepage "http://xcb.freedesktop.org"
  url "http://xcb.freedesktop.org/dist/xcb-util-wm-0.4.1.tar.bz2"
  sha256 "28bf8179640eaa89276d2b0f1ce4285103d136be6c98262b6151aaee1d3c2a3f"

  option "with-static", "Build static libraries"

  depends_on "pkg-config" => :build
  depends_on "libxcb"
  depends_on "doxygen"    => [:build, :recommended]

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
    ]
    args << "--disable-static" if !build.with?("static")

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
