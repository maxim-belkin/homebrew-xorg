# compositeproto: Build a bottle for Linuxbrew
class Compositeproto < Formula
  desc "X.Org Protocol Headers: compositeproto"
  homepage "http://www.x.org/" ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url    "http://ftp.x.org/pub/individual/proto/compositeproto-0.4.2.tar.bz2"
  sha256 "049359f0be0b2b984a8149c966dd04e8c58e6eade2a4a309cf1126635ccd0cfc"
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
