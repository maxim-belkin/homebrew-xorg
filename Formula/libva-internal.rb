class LibvaInternal < Formula
  desc "Hardware accelerated video processing library"
  homepage "https://github.com/01org/libva"
  url "https://github.com/intel/libva/releases/download/2.6.1/libva-2.6.1.tar.bz2"
  sha256 "6c57eb642d828af2411aa38f55dc10111e8c98976dbab8fd62e48629401eaea5"

  livecheck do
    url "https://github.com/intel/libva/releases"
    regex(%r{Latest.*?href="/intel/libva/tree/v?([a-z0-9.]+)}m)
  end

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "18fcda223fafca140f308c5e7131e9a89c16dee3a0311f7f71b2e325af5c7862" => :x86_64_linux
  end

  keg_only <<~EOS
    it provides Libva package without EGL and GLX support. It serves
    the purpose of resolving the circular dependency between Libva and Mesa.
    You should use Libva package provided by the `linuxbrew/xorg/libva`
    formula instead of this one
  EOS

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
      --enable-wayland
      --enable-glx=no
      --enable-docs=no
      --enable-static=no
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
