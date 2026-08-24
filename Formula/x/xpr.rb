class Xpr < Formula
  desc "X.Org Applications: xpr"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xpr-1.2.1.tar.xz"
  sha256 "0a5b947cd5e3990c9fcd04fdf92603241de4a55a29b89d4e8a0e473320b778ba"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any, x86_64_linux: "41f90b9d2ed4dc21668f5cced70a3fe714252053b500e3516d0d7731e74d605d"
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libx11"
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
    assert_predicate bin/"xpr", :executable?
  end
end
