class Libvdpau < Formula
  desc "Open source Video Decode and Presentation API library"
  homepage "https://www.freedesktop.org/wiki/Software/VDPAU/"
  url "https://people.freedesktop.org/~aplattner/vdpau/libvdpau-1.1.1.tar.gz"
  sha256 "5fe093302432ef05086ca2ee429c789b7bf843e166d482d166e56859b08bef55"

  bottle do
    sha256 "4f6c58d9040e7ee0a5206b7f76be36df402219ff112b6e4d69278f6ee97bb7c3" => :x86_64_linux
  end

  option "without-test", "Skip compile-time tests"
  option "with-static", "Build static libraries (not recommended)"
  option "with-docs", "Build documentation"

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/xorgproto"

  if build.with? "docs"
    depends_on "doxygen" => :build
    depends_on "graphviz" => :build
    depends_on "texlive" => :build
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-static=#{build.with?("static") ? "yes" : "no"}
      --enable-documentation=#{build.with?("docs") ? "yes" : "no"}
      --enable-dri2
    ]

    system "./configure", *args
    system "make"
    system "make", "check" if build.with? "test" # X11 connection rejected because of wrong authentication
    system "make", "install"
  end
end
