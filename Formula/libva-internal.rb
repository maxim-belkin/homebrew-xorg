class LibvaInternal < Formula
  desc "Hardware accelerated video processing library"
  homepage "https://github.com/01org/libva"
  url "https://github.com/intel/libva/releases/download/2.6.0/libva-2.6.0.tar.bz2"
  sha256 "486bb6b5761db6e5a9f4475bd187e0bfa7309944cfc9734d496d41930353d6c5"

  bottle do
    cellar :any_skip_relocation
    sha256 "8e6cc12fe2645cddb78144263b7c86b911b7dfd151059c6cf951a4fe2f0a1f5a" => :x86_64_linux
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
