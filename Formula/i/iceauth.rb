class Iceauth < Formula
  desc "X.Org Applications: iceauth"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/iceauth-1.0.11.tar.xz"
  sha256 "9d633cf0d4d1d98e3ef02d18660372958b60a67016e8a72cd04093a8d8f8d4e9"
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
