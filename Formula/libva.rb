class Libva < Formula
  desc "Hardware accelerated video processing library"
  homepage "https://github.com/01org/libva"
  url "https://github.com/intel/libva/releases/download/2.6.0/libva-2.6.0.tar.bz2"
  sha256 "486bb6b5761db6e5a9f4475bd187e0bfa7309944cfc9734d496d41930353d6c5"

  bottle do
    cellar :any_skip_relocation
    sha256 "0921829206d23d841b16885b7a2ef94e955f0778148eb721f1484c44d67eec5d" => :x86_64_linux
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
