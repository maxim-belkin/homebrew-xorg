class Xclipboard < Formula
  desc "Clipboard manager for X11"
  homepage "https://www.x.org/"
  url "https://www.x.org/pub/individual/app/xclipboard-1.1.6.tar.xz"
  sha256 "d7c7a74ed0a4c8983b7dd47301a91c3da48e1027e9338705cad5be8d15c0d1f1"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any, x86_64_linux: "fea840ffa004da6faf393d7b09efec13987c317c904c24a9d7b1c2b2596a15bd"
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libx11"
  depends_on "libxaw"
  depends_on "libxkbfile"
  depends_on "libxmu"
  depends_on "libxt"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    assert_predicate bin/"xclipboard", :executable?
  end
end
