class Libva < Formula
  desc "Hardware accelerated video processing library"
  homepage "https://github.com/01org/libva"
  url "https://github.com/intel/libva/releases/download/2.6.1/libva-2.6.1.tar.bz2"
  sha256 "6c57eb642d828af2411aa38f55dc10111e8c98976dbab8fd62e48629401eaea5"
  revision 2

  livecheck do
    url "https://github.com/intel/libva/releases"
    regex(%r{latest.*?href="/intel/libva/tree/v?([a-z0-9.]+)}mi)
  end

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "e597771332e505a4a11b30a8ed42ecd8c8835a5a3080cf1cb3fa1c254380b0ff" => :x86_64_linux
  end

  option "with-docs", "Build documentation"
  # option "with-eglx", "Build libva with egl and glx support (use after building mesa)"
  # Trivia: there is a circular dependency with Mesa.
  # Libva has to be installed:
  #  1. before Mesa >> with "disable-glx" >> this package
  #  2. after  Mesa >> without these options
  # Step #2 is hard-coded into mesa (if built with [default] `with-libva`) as a post-installation step
  # Step #2 can be invoked manually here by specifying `with-eglx`

  depends_on "pkg-config" => :build
  depends_on "libdrm"
  depends_on "libx11"
  depends_on "libxext"
  depends_on "libxfixes"
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
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
