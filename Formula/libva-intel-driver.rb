class LibvaIntelDriver < Formula
  desc "Libva Intel driver"
  homepage "https://github.com/intel/intel-vaapi-driver"
  url "https://github.com/intel/intel-vaapi-driver/releases/download/2.4.0/intel-vaapi-driver-2.4.0.tar.bz2"
  sha256 "71e2ddd985af6b221389db1018c4e8ca27a7f939fb51dcdf49d0efcb5ff3d089"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "d56592f7e483ae26a61aa076468b73720485253f2cb79b3c831a09e52867336b" => :x86_64_linux
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
