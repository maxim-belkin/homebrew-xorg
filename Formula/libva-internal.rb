class LibvaInternal < Formula
  desc "Hardware accelerated video processing library"
  homepage "https://github.com/01org/libva"
  url "https://github.com/intel/libva/releases/download/2.5.0/libva-2.5.0.tar.bz2"
  sha256 "3aa89cd369a506ac4dbe5de7c0ef5da4f3d220bf986403f02fa1f6f702af6878"

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
