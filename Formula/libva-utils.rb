class LibvaUtils < Formula
  desc "Collection of utilities and examples to exercise VA-API"
  homepage "https://github.com/01org/libva-utils"
  url "https://github.com/intel/libva-utils/releases/download/2.6.0/libva-utils-2.6.0.tar.bz2"
  sha256 "2249b5d08bffc3862bbdcc9a6a4827afd504330b8d101564d39fe1a1e7adc426"
  revision 3

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "61558c8682a00748805c37efaf941af606d202f8bd9906f275476b159714cda0"
  end

  depends_on "pkg-config" => :build
  depends_on "libva"
  depends_on "libx11"
  depends_on "wayland"

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
      --enable-tests=yes
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
