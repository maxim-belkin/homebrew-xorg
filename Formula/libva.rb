class Libva < Formula
  desc "Hardware accelerated video processing library"
  homepage "https://github.com/01org/libva"
  url "https://github.com/intel/libva/releases/download/2.4.0/libva-2.4.0.tar.bz2"
  sha256 "99263056c21593a26f2ece812aee6fe60142b49e6cd46cb33c8dddf18fc19391"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "1457ad5efd5f70be88ff5ccabc2aaf9c937bae34426137eee83e03f8e670b42a" => :x86_64_linux
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
  depends_on "linuxbrew/xorg/libdrm"
  depends_on "linuxbrew/xorg/libx11"
  depends_on "linuxbrew/xorg/libxext"
  depends_on "linuxbrew/xorg/libxfixes"
  depends_on "linuxbrew/xorg/wayland"

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
