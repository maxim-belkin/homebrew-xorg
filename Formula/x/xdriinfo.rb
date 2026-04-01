class Xdriinfo < Formula
  desc "X.Org Applications: xdriinfo"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xdriinfo-1.0.8.tar.gz"
  sha256 "bb36240cf0abc68273cd45d4a74039e0c513e24409a9e2554ac80063f089ff26"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "32d786dd7369091fde85b92e29c53ee079727c3863ac46c59c6b10fa7db20ca2"
  end

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "mesa"

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
    assert_predicate bin/"xdriinfo", :executable?
  end
end
