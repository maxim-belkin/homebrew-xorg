class Xbacklight < Formula
  desc "X.Org Applications: xbacklight"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xbacklight-1.2.4.tar.xz"
  sha256 "d4c30b0e6f18c82f387585a737ee3b72d468c927892b08a898c41bc12248e8ee"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fc58c3a7829ab98c11c6df3c68f4d88aaeb9995d19f1a0d5069696dcc10ea61d"
  end

  depends_on "pkg-config" => :build
  depends_on "libxcb"
  depends_on "xcb-util"

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
    assert_predicate bin/"xbacklight", :executable?
  end
end
