class Xclipboard < Formula
  desc "Clipboard manager for X11"
  homepage "https://www.x.org/"
  url "https://www.x.org/pub/individual/app/xclipboard-1.1.5.tar.xz"
  sha256 "8e47a4e18a88d47b14e8eb61a5f298687624a38f9decee9988d8b51a20514c45"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "72046406c67d394fb637ab0da2b319f3e722105f0f3705109e17be9e52cd80c2"
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
