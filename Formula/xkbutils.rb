class Xkbutils < Formula
  desc "X.Org Applications: xkbutils"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xkbutils-1.0.5.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xkbutils-1.0.5.tar.gz"
  sha256 "b87072f0d7e75f56ee04455e1feab92bb5847aee4534b18c2e08b926150279ff"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bea64d932841ed541431ec4a36174c7aefb4bf17f2bb50b40955ce3eacae23f3"
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
end
