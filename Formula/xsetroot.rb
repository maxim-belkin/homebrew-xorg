class Xsetroot < Formula
  desc "X.Org Applications: xsetroot"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xsetroot-1.1.3.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xsetroot-1.1.3.tar.gz"
  sha256 "80dbb0d02807e89294a042298b8a62f9aa0c3a94d89244ccbc35e4cf80fcaaba"

  bottle do
    root_url "https://ghcr.io/v2/maxim-belkin/xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2a643b8f9a996375c0bc74d190eb7432cb72149a80a7a4a2c5951f0d987f3e2f"
  end

  # xmuu x11 xbitmaps xcursor xorgproto
  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "xbitmaps" => :build
  depends_on "libxcursor"
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
end
