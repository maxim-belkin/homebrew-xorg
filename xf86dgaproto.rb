# xf86dgaproto: Build a bottle for Linuxbrew
class Xf86dgaproto < Formula
  desc "X.Org Protocol Headers: xf86dgaproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/proto/xf86dgaproto-2.1.tar.bz2"
  sha256 "ac5ef65108e1f2146286e53080975683dae49fc94680042e04bd1e2010e99050"
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
