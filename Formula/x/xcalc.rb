class Xcalc < Formula
  desc "Scientific calculator for X"
  homepage "https://www.x.org/"
  url "https://www.x.org/pub/individual/app/xcalc-1.1.3.tar.xz"
  sha256 "86e157b6174678675a4a912995dccd0ff4e2ce32b01bdd6f91bfe93333324980"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4f8e0b727d6f74a632486ae9908b716451ea4aada8afbb55b071a45d90104c55"
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libx11"
  depends_on "libxaw"
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
    assert_predicate bin/"xcalc", :executable?
  end
end
