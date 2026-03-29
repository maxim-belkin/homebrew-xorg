class Smproxy < Formula
  desc "X.Org Applications: smproxy"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/smproxy-1.0.8.tar.gz"
  sha256 "5186ccc0f679339325a8670a5ca15e6faf7f6e65501e1e42160e27754f085d94"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7752c03c2b19422dca7ae4a5b8a5ad204e1c26583ed7e48bd85a28d8ffc5e95b"
  end

  depends_on "pkg-config" => :build
  depends_on "libice"
  depends_on "libsm"
  depends_on "libx11"
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
    assert_predicate bin/"smproxy", :executable?
  end
end
