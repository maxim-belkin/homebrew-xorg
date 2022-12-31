class LibvaUtils < Formula
  desc "Collection of utilities and examples to exercise VA-API"
  homepage "https://github.com/01org/libva-utils"
  url "https://github.com/intel/libva-utils/releases/download/2.16.0/libva-utils-2.16.0.tar.bz2"
  sha256 "0e83badff4d675fe619cccb6ad4dca7a048eafe4aabe3bbb2aeb1a91529e4666"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3bd06656407b86438642713a7c78d7ff1a5bd60b8d13a910374ee58c964abcea"
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
