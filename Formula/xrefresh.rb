class Xrefresh < Formula
  desc "X.Org Applications: xrefresh"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xrefresh-1.1.0.tar.xz"
  sha256 "29ed592d5ece35a3029004d8c46f3002f92970870a96c11e38baf7f1122b8b5f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d3bdd51230a2632903c4dfd139c02e7e230ce6967901f2a7a6f77ecfff8e6e4e"
  end

  depends_on "pkg-config" => :build
  depends_on "libx11"

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
    assert_predicate bin/"xrefresh", :executable?
  end
end
