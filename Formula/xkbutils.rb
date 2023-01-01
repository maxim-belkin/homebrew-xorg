class Xkbutils < Formula
  desc "X.Org Applications: xkbutils"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xkbutils-1.0.5.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xkbutils-1.0.5.tar.gz"
  sha256 "b87072f0d7e75f56ee04455e1feab92bb5847aee4534b18c2e08b926150279ff"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c342e2612ed0edcddb7edf18bef90ad15e759912db2ab5f307dbc3610b5c30e7"
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
