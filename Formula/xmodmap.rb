class Xmodmap < Formula
  desc "X.Org Applications: xmodmap"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xmodmap-1.0.11.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xmodmap-1.0.11.tar.gz"
  sha256 "c4fac9df448b98ac5a1620f364e74ed5f7084baae0d09123700f34d4b63cb5d8"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "00dafec4b762530f4ed2d297a74113f96c9af5ad159c5ed70f7f9828adab29bf"
  end

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
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
