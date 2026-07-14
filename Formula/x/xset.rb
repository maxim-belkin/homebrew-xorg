class Xset < Formula
  desc "X.Org Applications: xset"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xset-1.2.6.tar.xz"
  sha256 "623837349ea887bc003f01ee2e4b6b8ddd9c2774f632c6d70eead1b56306b695"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any, x86_64_linux: "b6c9afe4938e04f0523693756d1b4a89796c9a177a287902ad384693cce0c1f5"
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libx11"
  depends_on "libxext"
  depends_on "libxmu"
  depends_on "maxim-belkin/xorg/libxfontcache"

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
    assert_predicate bin/"xset", :executable?
  end
end
