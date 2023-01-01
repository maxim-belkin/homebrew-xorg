class Xvinfo < Formula
  desc "X.Org Applications: xvinfo"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xvinfo-1.1.5.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xvinfo-1.1.5.tar.gz"
  sha256 "76fdc89a4e4207d0069ae3e511b4e30a60fcf86b630d01ef56d32ba5856e76c4"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c51123ebc643db4e1d9c487e34b00e97372ff723d5d4fd6780fd8707090e3f8d"
  end

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "libxv"

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
