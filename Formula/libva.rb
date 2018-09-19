class Libva < Formula
  desc "Hardware accelerated video processing library"
  homepage "https://github.com/01org/libva"
  url "https://github.com/intel/libva/releases/download/2.2.0/libva-2.2.0.tar.bz2"
  sha256 "6f6ca04c785544d30d315ef130a6aeb9435b75f934d7fbe0e4e9ba6084ce4ef2"

  bottle do
    sha256 "202cad95248823257d1d9cedefb76fc95593ef3dd61d93721a14f000f75bd0db" => :x86_64_linux
  end

  option "with-static", "Build static libraries (not recommended)"
  option "with-docs", "Build documentation"
  # option "with-eglx", "Build libva with egl and glx support (use after building mesa)"
  # Trivia: there is a circular dependency with Mesa.
  # Libva has to be installed:
  #  1. before Mesa >> with "disable-glx" >> this package
  #  2. after  Mesa >> without these options
  # Step #2 is hard-coded into mesa (if built with [default] `with-libva`) as a post-installation step
  # Step #2 can be invoked manually here by specifying `with-eglx`

  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/wayland"
  depends_on "linuxbrew/xorg/libdrm"
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/libxfixes"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-drm
      --enable-x11
      --enable-glx=no
      --enable-wayland
      --enable-docs=#{build.with?("docs") ? "yes" : "no"}
      --enable-static=#{build.with?("static") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
