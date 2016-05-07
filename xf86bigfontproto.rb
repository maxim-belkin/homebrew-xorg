# xf86bigfontproto: Build a bottle for Linuxbrew
class Xf86bigfontproto < Formula
  desc "X.Org Protocol Headers: xf86bigfontproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/proto/xf86bigfontproto-1.2.0.tar.bz2"
  sha256 "ba9220e2c4475f5ed2ddaa7287426b30089e4d29bd58d35fad57ba5ea43e1648"
  # tag "linuxbrew"

  depends_on "pkg-config"         =>  :build
  depends_on "util-macros"        =>  :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
    ]

    system "./configure", *args
    system "make", "install"
  end
end
