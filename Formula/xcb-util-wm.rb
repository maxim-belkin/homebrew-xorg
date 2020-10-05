class XcbUtilWm < Formula
  desc "Client and window-manager helpers for EWMH and ICCCM"
  homepage "https://xcb.freedesktop.org"
  url "https://xcb.freedesktop.org/dist/xcb-util-wm-0.4.1.tar.bz2"
  sha256 "28bf8179640eaa89276d2b0f1ce4285103d136be6c98262b6151aaee1d3c2a3f"
  revision 1

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "387b8481253e96bb4d1a8ab3b2208ed653788b6199d3c094ddfbffaec808412e" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-docs", "Regenerate documentation (requires doxygen)"

  depends_on "doxygen" => :build if build.with? "docs"
  depends_on "m4" => :build
  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libxcb"

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
