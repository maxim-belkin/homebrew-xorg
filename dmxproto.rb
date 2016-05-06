# dmxproto: Build a bottle for Linuxbrew
class Dmxproto < Formula
  desc "X.Org Protocol Headers: dmxproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/proto/dmxproto-2.3.1.tar.bz2"
  sha256 "e72051e6a3e06b236d19eed56368117b745ca1e1a27bdc50fd51aa375bea6509"
  # tag "linuxbrew"

  depends_on "pkg-config"         =>  :build
  depends_on "util-macros"        =>  :build

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
