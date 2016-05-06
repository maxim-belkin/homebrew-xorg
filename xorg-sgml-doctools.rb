# xorg-sgml-doctools: Build a bottle for Linuxbrew
class XorgSgmlDoctools < Formula
  desc "X.Org SGML DocTools"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://www.x.org/archive/individual/doc/xorg-sgml-doctools-1.11.tar.gz"
  sha256 "986326d7b4dd2ad298f61d8d41fe3929ac6191c6000d6d7e47a8ffc0c34e7426"
  # tag "linuxbrew"

  depends_on "util-macros"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make", "install"
  end
end
