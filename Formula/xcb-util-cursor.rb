class XcbUtilCursor < Formula
  desc "XCB cursor library (replacement for libXcursor)"
  homepage "https://xcb.freedesktop.org"
  url "https://xcb.freedesktop.org/dist/xcb-util-cursor-0.1.3.tar.bz2"
  sha256 "05a10a0706a1a789a078be297b5fb663f66a71fb7f7f1b99658264c35926394f"
  revision 1

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "5783dc42becf80a55702f12171bc0125d4fbf72380355b3d373c15b90ee568f8" => :x86_64_linux
  end

  option "with-docs", "Regenerate documentation (requires doxygen)"

  depends_on "doxygen" => :build if build.with? "docs"
  depends_on "m4" => :build
  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libxcb"
  depends_on "linuxbrew/xorg/xcb-util-image"
  depends_on "linuxbrew/xorg/xcb-util-renderutil"

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
    system "make", "install"
  end
end
