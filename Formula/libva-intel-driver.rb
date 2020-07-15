class LibvaIntelDriver < Formula
  desc "Libva Intel driver"
  homepage "https://github.com/intel/intel-vaapi-driver"
  url "https://github.com/intel/intel-vaapi-driver/releases/download/2.4.1/intel-vaapi-driver-2.4.1.tar.bz2"
  sha256 "0081fce08eb3a83f7d99c3b853c8fdfa0af437b8f5b0fb7c66faeb83bcbe0c19"

  livecheck do
    url "https://github.com/intel/intel-vaapi-driver/releases"
    regex(%r{Latest.*?href="/intel/intel-vaapi-driver/tree/v?([a-z0-9.]+)}m)
  end

  bottle do
    sha256 "5d6cb7e16619d29f46d47d218304b8104f10c01b139470e298d98d6cc46faec5" => :x86_64_linux
  end

  depends_on "linuxbrew/xorg/libva" => :build
  depends_on "pkg-config" => :build
  depends_on "linuxbrew/xorg/libdrm"
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
