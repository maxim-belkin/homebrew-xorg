class Xkbutils < Formula
  desc "X.Org Applications: xkbutils"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xkbutils-1.0.7.tar.xz"
  sha256 "5f37be0ee31ada114415780c562638a1b4f03b385e56449927bf0d5665787a26"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any, x86_64_linux: "5731818c83394fbb227173ca8215af872bf949e06f33b7718dce33302686b0b9"
  end

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
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
    assert_predicate bin/"xkbbell", :executable?
  end
end
