class Xfd < Formula
  desc "X.Org Applications: xfd"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xfd-1.1.5.tar.xz"
  sha256 "9048aafba291e3baaab2e76fc298195ec58d82827649b9ee60af6838a1059475"
  license "MIT"

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "xorgproto" => :build
  depends_on "fontconfig"
  depends_on "libx11"
  depends_on "libxaw"
  depends_on "libxft"
  depends_on "libxkbfile"
  depends_on "libxmu"
  depends_on "libxrender"
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
    assert_predicate bin/"xfd", :executable?
  end
end
