class Xsetroot < Formula
  desc "X.Org Applications: xsetroot"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xsetroot-1.1.4.tar.xz"
  sha256 "1315a3f7e9abe06357363b93461e272601f67225ce0bc075c430cce35073362b"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any, x86_64_linux: "34013c3c827d82761fc923b9df5b7b5b2a401038628bca3ba21c8996f21a926b"
  end

  # xmuu x11 xbitmaps xcursor xorgproto
  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "xbitmaps" => :build
  depends_on "libx11"
  depends_on "libxcursor"
  depends_on "libxmu"

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
    assert_predicate bin/"xsetroot", :executable?
  end
end
