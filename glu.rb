class Glu < Formula
  desc "Mesa OpenGL Utility library"
  homepage "https://cgit.freedesktop.org/mesa/glu"
  url "ftp://ftp.freedesktop.org/pub/mesa/glu/glu-9.0.0.tar.bz2"
  sha256 "1f7ad0d379a722fcbd303aa5650c6d7d5544fde83196b42a73d1193568a4df12"

  bottle do
    cellar :any_skip_relocation
    sha256 "7f3743002c4472585848e401c6c9631b33b8386e6c4c19b622a9c9f9afadae95" => :x86_64_linux
  end

  option "with-static", "Build static libraries (not recommended)"

  # Build-time
  depends_on "pkg-config" => :build
  depends_on "libtool"    => :build

  # Required
  depends_on "linuxbrew/xorg/mesa"

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
