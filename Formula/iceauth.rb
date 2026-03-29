class Iceauth < Formula
  desc "X.Org Applications: iceauth"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/iceauth-1.0.10.tar.gz"
  sha256 "f17f373c6e7bfef9cfa4c688f165dfebec7642ad7c6304c5bb3c9bc2bfcde747"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3f97dde8ef84c693a45ba1f1c816f360ed45e039ca2fdfbc6fcc4719e5845022"
  end

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
  depends_on "libice"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-lint=no
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    assert_predicate bin/"iceauth", :executable?
  end
end
