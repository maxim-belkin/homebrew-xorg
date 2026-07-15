class LibvaUtils < Formula
  desc "Collection of utilities and examples to exercise VA-API"
  homepage "https://github.com/01org/libva-utils"
  url "https://github.com/intel/libva-utils/releases/download/2.24.0/libva-utils-2.24.0.tar.bz2"
  sha256 "7f066b33f369bdfb5d8f7644d623b4263acc230a438ee380473450d687e3faa8"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any, x86_64_linux: "330ccf409314d3c534a125cadf8d484b5b5dc80b68288f575f2f656e9a50b618"
  end

  depends_on "pkg-config" => :build
  depends_on "libdrm"
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

  test do
    assert_predicate bin/"vainfo", :executable?
  end
end
