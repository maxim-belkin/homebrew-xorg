class Xmag < Formula
  desc "X.Org Applications: xmag"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xmag-1.0.9.tar.xz"
  sha256 "87d82c0c08c04ef1a9988705a3506295650777b26deae97ada96a1720982c024"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any, x86_64_linux: "7b476425ffb53e2c516973ef7f27b3348248466001d33a4dced9f474ceb8e146"
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "libxaw"
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
    assert_predicate bin/"xmag", :executable?
  end
end
