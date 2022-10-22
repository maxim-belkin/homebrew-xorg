class Xprop < Formula
  desc "X.Org Applications: xprop"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xprop-1.2.4.tar.bz2"
  sha256 "8c77fb096e46c60032b7e2bde9492c3ffcc18734f50b395085a5f10bfd3cf753"
  revision 1

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
