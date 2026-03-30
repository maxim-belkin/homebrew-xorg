class Xcalc < Formula
  desc "Scientific calculator for X"
  homepage "https://www.x.org/"
  url "https://www.x.org/pub/individual/app/xcalc-1.1.3.tar.xz"
  sha256 "86e157b6174678675a4a912995dccd0ff4e2ce32b01bdd6f91bfe93333324980"
  license "MIT"

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
