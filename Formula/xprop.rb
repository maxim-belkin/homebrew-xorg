class Xprop < Formula
  desc "X.Org Applications: xprop"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xprop-1.2.6.tar.gz"
  sha256 "58ee5ee0c47fa454d3b16312e778c3f549605a8ad0fd0daafc70d2d6174b116d"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "31f9de2ff74d1bd2e43709a503857173508505e1c35bc416806c6505c304c90c"
  end

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
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
end
