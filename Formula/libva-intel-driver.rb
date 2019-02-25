class LibvaIntelDriver < Formula
  desc "Libva Intel driver"
  homepage "https://cgit.freedesktop.org/vaapi/intel-driver"
  url "https://github.com/intel/intel-vaapi-driver/releases/download/2.3.0/intel-vaapi-driver-2.3.0.tar.bz2"
  sha256 "5c2e5deab024a0a6ae81dfe77ef455542a88d824eda7bfd07684337407ecdfe3"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "4f51114a8b9992929f87b4cb7fa020cc9eca91b5a78651356b390d500fe7890e" => :x86_64_linux
  end

  option "with-static", "Build static libraries (not recommended)"

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
      --enable-static=#{build.with?("static") ? "yes" : "no"}
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
