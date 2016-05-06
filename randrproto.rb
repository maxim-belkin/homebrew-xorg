# randrproto: Build a bottle for Linuxbrew
class Randrproto < Formula
  desc "X.Org Protocol Headers: randrproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/proto/randrproto-1.5.0.tar.bz2"
  sha256 "4c675533e79cd730997d232c8894b6692174dce58d3e207021b8f860be498468"
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
