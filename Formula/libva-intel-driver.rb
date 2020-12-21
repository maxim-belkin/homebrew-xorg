class LibvaIntelDriver < Formula
  desc "Intel driver (Libva)"
  homepage "https://github.com/intel/intel-vaapi-driver"
  url "https://github.com/intel/intel-vaapi-driver/releases/download/2.4.0/intel-vaapi-driver-2.4.0.tar.bz2"
  sha256 "71e2ddd985af6b221389db1018c4e8ca27a7f939fb51dcdf49d0efcb5ff3d089"
  revision 2

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 "9f7b8fd12c0bcbda395f5d55ee980075ad309d5961b0bf4c831478715d5fb757" => :x86_64_linux
  end

  depends_on "linuxbrew/xorg/libva" => :build
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
