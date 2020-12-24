class XcbUtilXrm < Formula
  desc "XCB utility functions for the X resource manager"
  homepage "https://github.com/Airblader/xcb-util-xrm"
  url "https://github.com/Airblader/xcb-util-xrm/releases/download/v1.3/xcb-util-xrm-1.3.tar.bz2"
  sha256 "301cf33701207ea8782d49f4cb6404abd8f2d64e16f242017fd720be7c900c85"
  license "X11"

  head do
    url "https://github.com/Airblader/xcb-util-xrm.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
    depends_on "util-macros" => :build
  end

  depends_on "pkg-config" => [:build, :test]
  depends_on "libx11"
  depends_on "libxcb"
  depends_on "xcb-util"

  uses_from_macos "m4" => :build

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--localstatedir=#{var}",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "-I#{include}", shell_output("pkg-config --cflags xcb-xrm")
  end
end
