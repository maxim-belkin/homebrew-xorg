class LibvaIntelDriver < Formula
  desc "Intel driver (Libva)"
  homepage "https://github.com/intel/intel-vaapi-driver"
  url "https://github.com/intel/intel-vaapi-driver/releases/download/2.4.0/intel-vaapi-driver-2.4.0.tar.bz2"
  sha256 "71e2ddd985af6b221389db1018c4e8ca27a7f939fb51dcdf49d0efcb5ff3d089"
  revision 3

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 x86_64_linux: "26cb4759be9e7f9483f4b761e15b9328b0dd91be10318919f80d3f0292d8d2b6"
  end

  depends_on "libva" => :build
  depends_on "pkg-config" => :build
  depends_on "libdrm"
  depends_on "wayland"

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
