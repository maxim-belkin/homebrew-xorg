# libvdpau: Build a bottle for Linuxbrew
class Libvdpau < Formula
  desc "Open source Video Decode and Presentation API library"
  homepage "http://people.freedesktop.org/"
  url "https://people.freedesktop.org/~aplattner/vdpau/libvdpau-1.1.1.tar.gz"
  sha256 "5fe093302432ef05086ca2ee429c789b7bf843e166d482d166e56859b08bef55"

  option "without-test", "Skip compile-time tests"
  option "with-static",   "Build static libraries (not recommended)"

  # Build-time
  depends_on "pkg-config" => :build

  # Required
  depends_on "dri2proto"
  depends_on "libxext"
  depends_on "libx11"

  # optional
  depends_on "doxygen"  => :optional
  depends_on "graphviz" => :optional
  depends_on "texlive"  => :optional

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    system "./configure", *args
    system "make"
    system "make", "check" if build.with?("test") # X11 connection rejected because of wrong authentication
    system "make", "install"
  end
end
