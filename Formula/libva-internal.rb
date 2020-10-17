class LibvaInternal < Formula
  desc "Hardware accelerated video processing library"
  homepage "https://github.com/01org/libva"
  url "https://github.com/intel/libva/releases/download/2.6.1/libva-2.6.1.tar.bz2"
  sha256 "6c57eb642d828af2411aa38f55dc10111e8c98976dbab8fd62e48629401eaea5"
  revision 2

  livecheck do
    url "https://github.com/intel/libva/releases"
    regex(%r{Latest.*?href="/intel/libva/tree/v?([a-z0-9.]+)}im)
  end

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    cellar :any_skip_relocation
    sha256 "413fb28d0c4f929ed15de325173edac4530e8fbd481ae1b19cffa2be7952eb01" => :x86_64_linux
  end

  keg_only <<~EOS
    it provides Libva package without EGL and GLX support. It serves
    the purpose of resolving the circular dependency between Libva and Mesa.
    You should use Libva package provided by the `linuxbrew/xorg/libva`
    formula instead of this one
  EOS

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
