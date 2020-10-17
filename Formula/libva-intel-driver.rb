class LibvaIntelDriver < Formula
  desc "Intel driver (Libva)"
  homepage "https://github.com/intel/intel-vaapi-driver"
  url "https://github.com/intel/intel-vaapi-driver/releases/download/2.4.0/intel-vaapi-driver-2.4.0.tar.bz2"
  sha256 "71e2ddd985af6b221389db1018c4e8ca27a7f939fb51dcdf49d0efcb5ff3d089"
  revision 1

  livecheck do
    url "https://github.com/intel/intel-vaapi-driver/releases"
    regex(%r{latest.*?href="/intel/intel-vaapi-driver/tree/v?([a-z0-9.]+)}mi)
  end

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "82b23c9c0ab719124528b8754d3369a38e1a88c13d6e755b6c9a2fa6db145c82" => :x86_64_linux
  end

  depends_on "linuxbrew/xorg/libva" => :build
  depends_on "pkg-config" => :build
  depends_on "libdrm"
  depends_on "linuxbrew/xorg/wayland"

  def install
    ENV["LIBVA_DRIVERS_PATH"] = lib
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-x11
      --enable-wayland
      --enable-hybrid-codec
      --enable-tests
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
