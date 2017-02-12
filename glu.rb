# glu: Build a bottle for Linuxbrew
class Glu < Formula
  desc "Mesa OpenGL Utility library"
  homepage "https://cgit.freedesktop.org/mesa/glu"
  url "ftp://ftp.freedesktop.org/pub/mesa/glu/glu-9.0.0.tar.bz2"
  sha256 "1f7ad0d379a722fcbd303aa5650c6d7d5544fde83196b42a73d1193568a4df12"

  option "with-static", "Build static libraries (not recommended)"

  # Build-time
  depends_on "pkg-config" => :build
  depends_on "libtool"    => :build

  # Required
  depends_on "mesa"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    # Be explicit about the configure flags
    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
