class Xset < Formula
  desc "X.Org Applications: xset"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xset-1.2.5.tar.gz"
  mirror "https://ftp.x.org/pub/individual/app/xset-1.2.5.tar.gz"
  sha256 "2068d1356d80c29ce283f0fff5895667b38f24ea95df363d3dde7b8c8a92fffe"

  depends_on "pkg-config" => :build
  depends_on "util-macros" => :build
  depends_on "libxmu" # brings in dep on libxext and libx11
  depends_on "maxim-belkin/xorg/libxfontcache"
  depends_on "maxim-belkin/xorg/libxxf86misc"

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
