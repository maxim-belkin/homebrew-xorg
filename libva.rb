class Libva < Formula
  desc "Hardware accelerated video processing library"
  homepage "https://freedesktop.org/wiki/Software/vaapi/"
  url "https://www.freedesktop.org/software/vaapi/releases/libva/libva-1.7.3.tar.bz2"
  sha256 "22bc139498065a7950d966dbdb000cad04905cbd3dc8f3541f80d36c4670b9d9"

  bottle do
    sha256 "202cad95248823257d1d9cedefb76fc95593ef3dd61d93721a14f000f75bd0db" => :x86_64_linux
  end

  option "with-static", "Build static libraries (not recommended)"

  # Trivia: there is a circular dependency with Mesa.
  # Libva has to be installed:
  #  1. before Mesa >> with "disable-egl" and "disable-glx" options >> this package
  #  2. after  Mesa >> without these options
  # Step #2 is hard-coded into mesa (if built with [default] `with-libva`) as a post-installation step
  # Step #2 can be invoked manually here by specifying `with-eglx`

  option "with-eglx", "Build libva with egl and glx support (use after building mesa)"

  # Build-time
  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build

  depends_on "linuxbrew/xorg/libdrm"
  depends_on "linuxbrew/xorg/wayland" => :recommended

  depends_on "libtool" => :build if build.without?("wayland")

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-static=#{build.with?("static") ? "yes" : "no"}
    ]

    if build.without? "eglx"
      args << "--disable-egl"
      args << "--disable-glx"
    end

    system "autoreconf", "-fi" if build.without?("wayland")
    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
