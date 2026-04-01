class Xgamma < Formula
  desc "X.Org Applications: xgamma"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xgamma-1.0.8.tar.gz"
  sha256 "96ab71ea6a6791538324bb4d2014627816d83178a0ac79335d8c9ef25ce59f1d"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "626920406e31a85bdf68ffea3b3efffbe2eb1e3aa93680aa8dd3665efae35747"
  end

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "libxxf86vm"

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
    assert_predicate bin/"xgamma", :executable?
  end
end
