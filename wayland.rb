class Wayland < Formula
  desc "A protocol for a compositor to talk to its clients"
  homepage "https://wayland.freedesktop.org"
  url "http://wayland.freedesktop.org/releases/wayland-1.10.0.tar.xz"
  sha256 "4bf6e790aa6f50ab3825676282ecd75850ec9c4767af96ecb7127b1f3c3d60dc"

  head do
    url "git://anongit.freedesktop.org/wayland/wayland"
  end

  option "with-static", "Build static libraries (not recommended)"
  option "without-test", "Skip compile-time tests"

  depends_on "pkg-config"  => :build
  depends_on "expat"
  depends_on "libffi"
  depends_on "autoconf" if build.head?
  depends_on "libxml2"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --disable-documentation
    ]

    args << "--enable-static=#{build.with?("static") ? "yes" : "no"}"

    if build.head?
      system "./autogen.sh", *args
    else
      system "./configure", *args
    end
    system "make"
    ENV.deparallelize
    system "make", "check" if build.with?("test")
    system "make", "install"
  end
end
